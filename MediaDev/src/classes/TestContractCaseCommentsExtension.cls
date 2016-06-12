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
private class TestContractCaseCommentsExtension {
   private static final Id RecordTypeAcct = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Major Account').getRecordTypeId();
   private static final Id caseRecordTypeOF = Schema.SObjectType.Case.getRecordTypeInfosByName().get('ATG Order Activity').getRecordTypeId();
   private static final Id caseRecordTypeOE = Schema.SObjectType.Case.getRecordTypeInfosByName().get('ATG Order Entry').getRecordTypeId();

    static testMethod void myUnitTest() {
        Test.startTest();
        

        // create a test account
        Account accAux1         = new Account();
        accAux1.Name         = 'TestAccountGrande';
        accAux1.SVOC_Id__c   = '1010101';
        accAux1.ShippingStreet     = '1 Main St.';
        accAux1.ShippingState    = 'VA';
        accAux1.ShippingPostalCode  = '12345';
        accAux1.ShippingCountry    = 'USA';
        accAux1.ShippingCity      = 'Anytown';
        accAux1.Description      = 'This is a test account';
        accAux1.BillingStreet    = '1 Main St.';
        accAux1.BillingState      = 'VA';
        accAux1.BillingPostalCode  = '12345';
        accAux1.BillingCountry     = 'USA';
        accAux1.BillingCity      = 'Anytown';
        accAux1.AnnualRevenue    = 10000;
        accAux1.ParentId        = null;
        accAux1.RecordTypeId = RecordTypeAcct;
        insert accAux1;   
        
        Contract testContract = new Contract();
        testContract.AccountId = accAux1.Id;
        testContract.ATC_Order_Sys_ID__c = '123456';
        insert testContract;
          
        // create a case
        Case testCaseParent = new Case();
        testCaseParent.RecordTypeId = caseRecordTypeOF;
        testCaseParent.Subject = 'Test Subject Parent';
        testCaseParent.Description = 'Test Description Parent';
        testCaseParent.AccountId = accAux1.Id;
        testCaseParent.Priority = 'Low';
        testCaseParent.Origin = 'Phone';
        testCaseParent.Status = 'New';
        testCaseParent.Contract__c = testContract.Id;
        insert testCaseParent;
        CaseComment com = new CaseComment();
        com.ParentId = testCaseParent.id;
        com.CommentBody= 'testing case comments';
        insert com;
          
        // create a case
        Case testCaseParent2 = new Case();
        testCaseParent2.RecordTypeId = caseRecordTypeOE;
        testCaseParent2.Subject = 'Test Subject Parent';
        testCaseParent2.Description = 'Test Description Parent';
        testCaseParent2.AccountId = accAux1.Id;
        testCaseParent2.Priority = 'Low';
        testCaseParent2.Origin = 'Phone';
        testCaseParent2.Status = 'New';
        testCaseParent2.Order_ID__c = '123456';
        insert testCaseParent2;
        CaseComment com2 = new CaseComment();
        com2.ParentId = testCaseParent2.id;
        com2.CommentBody= 'testing case comments';
        insert com2;        
        
        PageReference pageRef = Page.ContractCaseComments;
        Test.setCurrentPage(pageRef);        
      
        ApexPages.currentPage().getParameters().put('id', testContract.Id);
        
        
        ApexPages.standardController controller = new ApexPages.standardController(testContract);
        // call constructor
        ContractCaseCommentController TestContractCaseCommentController = new ContractCaseCommentController(controller);        
        
        ApexPages.currentPage().getParameters().put('id', testCaseParent2.Id);
        
        
        ApexPages.standardController controller2 = new ApexPages.standardController(testCaseParent2);
        // call constructor
        CaseCommentController TestCaseCommentController = new CaseCommentController(controller2);   
               
        ApexPages.currentPage().getParameters().put('id', testCaseParent.Id);
        
        
        ApexPages.standardController controller3 = new ApexPages.standardController(testCaseParent);
        // call constructor
        CaseCommentController TestCaseCommentController2 = new CaseCommentController(controller3);   
        Test.stopTest();
        
    }
}