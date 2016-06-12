@isTest(SeeAllData=true)
public class TestCaseUpdateParent{
   private static final Id caseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('ATC Dealer Service').getRecordTypeId();
   private static final Id caseRecordTypeId2 = Schema.SObjectType.Case.getRecordTypeInfosByName().get('ATC DMD').getRecordTypeId();

   static testmethod void test() {
        Account[] accAux = TestDataFactory.createTestAccounts(1);

        Case testCaseParent = new Case();
        system.debug('record id'+ caseRecordTypeId);
        testCaseParent.RecordTypeId = caseRecordTypeId;
        testCaseParent.Subject = 'Test Subject Parent';
        testCaseParent.Description = 'Test Description Parent';
        testCaseParent.AccountId = accAux[0].Id;
        testCaseParent.Priority = 'Low';
        testCaseParent.Origin = 'Phone';
        testCaseParent.Status = 'New';
        insert testCaseParent;
       
        Case testCase = new Case();
        testCase.RecordTypeId = caseRecordTypeId;
        testCase.Subject = 'Test Subject';
        testCase.Description = 'Test Description';
        testCase.AccountId = accAux[0].Id;
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
        testContact.Phone = '555-555-5555';
        insert testContact;
        testCase.ContactId = testContact.Id;
        update testCase;
       
        Case testCase2 = new Case();
        testCase2.RecordTypeId = caseRecordTypeId2;
        testCase2.Subject = 'Test Subject';
        testCase2.Description = 'Test Description';
        testCase2.AccountId = accAux[0].Id;
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


        testCase2.Status = 'QA Complete';

        update testCase2;       

        
        system.debug('Parent Status:'+ testCaseParent.Status);
        system.debug('Parent Priority:'+ testCaseParent.Priority);
  
   }
}