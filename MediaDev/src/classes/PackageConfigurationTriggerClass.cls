public with sharing class PackageConfigurationTriggerClass {

    /**
     * findCoOpRecords
     * @param  pkgConfigList:    List of Package Configuration from trigger.old/trigger.new
     * @description:             Method called used to update the Co_op_Package_Configuration__c to true
     */     
    public static void findCoOpRecords(List<Package_Configuration__c> pkgConfigList) {
        Set<Id> odrItmIDs = new Set<Id>();
        Map<Id, List<Package_Configuration__c>> odrItmPkgMap = new Map<Id, List<Package_Configuration__c>>();
        Map<Id, OrderItem> odrItmMap = new Map<Id, OrderItem>();
        List<OrderItem> updateOdrItmLst = new List<OrderItem>();
        for(Package_Configuration__c pkgConfigItr : pkgConfigList){                          //iterate the Package Configuration from trigger.old/trigger.new
            odrItmIDs.add(pkgConfigItr.Order_Product__c);                                    //get Order Product and add to set of Ids to be used to query Package Configuration
        }
        for(Package_Configuration__c pkgConfigItr : [SELECT Id, Order_Product__c, Order_Product__r.Co_op_Package_Configuration__c, 
                                                     Tier_Governor_Co_op_Level_of_Service__c 
                                                     FROM Package_Configuration__c
                                                     WHERE Order_Product__c IN :odrItmIDs]){            
            if(odrItmPkgMap.get(pkgConfigItr.Order_Product__c) == null){                     //if Order Product is not equal to null, insert Order Product Key with value of list of Package Configuration
               odrItmPkgMap.put(pkgConfigItr.Order_Product__c, new List<Package_Configuration__c>()); 
            }
            if(!odrItmMap.keySet().contains(pkgConfigItr.Order_Product__c)){
                odrItmMap.put(pkgConfigItr.Order_Product__c, pkgConfigItr.Order_Product__r);    //if map of Order Item contains Order Product , insert Order Product Key with the related record as its value
            }
            odrItmPkgMap.get(pkgConfigItr.Order_Product__c).add(pkgConfigItr); 
        }
        for(Id odrItmIdItr : odrItmPkgMap.keySet()){
            odrItmMap.get(odrItmIdItr).Co_op_Package_Configuration__c = false;                //setting the initial value as false
            
            for(Package_Configuration__c pkgConfigItr : odrItmPkgMap.get(odrItmIdItr)){
                if(!(pkgConfigItr.Tier_Governor_Co_op_Level_of_Service__c == null ||
                            pkgConfigItr.Tier_Governor_Co_op_Level_of_Service__c.equalsIgnoreCase('Not Applicable'))){
                    odrItmMap.get(odrItmIdItr).Co_op_Package_Configuration__c = true;          //updates Co-op Package Configuration based on condition
                    break;
                }
            }
        }
        update odrItmMap.values();
        System.debug('PackageConfigurationTriggerClass:findCoOpRecords - Order Item Vlaue: ' + odrItmMap.values());
    }
}