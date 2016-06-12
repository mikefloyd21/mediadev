@isTest

public class TestTandC {
  private static final Id RecordTypeAcct = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Dealer').getRecordTypeId();

static testMethod void testDelete() {
    Account[] accAux = TestDataFactory.createTestAccounts(1);
    Test.startTest();

    //create a test account
    Account testTCAcct = accAux[0]; //using test data factory
    testTCAcct.RecordTypeId = RecordTypeAcct;
    update testTCAcct;     
    
     //create a test contact
     Contact testContact = new Contact();
     testContact.FirstName = 'Test';
     testContact.LastName = 'Contact';
     testContact.Email = 'TestContact@gmail.com';
     testContact.Phone = '555-555-5555'; //added phone on contact for validation rule
     testContact.AccountId = testTCAcct.Id;
     insert testContact;
     
    
    //create a test terms and condition
    Terms_Conditions__c testTC = new Terms_Conditions__c();
    testTC.Account__c = testTCAcct.Id;
    testTC.Agreement_Status__c = 'Ready to Sign';
    testTC.Contact__c = testContact.Id;
    testTC.EchoSign_Template_Id__c = 'a0vL00000019RrD';
    testTC.Name = 'Advertising Relationship Agreement Test-2015-05-05';
    testTC.T_C_Type__c = 'Advertising Relationship Agreement (ARA)'; 
    insert testTC;
    system.debug('T & C Id: '+ testTC.Id);
    
    //edit testTC with agreement status = 'Ready to Sign'    
    ApexPages.StandardController stdEditController = new ApexPages.StandardController(testTC);
    TermsConditionsEditController tcEdit = new TermsConditionsEditController(stdEditController);
    PageReference testPageEdit = Page.TermsConditionsEditPageSense;
    Test.setCurrentPage( testPageEdit );
    ApexPages.currentPage().getParameters().put( 'id', testTC.Id );    
    testPageEdit = tcEdit.getRedir();   
    system.debug('Completed Edit for Id: '+ testTC.Id);    
    
    //edit testTC with agreement status = 'Out for Signature'
    testTC.Agreement_Status__c = 'Out for Signature';
    update testTC;
    ApexPages.StandardController stdEditController2 = new ApexPages.StandardController(testTC);
    TermsConditionsEditController tcEdit2 = new TermsConditionsEditController(stdEditController2);    
    PageReference testPageEdit2 = Page.TermsConditionsEditPageSense;
    Test.setCurrentPage( testPageEdit2 );
    ApexPages.currentPage().getParameters().put( 'id', testTC.Id );    
    testPageEdit2 = tcEdit2.getRedir();   
    system.debug('Completed Edit2 for Id: '+ testTC.Id);
    
    
    //delete testTC
    ApexPages.StandardController stdController = new ApexPages.StandardController(testTC);
    TermsConditionsDeleteController tcDelete = new TermsConditionsDeleteController(stdController);
    PageReference testPage = Page.TermsConditionsDeletePageSense;
    Test.setCurrentPage( testPage );
    ApexPages.currentPage().getParameters().put( 'id', testTC.Id );    
    system.debug('Page Id: '+ ApexPages.currentPage().getParameters().put( 'id', testTC.Id ));
    testPage = tcDelete.getRedir();   
    
    Test.stopTest();
    
    }
}