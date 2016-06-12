@isTest(SeeAllData=true)
class RecentEmployeeUpdatesExporterTest {

   static testmethod void test() {
     
    //set the custom settings since test canont read unless it is annotated as @isTest(SeeAllData=true) 
    AccountTeamSyncSettings__c setting = AccountTeamSyncSettings__c.getOrgDefaults();
     
     //get the last time this job ran succesffully and use that datetime
     //if not use the current datetime
     if (setting == null) {
      throw new ATGException('Could not find EmployeeAssignmentService__c Org CustomSetting');
     }
     else {

     System.Assert(setting.AccountUpdateToEmail__c != null, 'Could not find setting.AccountUpdateToEmail__c');
          System.Assert(setting.AccountUpdateCCEmail__c != null, 'Could not find setting.AccountUpdateCCEmail__c');

     }
     DateTime beforeRecentExportSent = setting.RecentExportSent__c;
    
     Integer batchSize = 100; //reduced from 200 because of limits
   CollectAccountTeamChanges_TestUtilities util = new CollectAccountTeamChanges_TestUtilities();
   Account[] testAccList = TestDataFactory.createTestAccounts(batchSize);
   
   //util.createAccounts(batchSize); replace with test data factory call
   util.createUsers(batchSize);
   //List<AccountTeamMember_History__c> atHistoryList = new List<AccountTeamMember_History__c>();
   // for(integer i = 0; i<batchSize; i++){
   //     atHistoryList.add(util.CreateAccountTeamMemberHistory(testAccList[i],util.testUserList[i],util.Roles[0], false));
   //   }
    //  insert atHistoryList;
     List<AccountTeamMember> atList = new List<AccountTeamMember>();
    for(integer i = 0; i<batchSize; i++){
        atList.add(util.CreateAccountTeamMember(testAccList[i],util.testUserList[i],util.Roles[0]));
      }
      insert atList ;

  //integer count = [SELECT count() From AccountTeamMember_History__c a where a.NeedToSync__c = true and a.Account__c in :testAccList ];
  integer count = [SELECT count() From AccountTeamMember a where a.Account.Id in :testAccList ];

System.AssertEquals(100,count);//reduced from 200 because of limits
     Test.StartTest();
  
      
     
   
// This test runs a scheduled job at midnight Sept. 3rd. 2022

   String CRON_EXP = '0 0 0 3 9 ? 2022';
      String jobId = System.schedule('testRecentEmployeeUpdatesExporterCSV',
     CRON_EXP , 
         new RecentEmployeeUpdatesExporterCSV());

      // Get the information from the CronTrigger API object
      CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, 
         NextFireTime
         FROM CronTrigger WHERE id = :jobId];

      // Verify the expressions are the same
      System.assertEquals(CRON_EXP, 
         ct.CronExpression);

      // Verify the job has not run
      System.assertEquals(0, ct.TimesTriggered);

      // Verify the next time the job will run
      System.assertEquals('2022-09-03 00:00:00', 
         String.valueOf(ct.NextFireTime));
   
   List<String> jobIds = RecentEmployeeUpdatesExporterCSV.scheduleMe15Min();
   System.assert(jobIds.size()> 0);


 
   Test.stopTest();
   
           // count = [SELECT count() From AccountTeamMember_History__c a where a.NeedToSync__c = true and a.Account__c in :util.testAccList ];
           
 //System.AssertEquals(0,count);
 setting = AccountTeamSyncSettings__c.getOrgDefaults();
 System.assertNotEquals(setting.RecentExportSent__c,beforeRecentExportSent);

    System.assertEquals(setting.RecentExportSentMessage__c,'Success','RecentExportSentMessage__c is not correct');
 

   }
   
   
     static testmethod void testInvalidEmailFail() {
     
    //set the custom settings since test canont read unless it is annotated as @isTest(SeeAllData=true) 
    AccountTeamSyncSettings__c setting = AccountTeamSyncSettings__c.getOrgDefaults();
     
     //get the last time this job ran succesffully and use that datetime
     //if not use the current datetime
     if (setting == null) {
      throw new ATGException('Could not find EmployeeAssignmentService__c Org CustomSetting');
     }
     else {

     System.Assert(setting.AccountUpdateToEmail__c != null, 'Could not find setting.AccountUpdateToEmail__c');
          System.Assert(setting.AccountUpdateCCEmail__c != null, 'Could not find setting.AccountUpdateCCEmail__c');

     }
    DateTime beforeRecentExportSent = setting.RecentExportSent__c;
     Integer batchSize = 100; //reduced from 200 because of limits
   CollectAccountTeamChanges_TestUtilities util = new CollectAccountTeamChanges_TestUtilities();
   Account[] testAccList = TestDataFactory.createTestAccounts(batchSize);
   
   //util.createAccounts(batchSize); replace with test data factory call
   util.createUsers(batchSize);
   //List<AccountTeamMember_History__c> atHistoryList = new List<AccountTeamMember_History__c>();
   // for(integer i = 0; i<batchSize; i++){
   //     atHistoryList.add(util.CreateAccountTeamMemberHistory(testAccList[i],util.testUserList[i],util.Roles[0], false));
   //   }
    //  insert atHistoryList;
     List<AccountTeamMember> atList = new List<AccountTeamMember>();
    for(integer i = 0; i<batchSize; i++){
        atList.add(util.CreateAccountTeamMember(testAccList[i],util.testUserList[i],util.Roles[0]));
      }
      insert atList ;

  //integer count = [SELECT count() From AccountTeamMember_History__c a where a.NeedToSync__c = true and a.Account__c in : ];
  integer count = [SELECT count() From AccountTeamMember a where a.Account.Id in :testAccList ];

System.AssertEquals(100,count);//reduced from 200 because of limits
     Test.StartTest();
  
      
     
   
// This test runs a scheduled job at midnight Sept. 3rd. 2022

RecentEmployeeUpdatesExporterCSV exportCSV = new RecentEmployeeUpdatesExporterCSV();
exportCSV.toTestEmail = 'testEmailInvalid';
   String CRON_EXP = '0 0 0 3 9 ? 2022';
      String jobId = System.schedule('testRecentEmployeeUpdatesExporterCSV',
     CRON_EXP , 
         exportCSV);

      // Get the information from the CronTrigger API object
      CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, 
         NextFireTime
         FROM CronTrigger WHERE id = :jobId];

      // Verify the expressions are the same
      System.assertEquals(CRON_EXP, 
         ct.CronExpression);

      // Verify the job has not run
      System.assertEquals(0, ct.TimesTriggered);

      // Verify the next time the job will run
      System.assertEquals('2022-09-03 00:00:00', 
         String.valueOf(ct.NextFireTime));
         

   Test.stopTest();
   
           // count = [SELECT count() From AccountTeamMember_History__c a where a.NeedToSync__c = true and a.Account__c in : ];
            
// System.AssertEquals(200,count);

setting = AccountTeamSyncSettings__c.getOrgDefaults();
 System.assertEquals(setting.RecentExportSent__c,beforeRecentExportSent);

    System.assertNotEquals(setting.RecentExportSentMessage__c,'Success','RecentExportSentMessage__c is not correct');
 


   }
}