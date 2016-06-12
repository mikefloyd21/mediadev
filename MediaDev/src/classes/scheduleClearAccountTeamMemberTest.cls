@istest
class scheduleClearAccountTeamMemberTest {

   static testmethod void test() {
    
      Integer batchSize = 200;
   CollectAccountTeamChanges_TestUtilities util = new CollectAccountTeamChanges_TestUtilities();
   
   util.createAccounts(batchSize);
   util.createUsers(batchSize);
   List<AccountTeamMember_History__c> atHistoryList = new List<AccountTeamMember_History__c>();
    for(integer i = 0; i<batchSize; i++){
        atHistoryList.add(util.CreateAccountTeamMemberHistory(util.testAccList[i],util.testUserList[i],util.Roles[0]));
      }
      insert atHistoryList;
  
     Test.StartTest();
   
   // This test runs a scheduled job at midnight Sept. 3rd. 2022
 scheduleClearDelAccountTeamMemberBatch schedule = new scheduleClearDelAccountTeamMemberBatch();

   String CRON_EXP = '0 0 0 3 9 ? 2022';
      String jobId = System.schedule('testscheduleClearDelAccountTeamMemberBatch',
     CRON_EXP , 
         schedule);
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

       List<String> jobIds = scheduleClearDelAccountTeamMemberBatch.scheduleMe15Min();
   System.assert(jobIds.size()> 0);
   Test.stopTest();



}
}