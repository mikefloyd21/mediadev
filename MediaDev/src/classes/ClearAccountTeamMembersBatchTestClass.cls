@isTest 
public class ClearAccountTeamMembersBatchTestClass {
public static testMethod void testBatch() {
    Integer batchSize = 20;
   CollectAccountTeamChanges_TestUtilities util = new CollectAccountTeamChanges_TestUtilities();
   Account[] testAccList = TestDataFactory.createTestAccounts(batchSize);
   
   util.createAccounts(batchSize);
   util.createUsers(batchSize);
   List<AccountTeamMember_History__c> atHistoryList = new List<AccountTeamMember_History__c>();
    for(integer i = 0; i<batchSize; i++){
        atHistoryList.add(util.CreateAccountTeamMemberHistory(testAccList[i],util.testUserList[i],util.Roles[0]));
      }
      insert atHistoryList;
  

     Test.StartTest();
   ClearDeletedAccountTeamMembersBatch clearAccountTeamChanges = new ClearDeletedAccountTeamMembersBatch();
  

   ID batchprocessid = Database.executeBatch(clearAccountTeamChanges); 
   Test.StopTest();
   integer count = [SELECT count() FROM AccountTeamMember_History__c where Account__c in :util.testAccList];
    System.AssertEquals(count,0);  
   
  
   }
  
   
}