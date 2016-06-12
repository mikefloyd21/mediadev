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
private class TestCaseTriggerHandler {
   private static final Id caseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('ATC Dealer Service').getRecordTypeId();
   private static final Id caseRecordTypeId2 = Schema.SObjectType.Case.getRecordTypeInfosByName().get('ATC DMD').getRecordTypeId();
   private static final Id caseRecordTypeOF = Schema.SObjectType.Case.getRecordTypeInfosByName().get('ATG Order Activity').getRecordTypeId();
   private static final Id caseRecordTypeAcct = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Major Account').getRecordTypeId();
   private static final Id caseRecordTypeOE = Schema.SObjectType.Case.getRecordTypeInfosByName().get('ATG Order Entry').getRecordTypeId();

    static testMethod void myUnitTest() {
        Profile p = [SELECT Id FROM Profile WHERE Name='Integration User']; 
        User u = new User(Alias = 'intUsr', Email='intuser@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/New_York', UserName='intuser@testorg.com');


      System.runAs(u) {
         // The following code runs as user 'u' 
         // running as webmethods profile since most of the code affects cases created by webmethods for Fastlane
         System.debug('Current User: ' + UserInfo.getUserName());
         System.debug('Current Profile: ' + UserInfo.getProfileId());
         Account accAux         = new Account(Name = 'TestAccount',ShippingStreet= '1 Main St.', 
                                            ShippingState    = 'VA',
                                            ShippingPostalCode  = '12345',
                                            ShippingCountry    = 'USA',
                                            ShippingCity      = 'Anytown',
                                            Description      = 'This is a test account',
                                            BillingStreet    = '1 Main St.',
                                            BillingState      = 'VA',
                                            BillingPostalCode  = '12345',
                                            BillingCountry     = 'USA',
                                            BillingCity      = 'Anytown',
                                            AnnualRevenue    = 10000,
                                            ParentId        = null,
                                            RecordTypeId = caseRecordTypeAcct);

        insert accAux;
        
        // any cases created associated with a contract will test addContractWithOrderEntryCase, updateContractWithOrderEntryCase, 
        // testing updateCaseSubjectLineOnQAFail handler
        system.debug('UNIT TEST_addContractWithOrderEntryCase, updateContractWithOrderEntryCase');
        Contract testContract = new Contract();
        testContract.AccountId = accAux.Id;
        testContract.ATC_Order_Sys_ID__c = '123456';
        insert testContract;
        
        Case testCaseqa1 = new Case();
        testCaseqa1.RecordTypeId = caseRecordTypeOF;
        testCaseqa1.Subject = 'QA Test';
        testCaseqa1.Contract__c = testContract.Id;
        testCaseqa1.Task_Type__c = 'Contract FM Config';
        testCaseqa1.Order_ID__c = '123456';
        insert testCaseqa1;
        
        Case testCaseqa2 = new Case();
        testCaseqa2.RecordTypeId = caseRecordTypeOF;
        testCaseqa2.Subject = 'QA Fail';
        testCaseqa2.Contract__c = testContract.Id;
        testCaseqa2.Task_Type__c = 'Inventory - Used';
        insert testCaseqa2;        
        
        system.debug('testCaseqa1'+testCaseqa1);
        system.debug('testCaseqa2'+testCaseqa2);
        
        
        system.debug([select Id,Subject from case where Id =:testCaseqa2.Id] );
        //List <Group> queueUser = [select Name, Id from Group where Name =: 'ESO Contract FM Config' limit 1];
        // testing if user is queue
        Case testCaseqa3 = new Case();
        testCaseqa3.RecordTypeId = caseRecordTypeOF;
        //testCaseqa3.OwnerId = queueUser[0].Id;
        testCaseqa3.Subject = 'QA Test';
        testCaseqa3.Contract__c = testContract.Id;
        testCaseqa3.Task_Type__c = 'Contract FM Config';
        insert testCaseqa3;                
 
        Case testCaseqa4 = new Case();
        testCaseqa4.RecordTypeId = caseRecordTypeOF;
        //testCaseqa4.OwnerId = queueUser[0].Id;
        testCaseqa4.Subject = 'QA Test';
        testCaseqa4.Contract__c = testContract.Id;
        testCaseqa4.Task_Type__c = 'Contract FM Config';
        insert testCaseqa4;      
        
        }
      }
    static testMethod void myUnitTest2() {
        Profile p2 = [SELECT Id FROM Profile WHERE Name='Integration User']; 
        User u2 = new User(Alias = 'intUsr', Email='intuser@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p2.Id, Net_ID__c = 'LXLEWIS',
            TimeZoneSidKey='America/New_York', UserName='intuser@testorg.com');


      System.runAs(u2) {
         // The following code runs as user 'u' 
         // running as webmethods profile since most of the code affects cases created by webmethods for Fastlane
         System.debug('Current User: ' + UserInfo.getUserName());
         System.debug('Current Profile: ' + UserInfo.getProfileId());
         Account accAux         = new Account(Name = 'TestAccount',ShippingStreet= '1 Main St.', 
                                            ShippingState    = 'VA',
                                            ShippingPostalCode  = '12345',
                                            ShippingCountry    = 'USA',
                                            ShippingCity      = 'Anytown',
                                            Description      = 'This is a test account',
                                            BillingStreet    = '1 Main St.',
                                            BillingState      = 'VA',
                                            BillingPostalCode  = '12345',
                                            BillingCountry     = 'USA',
                                            BillingCity      = 'Anytown',
                                            AnnualRevenue    = 10000,
                                            ParentId        = null,
                                            RecordTypeId = caseRecordTypeAcct);

        insert accAux;
        
        // test insertContractCreatedByOwnerFMConfig
        // create case using contract testContract that is FM config task type(testContract that is FM config task type
        Contract testContract2 = new Contract();
        testContract2.AccountId = accAux.Id;
        testContract2.ATC_Order_Sys_ID__c = '111111';
        testContract2.eSO_Created_By__c = 'LXLEWIS';        
        insert testContract2;
        Case testCaseqa16 = new Case();
        testCaseqa16.RecordTypeId = caseRecordTypeOF;
        testCaseqa16.Subject = 'FM Config Unit Test';
        testCaseqa16.Contract__c = testContract2.Id;
        testCaseqa16.Task_Type__c = 'Contract FM Config';
        insert testCaseqa16;
        
        //create case using contract3 without a value in eSO_Created_By__c
        //case should be assigned to ESO Order Entry queue
        Contract testContract3 = new Contract();
        testContract3.AccountId = accAux.Id;
        testContract3.ATC_Order_Sys_ID__c = '222222';
        testContract3.eSO_Created_By__c = '';        
        insert testContract3;
        Case testCaseqa17 = new Case();
        testCaseqa17.RecordTypeId = caseRecordTypeOF;
        testCaseqa17.Subject = 'FM Config Unit Test2';
        testCaseqa17.Contract__c = testContract3.Id;
        testCaseqa17.Task_Type__c = 'Contract FM Config';
        insert testCaseqa17;
        
        //create a case without a contract
        //case should be assigned to ESO Order Entry queue
        Case testCaseqa18 = new Case();
        testCaseqa18.RecordTypeId = caseRecordTypeOF;
        testCaseqa18.Subject = 'FM Config Unit Test3';
        testCaseqa18.Task_Type__c = 'Contract FM Config';
        insert testCaseqa18;
          
        //create case using contract3 with a value in eSO_Created_By__c but user not found
        //case should be assigned to ESO Order Entry queue
        Contract testContract4 = new Contract();
        testContract4.AccountId = accAux.Id;
        testContract4.ATC_Order_Sys_ID__c = '2555555';
        testContract4.eSO_Created_By__c = 'NONETID';        
        insert testContract4;
        Case testCaseNoNet = new Case();
        testCaseNoNet.RecordTypeId = caseRecordTypeOF;
        testCaseNoNet.Subject = 'FM Config Unit Test2';
        testCaseNoNet.Contract__c = testContract4.Id;
        testCaseNoNet.Task_Type__c = 'Contract FM Config';
        insert testCaseNoNet;          
      }
    }          
  static testMethod void myUnitTest3() {
        Profile p2 = [SELECT Id FROM Profile WHERE Name='Integration User']; 
        User u2 = new User(Alias = 'intUsr', Email='intuser@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p2.Id, Net_ID__c = 'LXLEWIS',
            TimeZoneSidKey='America/New_York', UserName='intuser@testorg.com');


      System.runAs(u2) {
         // The following code runs as user 'u'   
                  // running as webmethods profile since most of the code affects cases created by webmethods for Fastlane
         System.debug('Current User: ' + UserInfo.getUserName());
         System.debug('Current Profile: ' + UserInfo.getProfileId());
         Account accAux         = new Account(Name = 'TestAccount',ShippingStreet= '1 Main St.', 
                                            ShippingState    = 'VA',
                                            ShippingPostalCode  = '12345',
                                            ShippingCountry    = 'USA',
                                            ShippingCity      = 'Anytown',
                                            Description      = 'This is a test account',
                                            BillingStreet    = '1 Main St.',
                                            BillingState      = 'VA',
                                            BillingPostalCode  = '12345',
                                            BillingCountry     = 'USA',
                                            BillingCity      = 'Anytown',
                                            AnnualRevenue    = 10000,
                                            ParentId        = null,
                                            RecordTypeId = caseRecordTypeAcct);

        insert accAux;
        
        system.debug('UNIT TEST_createTaskOnContractReject'+accAux);        
        // test insertContractCreatedByOwnerFMConfig
        // create case using contract testContract that is FM config task type(testContract that is FM config task type
        Contract testContract2 = new Contract();
        testContract2.AccountId = accAux.Id;
        testContract2.ATC_Order_Sys_ID__c = '111111';
        testContract2.eSO_Created_By__c = 'LXLEWIS';        
        insert testContract2;//   
        // test createTaskOnContractReject
        system.debug('UNIT TEST_createTaskOnContractReject');
        List <User> webMethUser = [select Name, Id, Net_ID__c from User where Name =: 'webMethods Integration' limit 1];
        //  create account team members
        AccountTeamMember Teammemberad = new AccountTeamMember();
        Teammemberad.AccountId = accAux.id;
        Teammemberad.UserId = u2.id;
        Teammemberad.TeamMemberRole = 'Advertising Consultant - ATC';
        insert Teammemberad;                
        Case testCaseOE = new Case();
        testCaseOE.RecordTypeId = caseRecordTypeOE;
        testCaseOE.OwnerId = webMethUser[0].Id;
        testCaseOE.Subject = 'QA Test';
        testCaseOE.Contract__c = testContract2.Id;
        testCaseOE.Contract_Rejected__c = 'No';        
        insert testCaseOE;             
        
        testCaseOE.Contract_Rejected__c = 'Yes';
        testCaseOE.Contract_Rejection_Comments__c = 'Testing contract reject comments';
        testCaseOE.AccountID = accAux.Id;
        system.debug('UNIT TEST_createTaskOnContractReject- UPDATING TO REJECT CONTRACT');
        system.debug(testCaseOE);
        update testCaseOE; 
        system.debug(testCaseOE);
        system.debug('UNIT updateOrderCasePriorityToContractPriority');
        // test updateOrderCasePriorityToContractPriority
        testContract2.ATC_Priority_Code__c = 'High';
        update testContract2;  
      }
    } 
    static testMethod void myUnitTest4() {
        Profile p = [SELECT Id FROM Profile WHERE Name='Integration User']; 
        User u = new User(Alias = 'intUsr', Email='intuser@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/New_York', UserName='intuser@testorg.com');


      System.runAs(u) {
         // The following code runs as user 'u' 
         // running as webmethods profile since most of the code affects cases created by webmethods for Fastlane
         System.debug('Current User: ' + UserInfo.getUserName());
         System.debug('Current Profile: ' + UserInfo.getProfileId());
         Account accAux         = new Account(Name = 'TestAccount',ShippingStreet= '1 Main St.', 
                                            ShippingState    = 'VA',
                                            ShippingPostalCode  = '12345',
                                            ShippingCountry    = 'USA',
                                            ShippingCity      = 'Anytown',
                                            Description      = 'This is a test account',
                                            BillingStreet    = '1 Main St.',
                                            BillingState      = 'VA',
                                            BillingPostalCode  = '12345',
                                            BillingCountry     = 'USA',
                                            BillingCity      = 'Anytown',
                                            AnnualRevenue    = 10000,
                                            ParentId        = null,
                                            RecordTypeId = caseRecordTypeAcct);

        insert accAux;
        
        // any cases created associated with a contract will test addContractWithOrderEntryCase, updateContractWithOrderEntryCase, 
        // testing updateCaseSubjectLineOnQAFail handler
        system.debug('UNIT TEST_addContractWithOrderEntryCase, updateContractWithOrderEntryCase');
        Contract testContract = new Contract();
        testContract.AccountId = accAux.Id;
        testContract.ATC_Order_Sys_ID__c = '123456';
        insert testContract;
        
        system.debug('UNIT updateParentOnChildClose');
        // Test updateParentOnChildClose
        Case testCaseParent = new Case();
        system.debug('record id'+ caseRecordTypeId);
        testCaseParent.RecordTypeId = caseRecordTypeId;
        testCaseParent.Subject = 'Test Subject Parent';
        testCaseParent.Description = 'Test Description Parent';
        testCaseParent.AccountId = accAux.Id;
        testCaseParent.Priority = 'Low';
        testCaseParent.Origin = 'Phone';
        testCaseParent.Status = 'New';
        insert testCaseParent;
       
        Case testCase = new Case();
        testCase.RecordTypeId = caseRecordTypeId;
        testCase.Subject = 'Test Subject';
        testCase.Description = 'Test Description';
        testCase.AccountId = accAux.Id;
        testCase.Priority = 'Low';
        testCase.Origin = 'Phone';
        testCase.Status = 'New';
        testCase.ParentId = testCaseParent.Id;
        system.debug('Parent id:'+ testCaseParent.Id);

        testCase.ParentId = testCaseParent.Id;
        insert testCase;
        
        testCase.Status = 'Closed';
        Contact testContact = new Contact();
        testContact.FirstName = 'Test';
        testContact.LastName = 'Contact';
        testContact.Email = 'TestContact@hotmail.com';
        testContact.phone = '555-555-5555';
        insert testContact;
        testCase.ContactId = testContact.Id;
        update testCase;
       
        Case testCase2 = new Case();
        testCase2.RecordTypeId = caseRecordTypeId2;
        testCase2.Subject = 'Test Subject';
        testCase2.Description = 'Test Description';
        testCase2.AccountId = accAux.Id;
        testCase2.Priority = 'Low';
        testCase2.Origin = 'Phone';
        testCase2.Status = 'New';
        testCase2.ATC_Co_op__c = 'Yes'; 
        testCase2.ATC_Rework_Approval_Status__c = 'Rejected'; 
        testCase2.Status = 'Design Complete';
        testCase2.ParentId = testCaseParent.Id;
        system.debug('Parent id:'+ testCaseParent.Id);

        testCase2.ParentId = testCaseParent.Id;
        insert testCase2;       
       
        system.debug('Parent Status:'+ testCaseParent.Status);
        system.debug('Parent Priority:'+ testCaseParent.Priority);   
        
        // test update owner in case when back to contract

        testContract.eSO_Created_By__c = 'LXLEWIS';
        testContract.ATC_Order_Sys_ID__c = '444444';
        update testContract;
        Case testCaseqa15 = new Case();
        testCaseqa15.RecordTypeId = caseRecordTypeOF;
        testCaseqa15.Subject = 'QA Test';
        testCaseqa15.Contract__c = testContract.Id;
        testCaseqa15.Task_Type__c = 'Back To Contract';
        testCaseqa15.Order_ID__c = '444444';
        insert testCaseqa15;        
                           
        }
      }    
}