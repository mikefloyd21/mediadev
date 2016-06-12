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
private class TestAPControllerExtension {
   private static final Id caseRecordTypeNADA = Schema.SObjectType.Action_Plan__c.getRecordTypeInfosByName().get('Trade Show').getRecordTypeId();
   private static final Id caseRecordTypeATC = Schema.SObjectType.Action_Plan__c.getRecordTypeInfosByName().get('ATC Action Plan').getRecordTypeId();
   private static final Id caseRecordTypeTIM = Schema.SObjectType.Action_Plan__c.getRecordTypeInfosByName().get('TIM Action Plan').getRecordTypeId();
   private static final Id RecordTypeAcct = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Major Account').getRecordTypeId();

    static testMethod void myUnitTest() {
        Test.startTest();
        
        // create some Show Consultants
        Show_Consultant__c ac1 = new Show_Consultant__c();
        ac1.name = 'Advertising Consultant 1';
        insert ac1;
        
        Show_Consultant__c ac2 = new Show_Consultant__c();
        ac1.name = 'Advertising Consultant 2';
        insert ac2;
        
        // create a test account
        Account accAux1         = new Account();
        accAux1.Name         = 'TestAccountRamana';
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
        
        // create a test account
        Account accAux2         = new Account();
        accAux2.Name         = 'TestAccountRamana2';
        accAux2.SVOC_Id__c   = '1010102';
        accAux2.ShippingStreet     = '1 Main St.';
        accAux2.ShippingState    = 'VA';
        accAux2.ShippingPostalCode  = '12345';
        accAux2.ShippingCountry    = 'USA';
        accAux2.ShippingCity      = 'Anytown';
        accAux2.Description      = 'This is a test account';
        accAux2.BillingStreet    = '1 Main St.';
        accAux2.BillingState      = 'VA';
        accAux2.BillingPostalCode  = '12345';
        accAux2.BillingCountry     = 'USA';
        accAux2.BillingCity      = 'Anytown';
        accAux2.AnnualRevenue    = 10000;
        accAux2.ParentId        = null;
        accAux2.RecordTypeId = RecordTypeAcct;
        insert accAux2;   
        
           
        // call constructor
        ConsultantChartController TestChartCtrl = new ConsultantChartController();
        // create a show consultant
        Show_Consultant__c consultant = new Show_Consultant__c();
        consultant.name = 'testConsultant';
        
        // create Action Plans
        Action_Plan__c AP1  = new Action_Plan__c();
        AP1.RecordTypeId = caseRecordTypeNADA;
        AP1.Account__c = accAux1.Id;
        AP1.Trade_Show_Consultant_s__c = 'Advertising Consultant 1;Advertising Consultant 2';
        // API.Action_Plan_Name2__c = 'TestAccountRamana';
        AP1.Discussion_Date__c = System.today();
        
        AP1.Acquisition_Process__c = true;
        AP1.Customer_Handling__c = true;
        AP1.Dealer_Site__c = true;
        AP1.Descriptions__c = true;
        AP1.Digital_Audience_Analysis__c = true;
        AP1.Front_End_Fundamentals_of_Top_Dealership__c = false;
        AP1.Haystak__c = true;
        AP1.HomeNet__c = true;
        AP1.How_Your_Dealership_is_Doing__c = true;
        AP1.KBB__c = true;
        AP1.KBB_CPO__c = true;
        AP1.Learn_How_Consumers_Really_Shop__c = true;
        AP1.Listing_Logic__c = true;
        AP1.Local_Market_Sheets__c = true;
        AP1.Make_My_Deal__c = true;
        AP1.Manheim__c = true;
        AP1.What_s_New_at_AutoTrader_Group__c = true;
        AP1.New_Scorecard__c = true;
        AP1.Other_Reports_Reviewed__c = true;
        AP1.Other_Requested_Info__c = true;
        AP1.Other_What_s_New__c = true;
        AP1.Photos__c = true;
        AP1.Pricing__c = true;
        AP1.Real_Time_Analytics__c = true;
        AP1.Reconditioning__c = true;
        AP1.SEM__c = true;
        AP1.Trade_In_Marketplace_RR__c = true;
        AP1.Trade_In_Marketplace_RI__c = true;
        AP1.Transportation__c = true;
        AP1.Tune_Up_Report__c = true;
        AP1.Used_Scorecard__c = true;
        AP1.vAuto__c = true;
        AP1.Vehicle_Selection__c = true;
        AP1.Vin_Solutions__c = true;
        
        insert AP1;
        
        String apName = AP1.Name;
        String apId = AP1.Id;
        
        Action_Plan__c controllerAP  = new Action_Plan__c();
        
        // PageReference pageRef = Page.success;
        // Test.setCurrentPage(pageRef);
      
        ApexPages.currentPage().getParameters().put('svocId', '1010101');
        
        ApexPages.StandardController svocController = new ApexPages.StandardController(controllerAP);
        APControllerExtension svocExtension = new APControllerExtension(svocController);
        
        List<String> acs = new List<String> { 
          'Advertising Consultant 1', 'Advertising Consultant 2'
        };
        
        svocExtension.LeftSelectedValues = acs;
        svocExtension.MoveRight();
        
        svocExtension.RightSelectedValues = acs;
        svocExtension.MoveLeft();
        
        svocExtension.LeftSelectedValues = acs;
        svocExtension.MoveRight();
        
        PageReference ref = svocExtension.save();
        
        PageReference ref2 = svocExtension.redirect();
        
        ApexPages.currentPage().getParameters().remove('svocId');
        ApexPages.currentPage().getParameters().put('name', apName);
        
        ApexPages.StandardController nameController = new ApexPages.StandardController(controllerAP);
        APControllerExtension nameExtension = new APControllerExtension(nameController);
        
        ApexPages.currentPage().getParameters().remove('name');
        ApexPages.currentPage().getParameters().put('Id', apId);
        
        ApexPages.StandardController idController = new ApexPages.StandardController(controllerAP);
        APControllerExtension idExtension = new APControllerExtension(idController);
        
        ApexPages.currentPage().getParameters().remove('Id');
        ApexPages.currentPage().getParameters().put('leadId', '0');
        
        ApexPages.StandardController leadController = new ApexPages.StandardController(controllerAP);
        APControllerExtension leadExtension = new APControllerExtension(leadController);
        
        
        
        Test.stopTest();
        
    }
}