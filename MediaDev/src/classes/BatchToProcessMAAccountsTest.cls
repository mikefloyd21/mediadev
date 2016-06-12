@isTest
public class BatchToProcessMAAccountsTest {
    public static testMethod  void myUnitTest(){
        Test.startTest();
        TestUtility.createTestAccounts();
        TestUtility.createTestTerritories();
        TestUtility.createTestPositions();
        TestUtility.createTestPositionAccounts();
        Test.StopTest();
        Database.executeBatch(new BatchToProcessMARecords());
    }
}