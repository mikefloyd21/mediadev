@istest
class scheduleCollectAccountTeamMemberTest {

   static testmethod void test() {
    
       Integer batchSize = 200;
   CollectAccountTeamChanges_TestUtilities util = new CollectAccountTeamChanges_TestUtilities();
   
   util.createAccounts(batchSize);
   util.createUsers(batchSize);
   List<AccountTeamMember> atList = new List<AccountTeamMember>();
    for(integer i = 0; i<batchSize; i++){
        atList.add(util.CreateAccountTeamMember(util.testAccList[i],util.testUserList[i],util.Roles[0]));
      }
      insert atList;
     String testAccounts ='';
   
     for(integer i = 0; i<batchSize; i++){
        
        testAccounts += '\'' + util.testAccList[i].id + '\',';
     
     }
     
     //remove the last comma
     testAccounts = testAccounts.subString(0,testAccounts.length()-1);
     
     DateTime lastRunDateTime = Date.today().addDays(-1);
     System.debug('testAccounts:'+testAccounts);
     Test.StartTest();
   CollectAccountTeamMebersBatch collectAccountTeamChanges = new CollectAccountTeamMebersBatch();
   String query = 'Select a.UserId, a.TeamMemberRole, a.LastModifiedDate, a.IsDeleted, a.Account.Id From AccountTeamMember a where a.LastModifiedDate >='+
       +lastRunDateTime.format('yyyy-MM-dd\'T\'hh:mm:ss\'Z\'') +
       ' and a.Account.Id  in ('+testAccounts+')'+
       ' and a.TeamMemberRole = '+
       '\'Advertising Consultant - ATC\'';
       System.debug('query:'+query);
       
   collectAccountTeamChanges.Query = query;
   
   // This test runs a scheduled job at midnight Sept. 3rd. 2022
 scheduleCollectAccountTeamMemberBatch schedule = new scheduleCollectAccountTeamMemberBatch();
 schedule.collectAccountTeamChanges = collectAccountTeamChanges;
   String CRON_EXP = '0 0 0 3 9 ? 2022';
      String jobId = System.schedule('testscheduleCollectAccountTeamMember',
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

       List<String> jobIds = scheduleCollectAccountTeamMemberBatch.scheduleMe15Min();
   System.assert(jobIds.size()> 0);
   Test.stopTest();



}
}