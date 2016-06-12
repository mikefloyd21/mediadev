@isTest(SeeAllData=true)
private class Event_Task_Last_In_Person_TEST {

    static testMethod void myUnitTest() {
        
        Profile pro = [SELECT Id FROM Profile WHERE Name = 'COE System Admin'];
        
        User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
          emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
          localesidkey = 'en_US', profileid = pro.Id,  
          timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
          
        insert u_testMethodUser;
        
        System.runas(u_testMethodUser) {
          
          Account a = new Account(Name = 'TestAccount',  BillingStreet = '123 Elm', BillingState = 'KS', BillingCity = 'Test', BillingPostalCode ='66212', Current_AC__c = 'Test Method User' );
          
          insert a;
          
          Task t = new Task(Subject= 'TestTask', Type =  'In Person Visit', WhatId = a.id, Date_Completed__c  = system.today(), OwnerId = u_testMethodUser.Id, Priority = 'Normal', Status = 'Completed', ActivityDate = system.today() );
          insert t;
          
          Event e = new Event(Subject= 'TestEvent', Type =  'In Person Visit',  WhatId = a.id, Meeting_Status__c = 'Completed', OwnerId = u_testMethodUser.Id, DurationInMinutes = 60, ActivityDateTime = system.now() );
          insert e;
          
          test.startTest();
          
   
          
          test.stopTest();
          
          
        }
    }
}