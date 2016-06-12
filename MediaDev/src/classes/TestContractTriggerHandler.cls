/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class TestContractTriggerHandler {
	
   private static final Id caseRecordTypeAcct = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Major Account').getRecordTypeId();
   private static final Id caseRecordTypeOF = Schema.SObjectType.Case.getRecordTypeInfosByName().get('ATG Order Activity').getRecordTypeId();

    static testMethod void myUnitTest() 
    {
        Account accAux         = new Account();
        accAux.Name         = 'TestAccountRamana';
        accAux.ShippingStreet     = '1 Main St.';
        accAux.ShippingState    = 'VA';
        accAux.ShippingPostalCode  = '12345';
        accAux.ShippingCountry    = 'USA';
        accAux.ShippingCity      = 'Anytown';
        accAux.Description      = 'This is a test account';
        accAux.BillingStreet    = '1 Main St.';
        accAux.BillingState      = 'VA';
        accAux.BillingPostalCode  = '12345';
        accAux.BillingCountry     = 'USA';
        accAux.BillingCity      = 'Anytown';
        accAux.AnnualRevenue    = 10000;
        accAux.ParentId        = null;
        accAux.RecordTypeId = caseRecordTypeAcct;
        insert accAux;
        
        // testing updateESOCreatedby
        List <User> webMethUser = [select Name, Id, Net_ID__c from User where Name =: 'webMethods Integration' limit 1];
        webMethUser[0].Net_ID__c = 'lgran';
        update webMethUser[0];
               
        system.debug('UNIT TEST_updateESOCreatedby');
        Contract testContract = new Contract();
        testContract.AccountId = accAux.Id;
        testContract.eSO_Created_By__c  = 'lgran';
        testContract.ATC_Order_Sys_ID__c = '999999';
        insert testContract;    
        
        // testing createDMDFulfillmentCase
        system.debug('UNIT TEST_createDMDFulfillmentCase');
        Contract testContract2 = new Contract();
        testContract2.AccountId = accAux.Id;
        testContract2.Co_Op__c = 'Yes';
        testContract2.ATC_Contract_Status__c = 'PREVIEW';
        testContract2.ATC_Order_Sys_ID__c = '888888';
        insert testContract2;        
        
        testContract2.ATC_Contract_Status__c = 'DELIVERED';
        testContract2.ATC_Order_Sys_ID__c = '888888';
        update testContract2;  
        
        // testing updateCasePriorityWithContractPriority
        system.debug('UNIT TEST_updateCasePriorityWithContractPriority');
        Contract testContract3 = new Contract();
        testContract3.AccountId = accAux.Id;
        testContract3.ATC_Order_Sys_ID__c = '777777';
        testContract3.ATC_Priority_Code__c = 'High';
        insert testContract3;    
        
        // test updateCaseWithOrderContract
        system.debug('UNIT TEST_addContractWithOrderEntryCase, updateContractWithOrderEntryCase');
        Contract testContract4 = new Contract();
        testContract4.AccountId = accAux.Id;
        insert testContract4;
        
        testContract4.ATC_Order_Sys_ID__c = '123456';
        update testContract4;
        
        Case testCaseqa1 = new Case();
        testCaseqa1.RecordTypeId = caseRecordTypeOF;
        testCaseqa1.Subject = 'QA Test';
        testCaseqa1.Contract__c = testContract4.Id;
        testCaseqa1.Task_Type__c = 'Contract FM Config';
        testCaseqa1.Order_ID__c = '123456';
        insert testCaseqa1;
        
        // test addCaseWithOrderContract
        Case testCaseqa11 = new Case();
        testCaseqa11.RecordTypeId = caseRecordTypeOF;
        testCaseqa11.Subject = 'QA Test';
        testCaseqa11.Task_Type__c = 'Contract FM Config';
        testCaseqa11.Order_ID__c = '333444';
        insert testCaseqa11;        
        Contract testContract41 = new Contract();
        testContract41.AccountId = accAux.Id;
        testContract41.ATC_Order_Sys_ID__c = '333444';
        insert testContract41;
        
        // test deleting old cases from contract, so change contract id after it already existed.
        Case testCaseqa12 = new Case();
        testCaseqa12.RecordTypeId = caseRecordTypeOF;
        testCaseqa12.Subject = 'QA Test';
        testCaseqa12.Contract__c = testContract41.Id;
        testCaseqa12.Task_Type__c = 'Contract FM Config';
        testCaseqa12.Order_ID__c = '878787';
        insert testCaseqa12;        
        testContract41.ATC_Order_Sys_ID__c = '878787';
        update testContract41;
        
        
      }
}