@isTest
public class TestCaseMassCloseCase{
   private static final Id caseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('ATC Dealer Service').getRecordTypeId();

   static testmethod void test() {
        Case[] cList1 = TestDataFactory.createTestCases(40,'New','Spam Email');
        Case[] cList2 = TestDataFactory.createTestCases(10,'Work In Progress','Spam Email');
        Case[] cList = new List<Case>();
        cList.addAll(cList1);
        cList.addAll(cList2);       
        Account[] accAux = TestDataFactory.createTestAccounts(1);
        Case testCase = new Case();
        testCase.RecordTypeId = caseRecordTypeId;
        testCase.Subject = 'Test Subject';
        testCase.Description = 'Test Description';
        testCase.AccountId = accAux[0].Id;
        testCase.Priority = 'Low';
        testCase.Origin = 'Phone';
        testCase.Status = 'New';        
        Test.startTest();
        system.debug('D-03791 :Done creating 50 test cases for mass close test');
        CaseComment initComment = new CaseComment(CommentBody = 'test');

        ApexPages.StandardSetController controller = new ApexPages.StandardSetController(cList);
        controller.setSelected(cList);
        system.debug('D-03791 :Testing Mass Close of 50 cases');
        MassCloseCasesController test1 = new MassCloseCasesController (controller);
        test1.setInitCaseComment(initComment);
        test1.setInitCase(testCase);
        Case testCase3 = test1.getInitCase();
        CaseComment testComment = test1.getInitCaseComment();
        Boolean show = test1.getShowPageMessages();
        test1.save();
        Test.stopTest();
   }
}