@isTest
public class PackageConfigurationTriggerClassTest {
    
    //test if Order Item is updated
    public static testMethod void testUpdatedOrderItem(){   
        Account acctObj = GenerateTestData.createAccount();
        insert acctObj;

        Case caseObj = GenerateTestData.createCase(acctObj.Id);
        insert caseObj;     

        Product2 prodObj = GenerateTestData.createProduct();
        insert prodObj;

        Pricebook2 pbObj = GenerateTestData.createPricebook();
        insert pbObj;

        PricebookEntry pbeObj = GenerateTestData.createPricebookentry(prodObj.Id, pbObj.Id);
        insert pbeObj;

        List<OrderItem> oItemObj = GenerateTestData.createOItem(pbeObj.Id, acctObj.Id, pbObj.Id,null);      
        insert oItemObj;

        List<OrderItem> oItemList = new List<OrderItem>();

        for(OrderItem oItem : oItemObj){
            oItem.Co_op_Package_Configuration__c = false;
            oItemList.add(oItem);   
        }
        update oItemList;       

        Product_Configuration__c prodConfigObj = GenerateTestData.createProductConfig(prodObj.Id);
        insert prodConfigObj;
        
        List<Package_Configuration__c> pkgConfigObj;
        for(OrderItem o : oItemList){
            pkgConfigObj = new List<Package_Configuration__c>();
            pkgConfigObj.addAll(GenerateTestData.createPkgConfig(2, o.Id, prodConfigObj.Id));
        }

        Test.startTest();
        insert pkgConfigObj;
        Test.stopTest();

        List<OrderItem> oItemUpdatedLst = [SELECT Id, Co_op_Package_Configuration__c FROM OrderItem WHERE Id IN: oItemList];
        for(OrderItem updatedOItem: oItemUpdatedLst){
            System.debug('//test: ' + updatedOItem.Co_op_Package_Configuration__c);     
            System.assert(updatedOItem.Co_op_Package_Configuration__c == true);             
        }
    }       
}