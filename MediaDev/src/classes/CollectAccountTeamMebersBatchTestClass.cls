@isTest(SeeAllData=true)
public class CollectAccountTeamMebersBatchTestClass {
public static testMethod void testBatch() {


 //set the custom settings since test canont read unless it is annotated as @isTest(SeeAllData=true) 
    AccountTeamSyncSettings__c setting = AccountTeamSyncSettings__c.getOrgDefaults();
     //get the last time this job ran succesffully and use that datetime
     //if not use the current datetime
     if (setting == null) {
      throw new ATGException('Could not find AccountTeamSyncSettings__c Org settings');
     }
     else {

     System.debug('setting.RecentChangesCollect__c:'+setting.RecentChangesCollect__c);
     }
     DateTime beforeRecentChangesCollect = setting.RecentChangesCollect__c;
    
    Integer batchSize = 20;
   CollectAccountTeamChanges_TestUtilities util = new CollectAccountTeamChanges_TestUtilities();
   Account[] testAccList = TestDataFactory.createTestAccounts(batchSize);
   
   //util.createAccounts(batchSize); replaced with testdatafactory call
   util.createUsers(batchSize);
   List<AccountTeamMember> atList = new List<AccountTeamMember>();
    for(integer i = 0; i<batchSize; i++){
        atList.add(util.CreateAccountTeamMember(testAccList[i],util.testUserList[i],util.Roles[0]));
      }
      insert atList;
     String testAccounts ='';
   
     for(integer i = 0; i<batchSize; i++){
        
        testAccounts += '\'' + testAccList[i].id + '\',';
     
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
   ID batchprocessid = Database.executeBatch(collectAccountTeamChanges); 
   Test.StopTest();
   integer count = [SELECT count() FROM AccountTeamMember_History__c where Account__c in :testAccList];
    System.AssertEquals(count,batchSize);  
    setting = AccountTeamSyncSettings__c.getOrgDefaults();
    //System.assertNotEquals(setting.RecentChangesCollect__c,beforeRecentChangesCollect );
  
   }
   
   public static testMethod void testBatchWhenHistoryRecordExists() {
   
   //set the custom settings since test canont read unless it is annotated as @isTest(SeeAllData=true) 
    AccountTeamSyncSettings__c setting = AccountTeamSyncSettings__c.getOrgDefaults();
     //get the last time this job ran succesffully and use that datetime
     //if not use the current datetime
     if (setting == null) {
      throw new ATGException('Could not find AccountTeamSyncSettings__c Org settings');
     }
     else {

     System.debug('setting.RecentChangesCollect__c:'+setting.RecentChangesCollect__c);
     }
     DateTime beforeRecentChangesCollect = setting.RecentChangesCollect__c;
    
    Integer batchSize = 20;
   CollectAccountTeamChanges_TestUtilities util = new CollectAccountTeamChanges_TestUtilities();
   Account[] testAccList = TestDataFactory.createTestAccounts(batchSize);
   
   //util.createAccounts(batchSize);
   util.createUsers(batchSize);
   List<AccountTeamMember> atList = new List<AccountTeamMember>();
    for(integer i = 0; i<batchSize; i++){
        atList.add(util.CreateAccountTeamMember(testAccList[i],util.testUserList[i],util.Roles[0]));
      }
      insert atList;
      
      List<AccountTeamMember_History__c  > atHistoryList = new List<AccountTeamMember_History__c  >();
    for(integer i = 0; i<batchSize/2; i++){
        atHistoryList.add(util.CreateAccountTeamMemberHistory(testAccList[i],util.testUserList[i],util.Roles[0]));
      }
      insert atHistoryList;  
      
     String testAccounts ='';
   
     for(integer i = 0; i<batchSize; i++){
        
        testAccounts += '\'' + testAccList[i].id + '\',';
     
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
   ID batchprocessid = Database.executeBatch(collectAccountTeamChanges); 

   
  
   Test.StopTest();

 integer  count = [SELECT count() FROM AccountTeamMember_History__c where Account__c in :testAccList];
    System.AssertEquals(count,batchSize);  
        setting = AccountTeamSyncSettings__c.getOrgDefaults();
    //System.assertNotEquals(setting.RecentChangesCollect__c,beforeRecentChangesCollect );
   }
   
   
  
   
   
}