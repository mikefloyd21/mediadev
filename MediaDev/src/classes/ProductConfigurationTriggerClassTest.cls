/**
 * This class contains unit tests for Validating that Product should have 
 * only one product configuration.
 * The @isTest class annotation indicates this class only contains testmethods.
 */   
@isTest
public with sharing class ProductConfigurationTriggerClassTest {
    
    //Test method for testing whether the trigger throwing exception
    //when we try to add more than one ProductConfiguration to Product.
      public static testmethod void restrictProductConfig() {
        
        Product2 prodObj = GenerateTestData.createProduct();
        insert prodObj;
        
        //first product configuration inserts to product
        Product_Configuration__c prodConfigObj = GenerateTestData.createProductConfig(prodObj.Id);
        insert prodConfigObj;
        
        //while inserting second product configuration record to same product
        //we should get 'FIELD_CUSTOM_VALIDATION_EXCEPTION'
        Product_Configuration__c prodConfigObj2 = GenerateTestData.createProductConfig(prodObj.Id);
        test.StartTest();
        try { 
            insert prodConfigObj2;    
        } 
        catch (Exception ex) {
            System.Assert(ex.getMessage().contains('FIELD_CUSTOM_VALIDATION_EXCEPTION'));     //error found while inserting second record
        }
        test.stopTest();
          
    }
   
}