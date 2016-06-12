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
private class TestTaskTriggerHandler {
   private static final Id caseRecordTypeAcct = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Major Account').getRecordTypeId();
   private static final Id orderEntryCaseRT = Schema.SObjectType.Case.getRecordTypeInfosByName().get('ATG Order Entry').getRecordTypeId();
    static testMethod void myUnitTestLastInPerson() {
      Profile p = [SELECT Id FROM Profile WHERE Name='ATC Sales User']; 
      User u = new User(Alias = 'testserv', Email='testserviceuser@testorg.com',emailencodingkey='UTF-8',lastname='Testing', 
      languagelocalekey='en_US', profileid = p.id, localesidkey='en_US',timezonesidkey='America/New_York',  CommunityNickname = 'Testing', 
      username='serviceuser@testorg.com');     

        //create account
        Account accAux         = new Account();
        accAux.Name         = 'TestAccountCaseHandler';
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
        accAux.Last_In_Person__c = null;
        accAux.SVOC_Id__c = '999999';
        insert accAux;
        system.debug('Account:'+accAux);
        
        Case testCaseOE1 = new Case();
        testCaseOE1.AccountId = accAux.Id;
        testCaseOE1.RecordTypeId = orderEntryCaseRT;
        testCaseOE1.Subject = 'QA Test';
        testCaseOE1.Contract_Placed_On_Hold__c = 'Yes';        
        insert testCaseOE1;               
              
      System.runAs(u) //run as sales user
      {
        // The following code runs as user 'u' 
        System.debug('Current User: ' + UserInfo.getUserName());
        
        //  create task for last in person visit - testing no ACs
        Task t = new Task();
        t.OwnerId =  u.Id;
        t.WhatId = accAux.id;
        t.Type = 'In Person Visit';
        t.Date_Completed__c = date.today()-2;
        system.debug('INSERTING TASK:'+t);               
        insert t;
        system.debug('ACCOUNT:'+accAux);               
        //system.assertEquals(accAux.Last_In_Person__c, date.today()-2);   
        
        //  create account team members
        AccountTeamMember Teammemberad = new AccountTeamMember();
        Teammemberad.AccountId = accAux.id;
        Teammemberad.UserId = u.id;
        Teammemberad.TeamMemberRole = 'Advertising Consultant - ATC';
        insert Teammemberad;        
        
        //  create task for last in person visit - testing with AC - ATC
        Task t2 = new Task();
        t2.OwnerId =  u.Id;
        t2.WhatId = accAux.id;
        t2.Type = 'In Person Visit';
        t2.Date_Completed__c = date.today()-1;
        insert t2;                      
        //system.assertEquals(accAux.Last_In_Person__c, date.today()-1);   
        
        //  create account team members
        AccountTeamMember Teammemberad2 = new AccountTeamMember();
        Teammemberad2.AccountId = accAux.id;
        Teammemberad2.UserId = u.id;
        Teammemberad2.TeamMemberRole = 'Advertising Consultant - Major Accounts';
        insert Teammemberad2;        
        
        //  create task for last in person visit - testing with AC - Major Accounts
        Task t3 = new Task();
        t3.OwnerId =  u.Id;
        t3.Type = 'In Person Visit';
        t3.WhatId = accAux.id;
        t3.Date_Completed__c = date.today();
        insert t3;   
        //system.assertEquals(accAux.Last_In_Person__c, date.today());   
        
        // The following code runs as user 'u' 
        System.debug('Current User: ' + UserInfo.getUserName());
        
        //  create task for Last Outbound Call - testing no Inside Sales
        Task t4 = new Task();
        t4.OwnerId =  u.Id;
        t4.WhatId = accAux.id;
        t4.Type = 'Outbound Call/Fax';
        t4.Date_Completed__c = date.today()-2;
        system.debug('INSERTING TASK:'+t);               
        insert t4;
        system.debug('ACCOUNT:'+accAux);               
        //system.assertEquals(accAux.Last_Outbound_Call__c, date.today()-2);   
        
        //  create account team members
        AccountTeamMember Teammemberad3 = new AccountTeamMember();
        Teammemberad3.AccountId = accAux.id;
        Teammemberad3.UserId = u.id;
        Teammemberad3.TeamMemberRole = 'Inside Account Manager - ATC';
        insert Teammemberad3;        
        
        //  create task for last outbound call - testing with Inside Account Manager - ATC
        Task t5 = new Task();
        t5.OwnerId =  u.Id;
        t5.WhatId = accAux.id;
        t5.Type = 'Outbound Call/Fax';
        t5.Date_Completed__c = date.today()-1;
        insert t5;                      
        //system.assertEquals(accAux.Last_Outbound_Call__c, date.today()-1);   
        
        //  create account team members
        AccountTeamMember Teammemberad4 = new AccountTeamMember();
        Teammemberad4.AccountId = accAux.id;
        Teammemberad4.UserId = u.id;
        Teammemberad4.TeamMemberRole = 'Inside Sales Consultant - ATC';
        insert Teammemberad4;        
        
        //  create task for last outbound call - testing with Inside Sales Consultant - ATC
        Task t6 = new Task();
        t6.OwnerId =  u.Id;
        t6.Type = 'Outbound Call/Fax';
        t6.WhatId = accAux.id;
        t6.Date_Completed__c = date.today();
        insert t6;   
        //system.assertEquals(accAux.Last_Outbound_Call__c, date.today());
        
        // The following code runs as user 'u' 
        System.debug('Current User: ' + UserInfo.getUserName());
        
        //  create task for last email - testing for this doesn't require account team members/roles to be assigned
        Task t7 = new Task();
        t7.OwnerId =  u.Id;
        t7.WhatId = accAux.id;
        t7.Type = 'Email';
        t7.Date_Completed__c = date.today()-2;
        system.debug('INSERTING TASK:'+t);               
        insert t7;
        system.debug('ACCOUNT:'+accAux);               
        //system.assertEquals(accAux.Last_Email__c, date.today()-2);
        
        // The following code runs as user 'u' 
        System.debug('Current User: ' + UserInfo.getUserName());
        
        //  create task for last inbound call/fax - testing for this doesn't require account team members/roles to be assigned
        Task t8 = new Task();
        t8.OwnerId =  u.Id;
        t8.WhatId = accAux.id;
        t8.Type = 'Inbound Call/Fax';
        t8.Date_Completed__c = date.today()-2;
        system.debug('INSERTING TASK:'+t);               
        insert t8;
        system.debug('ACCOUNT:'+accAux);               
        //system.assertEquals(accAux.Last_Inbound_Call__c, date.today()-2);
        
        // The following code runs as user 'u' 
        System.debug('Current User: ' + UserInfo.getUserName());
        
        //  create task for last online meeting - testing for this doesn't require account team members/roles to be assigned
        Task t9 = new Task();
        t9.OwnerId =  u.Id;
        t9.WhatId = accAux.id;
        t9.Type = 'Online Meeting';
        t9.Date_Completed__c = date.today()-2;
        system.debug('INSERTING TASK:'+t);               
        insert t9;
        system.debug('ACCOUNT:'+accAux);               
        //system.assertEquals(accAux.Last_Online_Meeting__c, date.today()-2);
        
        // The following code runs as user 'u' 
        System.debug('Current User: ' + UserInfo.getUserName());
        
        //  create task for last service - testing for this doesn't require account team members/roles to be assigned
        Task t10 = new Task();
        t10.OwnerId =  u.Id;
        t10.WhatId = accAux.id;
        t10.Type = 'Service';
        t10.Date_Completed__c = date.today()-2;
        system.debug('INSERTING TASK:'+t);               
        insert t10;
        system.debug('ACCOUNT:'+accAux);               
        //system.assertEquals(accAux.Last_Service__c, date.today()-2);
        
        // The following code runs as user 'u' 
        System.debug('Current User: ' + UserInfo.getUserName());
        
        //  create task for last task - testing for this doesn't require account team members/roles to be assigned
        Task t11 = new Task();
        t11.OwnerId =  u.Id;
        t11.WhatId = accAux.id;
        t11.Type = 'Task';
        t11.Date_Completed__c = date.today()-2;
        system.debug('INSERTING TASK:'+t);               
        insert t11;
        system.debug('ACCOUNT:'+accAux);               
        //system.assertEquals(accAux.Last_Task__c, date.today()-2);
      }     
    }
    static testMethod void myUnitTestTaskCase() {
        system.debug('TESTING CASE TASK:');               
        Case[] testCase = TestDataFactory.createTestCases(1,'New','No Action');
        testCase[0].RecordTypeId = orderEntryCaseRT;
        testCase[0].Contract_Placed_On_Hold__c = 'Yes'; 
        testCase[0].Status = 'Work In Progress';
        update testCase[0];
        //testing
        Task tOE = new Task();
        tOE.WhatId = testCase[0].id;
        tOE.Type = 'Email';
        tOE.ActivityDate = date.today();
        
        system.debug('INSERTING TASK:'+tOE);               
        insert tOE;
        
        //test contract on hold thread
        tOE.Status = 'Completed';
        update tOE;
    }    
}