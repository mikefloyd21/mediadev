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
private class TestConsultantChartController {
   private static final Id caseRecordTypeNADA = Schema.SObjectType.Action_Plan__c.getRecordTypeInfosByName().get('Trade Show').getRecordTypeId();
   private static final Id caseRecordTypeATC = Schema.SObjectType.Action_Plan__c.getRecordTypeInfosByName().get('ATC Action Plan').getRecordTypeId();
   private static final Id caseRecordTypeTIM = Schema.SObjectType.Action_Plan__c.getRecordTypeInfosByName().get('TIM Action Plan').getRecordTypeId();
   private static final Id RecordTypeAcct = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Major Account').getRecordTypeId();

    static testMethod void myUnitTest() {
        // create some Show Consultants
        Show_Consultant__c ac1 = new Show_Consultant__c();
        ac1.name = 'Advertising Consultant 1';
        insert ac1;
        
        Show_Consultant__c ac2 = new Show_Consultant__c();
        ac1.name = 'Advertising Consultant 2';
        insert ac2;
        
        // create a test account
        Account accAux         = new Account();
        accAux.Name         = 'TestAccountRamana';
        accAux.ShippingStreet     = '1 Main St.';
        accAux.ShippingState    = 'VA';
        accAux.ShippingPostalCode  = '12345';
        accAux.ShippingCountry    = 'USA';
        accAux.ShippingCity      = 'Anytown';
        accAux.Description      = 'This is a test account';
        accAux.BillingStreet    = '1 Main St.';
        accAux.BillingState      = 'VA';
        accAux.BillingPostalCode  = '12345';
        accAux.BillingCountry     = 'USA';
        accAux.BillingCity      = 'Anytown';
        accAux.AnnualRevenue    = 10000;
        accAux.ParentId        = null;
        accAux.RecordTypeId = RecordTypeAcct;
        insert accAux;      
        // call constructor
        ConsultantChartController TestChartCtrl = new ConsultantChartController();
        // create a show consultant
        Show_Consultant__c consultant = new Show_Consultant__c();
        consultant.name = 'testConsultant';
        // create Action Plans
        Action_Plan__c AP1  = new Action_Plan__c();
        AP1.RecordTypeId = caseRecordTypeNADA;
        AP1.Account__c = accAux.Id;
        AP1.Trade_Show_Consultant_s__c = 'Advertising Consultant 1;Advertising Consultant 2';
        AP1.Discussion_Date__c = System.today();
        
        AP1.Acquisition_Process__c = true;
        AP1.Customer_Handling__c = true;
        AP1.Dealer_Site__c = true;
        AP1.Descriptions__c = true;
        AP1.Digital_Audience_Analysis__c = true;
        AP1.Front_End_Fundamentals_of_Top_Dealership__c = true;
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
        
        Test.startTest();
        // call methods
        TestChartCtrl.getConsultantSummaryData();
        TestChartCtrl.getCountsPerRegion();
        TestChartCtrl.getTotalSummaries();
        TestChartCtrl.getAreasOfFocus();
        TestChartCtrl.getFrontEndFundamentals();
        TestChartCtrl.getReportsReviewed();
        TestChartCtrl.getRequestedInfo();
        TestChartCtrl.getNewAtATCKBB();
        Test.stopTest();
        
        
        
    }
}