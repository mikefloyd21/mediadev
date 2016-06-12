/**
 *@author Original: Cloud Sherpas, Last Modified: Cherrie Mae Llada - Cloud Sherpas/Auto Trader
 *@description: Trigger class used to create Cases and assign to queue with its related Order Product/s, if the Order Signature Date was updated from null to a date value
 */

public with sharing class OrderTriggerClass {

    static String RT_DEFAULT;
    static Boolean updateHaystakOpp;
    static Case orderEntryCase;
    static Set<Id> orderIds = new Set<Id>();
    static Map<Id,Order> newOrderMap;
    static List<Case> orderCaseList;
    static List<Group> grpList = new List<Group>([SELECT Id, Name FROM Group WHERE Name != NULL AND Type = 'Queue']);
        
    /**
     * afterUpdate
     * @param  oldOrder:    map of old record from trigger.newMap
     * @param  newOrder:    map of new record from trigger.newMap
     * @description:        Method called after updating the Order records
     */    
    public static void afterUpdate(Map<Id,Order> oldOrder, Map<Id,Order> newOrder){        
        orderCaseList = new List<Case>();
        Map<String,Group> grpMap = new Map<String,Group>();        
        newOrderMap = new Map<Id,Order>([SELECT Id, AccountId, Account.Region__c, OrderNumber,
            (SELECT Id, PricebookEntry.Product2.Id, PricebookEntry.Product2.TIM_Product__c, PricebookEntry.Product2.Haystak_Product__c, PricebookEntry.Product2.Family 
                FROM OrderItems) FROM Order WHERE Id IN : newOrder.keyset()]);
                
        RT_DEFAULT = ApexUtil.getActiveSObjectRecordTypes('Case',false).get('ATG_Order_Entry');
        
        for(Order orderRec : newOrder.Values()){                        //iterate all the Order records from trigger.newMap            
            Boolean withDealCase = false;                               //for each loop, set a parameter that no case is yet created for each Order record       
            Boolean withTimCase = false;  
            Boolean haystakProduct = false;
            if(oldOrder.get(orderRec.Id).Signature_Date__c == null){    //check if OLD Signature date is null                
                if(orderRec.Id == oldOrder.get(orderRec.Id).Id){        //check the Case record in which Signature date has been changed                    
                    //check if Signature date has been changed from null to value
                    if(orderRec.Signature_Date__c != oldOrder.get(orderRec.Id).Signature_Date__c){                         
                        orderIds.add(orderRec.Id);                      //create a set of Order Id to be use in updateOppStage method
                        //check if Region is equals to 35, 43 or 44                     
                        if(Constants.REGION_MAJOR_ACCOUNT.contains(newOrderMap.get(orderRec.Id).Account.Region__c)){                            
                            orderEntryCase = new Case();                                        
                            defaultCaseValues();                                          
                            orderEntryCase.AccountId = orderRec.AccountId;                
                            orderEntryCase.Case_Order__c = orderRec.Id;                            
                            orderEntryCase.OwnerId = grpInfo('SA Major Accounts').Id;           //ASSIGN NEW CASE TO MAJOR ACCOUNT QUEUE      
                            orderCaseList.add(orderEntryCase);                             
                        } 
                        else{                            
                            for(OrderItem oItem : newOrderMap.get(orderRec.Id).OrderItems){     //iterate all the Order Items for each Orders 
                                if(oItem.PricebookEntry.Product2.Haystak_Product__c == true && !haystakProduct){
                                haystakProduct = true;
                                updateHaystakOpp = true;
                                break;
                                }
                                orderEntryCase = new Case();   
                                defaultCaseValues();             
                                orderEntryCase.AccountId = orderRec.AccountId;
                                orderEntryCase.Case_Order__c = orderRec.Id;     
                                
                                if(oItem.PricebookEntry.Product2.TIM_Product__c == true && !withTimCase){                                                                  
                                    orderEntryCase.OwnerId = grpInfo('ESO TIM Order Entry').Id;  //ASSIGN NEW CASE TO TIM QUEUE     
                                    withTimCase = true;
                                }
                                else if(!withDealCase){   
                                    orderEntryCase.OwnerId = grpInfo('ESO Order Entry').Id;    //ASSIGN NEW CASE TO DEALER QUEUE   
                                    withDealCase = true;  
                                    updateHaystakOpp = false;                                  
                                }
                                orderCaseList.add(orderEntryCase);  //add all the Case record in a list,
                                                                    //this list consists of records to be inserted in the Case object,
                                                                    //and will be used in removeCase method  
                           }
                        } 
                    }
                }
            }
        }          
        
        if(!orderCaseList.isEmpty()){            
            insert orderCaseList;                                    //Insert new case if the list of new cases (orderCaseList) is not empty            
            updateOrderProduct(orderCaseList,newOrderMap);           //Update the Order Product related to the Case created            
            removeCase();                                            //delete cases not assigned to SA MAJOR ACCOUNT or ESO TIM ORDER ENTRY or ESO DEAL BUILDER ORDER ENTRY, if any            
            updateOppStage();                                        //update Opportunity Stage field once the cases are all created and assigned       
        } else if(orderCaseList.isEmpty() && updateHaystakOpp == true){
             updateOppStage();
        }                    
    }   
   
    /**
     * defaultCaseValues
     * @description:        Method that holds the default values for creating new Cases
     */
    public static void defaultCaseValues(){
        orderEntryCase.RecordTypeId = RT_DEFAULT;
        orderEntryCase.Priority = Constants.LOW;
        orderEntryCase.Status = Constants.STRING_NEW;
        orderEntryCase.Origin = Constants.INTERNAL;
        orderEntryCase.Contract_Rejected__c = Constants.NO;
        orderEntryCase.Contract_Placed_on_Hold__c = Constants.NO; 
        orderEntryCase.Subject = 'Digital Order';           
    }

    /**
     * grpInfo
     * @param  grpName:     Group/Queue name
     * @return groupRec:    Active Group/Queue name
     * @description:        Method called when assigning Cases to Queue
     */    
    public static Group grpInfo(String grpName){
        Group groupRec = new Group();
        for(Group grp : grpList){
            if(grp.Name == grpName){
                groupRec = grp;
            }
        }   
        return groupRec;      
    }    
    
    /**
     * updateOrderProduct
     * @param  caseList:     List of Case records from trigger.newMap
     * @param  orderList:    Map of Order from trigger.newMap
     * @description:         Method called used to relate the Order Product to Case based on the criteria of assigning Cases to Queue
     */    
    public static void updateOrderProduct(List<Case> caseList, Map<Id,Order> orderList){ 
        List<OrderItem> oItemList = new List<OrderItem>(); 
        List<OrderItem> oItemCtr = new List<OrderItem>();
        for(Case orderCase : caseList){            
            if(orderList.get(orderCase.Case_Order__c).Id != null){
                for(OrderItem oItem : orderList.get(orderCase.Case_Order__c).OrderItems){  
                Boolean isAdded =false;                       
                    if(Constants.REGION_MAJOR_ACCOUNT.contains(orderList.get(orderCase.Case_Order__c).Account.Region__c)){
                        oItem.Case__c = orderCase.Id;           //Relate the Order Product to the Case assigned to MAJOR ACCOUNT QUEUE
                        isAdded = true;                                                                
                    } else if(oItem.PricebookEntry.Product2.TIM_Product__c == true && orderCase.OwnerId == grpInfo('ESO TIM Order Entry').Id){  
                        oItem.Case__c = orderCase.Id;           //Relate the Order Product to the Case assigned to TIM QUEUE
                        isAdded = true;                    
                    } else if(oItem.PricebookEntry.Product2.TIM_Product__c != true && orderCase.OwnerId == grpInfo('ESO Order Entry').Id && oItem.PricebookEntry.Product2.Haystak_Product__c != true){
                            oItem.Case__c = orderCase.Id;       //Relate the Order Product to the Case assigned to DEALER QUEUE
                            isAdded = true;
                    } 

                    Boolean isExisting = false;
                    for(OrderItem o : oItemCtr){
                        System.debug('//test: compare ' + o.Id + '==' + oItem.Id);
                        if(o.Id == oItem.Id){
                            isExisting = true;
                            System.debug('//test: isExisting TRUE');
                        }
                    }

                    if(!isExisting){
                        if(isAdded){                            
                            oItemList.add(oItem);               //list of Order Item to be updated                            
                            oItemCtr.add(oItem);                //list of Order Item that is added to the list of Order Item for updating
                        }
                    }
                }
            }
        }

        if(!oItemList.isEmpty()){ 
            update new List<OrderItem>(new Set<OrderItem>(oItemList));
        }       
        
    }    

    /**
     * removeCase
     * @description:         Method called used to delete Cases that are not assigned to MAJOR ACCOUNT QUEUE, TIM QUEUE or DEALER QUEUE,
     *                       this instance happen when no criteria was met upon iterating of Order from trigger.newMap,
     *                       a case is created and assigned to the user.
     */        
    public static void removeCase(){        
        List<Case> caseForDeletion = new List<Case>();
        List<Case> cList = [SELECT Id, OwnerId FROM Case WHERE Id IN: orderCaseList];        
        for(Case c : cList){                    //iterate the Case from the list of Case created from the Orders that Signature Date was updated
            if((c.OwnerId != grpInfo('SA Major Accounts').Id && c.OwnerId != grpInfo('ESO TIM Order Entry').Id && c.OwnerId != grpInfo('ESO Order Entry').Id) || c.OwnerId == null){
                caseForDeletion.add(c);
            }        
        }
        delete caseForDeletion;     
    }
        
    /**
     * updateOppStage
     * @description:         Method called used to update the Opportunity Stage field once the Cases were created and assigned
     */        
    public static void updateOppStage(){
        Set<Id> ordOppIds = new Set<Id>();
        List<Opportunity> oppForUpdate = new List<Opportunity>();
        List<Order> oLst = [SELECT Id, OpportunityId FROM Order WHERE Id IN: orderIds];   
        for(Order o : oLst){                   //iterate the Order from the list of Orders that Signature Date was updated 
            ordOppIds.add(o.OpportunityId);
        }
        
        //get the Opportunity for updating Stage
        List<Opportunity> oppLst = [SELECT Id, StageName FROM Opportunity WHERE Id IN: ordOppIds];        
        for(Opportunity opp : oppLst){                        //iterate the Opportunity from the list            
            opp.StageName = Constants.OPPORTUNITY_STAGE;      //set the Opportunity Stage field to 'Contract Submitted'
            oppForUpdate.add(opp);
        }
        update oppForUpdate;
    }   

}