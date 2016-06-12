@isTest
public class OrderTriggerClassTest {

    public static Account acctObj;
    public static Order orderObj;
    public static Product2 prodObj;
    public static Opportunity oppObj;
    public static Pricebook2 pbObj;
    public static PricebookEntry pbeObj;    
    public static Case caseObj;
    public static List<Case> caseLst;
    public static List<Order> oLst;
    public static List<Order> orderLst;
    public static List<OrderItem> oItemObj;    
    
    //method to used for setting up data for test methods
    private static void setupData(){
        acctObj = GenerateTestData.createAccount();
        insert acctObj;

        oppObj = GenerateTestData.createOpp(acctObj.Id);
        insert oppObj;

        prodObj = GenerateTestData.createProduct();
        insert prodObj;

        pbObj = GenerateTestData.createPricebook();
        insert pbObj;

        pbeObj = GenerateTestData.createPricebookentry(prodObj.Id, pbObj.Id);
        insert pbeObj;

        oItemObj = GenerateTestData.createOItem(pbeObj.Id, acctObj.Id, pbObj.Id, oppObj.Id);
        insert oItemObj;       
    }

    //test case assigned to Major Account Queue
    public static testMethod void testMajorAccountCase(){ 
        setupData();
        acctObj.Region__c = '35';
        update acctObj;

        oLst = [SELECT Id FROM Order WHERE Id IN: GenerateTestData.ordrLst];
        orderLst = new List<Order>();
        for(Order oItem : oLst){
            oItem.Signature_Date__c = Date.today();            
            orderLst.add(oItem);            
        }

        Test.startTest();
        update orderLst;
        Test.stopTest();

        Group grp = [SELECT Id, Name FROM Group WHERE Name = 'SA Major Accounts' AND Type = 'Queue'];     

        for(Order o : orderLst){
            for(Case cc : [SELECT Id, OwnerId, Case_Order__c FROM Case WHERE Case_Order__c =: o.Id]){
                Id queueName = cc.OwnerId;
                System.debug('test queueName: ' + queueName + '==' + grp.Id);

                System.assert(queueName == grp.Id);
            }
        }
    }

    //test case assigned to TIM Queue
    public static testMethod void testTimCase(){  
        setupData();
        prodObj.TIM_Product__c = true;
        update prodObj;

        oLst = [SELECT Id FROM Order WHERE Id IN: GenerateTestData.ordrLst];
        orderLst = new List<Order>();
        for(Order oItem : oLst){          
            oItem.Signature_Date__c = Date.today();  
            orderLst.add(oItem);

        }

        Test.startTest();
        update orderLst;
        Test.stopTest();

        Group grp = [SELECT Id, Name FROM Group WHERE Name = 'ESO TIM Order Entry' AND Type = 'Queue'];     

        for(Order o : orderLst){
            for(Case cc : [SELECT Id, OwnerId, Case_Order__c FROM Case WHERE Case_Order__c =: o.Id]){
                Id queueName = cc.OwnerId;
                System.debug('test queueName: ' + queueName + '==' + grp.Id);

                System.assert(queueName == grp.Id);
            }
        }
    }

    //test case assigned to DEALER Queue
    public static testMethod void testDealerCase(){  
        setupData();                    

        oLst = [SELECT Id FROM Order WHERE Id IN: GenerateTestData.ordrLst];
        orderLst = new List<Order>();
        for(Order oItem : oLst){
            oItem.Signature_Date__c = Date.today();            
            orderLst.add(oItem);            
        }
        
        Test.startTest();
        update orderLst;
        Test.stopTest();       

        Group grp = [SELECT Id, Name FROM Group WHERE Name = 'ESO Order Entry' AND Type = 'Queue'];     

        for(Order o : orderLst){
            for(Case cc : [SELECT Id, OwnerId, Case_Order__c FROM Case WHERE Case_Order__c =: o.Id]){
                Id queueName = cc.OwnerId;
                System.debug('test queueName: ' + queueName + '==' + grp.Id);

                System.assert(queueName == grp.Id);
            }
        }       
    }    

    //test if Opportunity Stage was updated
    public static testMethod void testOppStageUpdate(){
        setupData();

        oLst = [SELECT Id FROM Order WHERE Id IN: GenerateTestData.ordrLst];
        orderLst = new List<Order>();
        for(Order oItem : oLst){
            oItem.Signature_Date__c = Date.today();
            orderLst.add(oItem);
        }

        Test.startTest();
        update orderLst;

        Set<Id> ordOppIds = new Set<Id>();
        List<Order> orLst = [SELECT Id, OpportunityId FROM Order WHERE Id IN: orderLst];
        for(Order o : orLst){
            ordOppIds.add(o.OpportunityId);
        }
        Test.stopTest();

        List<Opportunity> oppLst = [SELECT Id, StageName FROM Opportunity WHERE Id IN: ordOppIds];
        for(Opportunity opp : oppLst){
            System.debug('//test: StageName ' + opp.StageName);
            System.assert(opp.StageName == 'Contract Submitted');
        }    
    }    
}