/*
Author: Ramana Mosali
Date: 08/11/2013
Notes: Test coverage for SVOCRequest_Redirect Page, SVOC Request Create Page & SVOCRequest_Controller class
*/

@isTest
private class testSVOCRequest_Controller{

        static PageReference SVOCRequestpage(string recordType)
        {
            string svocRequestRecordTypeId = '';        
            Map<ID, Schema.RecordTypeInfo> rtMap = Schema.SObjectType.SVOC_Request__c.getRecordTypeInfosById();
            for(String key : rtMap.keySet())
            {
                if (recordType == rtMap.get(key).getName())
                {
                    svocRequestRecordTypeId  = key;
                }                
            }
                    System.assert(svocRequestRecordTypeId != '');
            //https://cs7.salesforce.com/a0W/e?retURL=%2Fa0W%2Fo&RecordType=012M00000008u7T&ent=01IM00000005AJe
            PageReference myPage = new PageReference('/a0W/e');
            // set the recordType
            myPage.getParameters().put('RecordType', svocRequestRecordTypeId  ); 
            myPage.getParameters().put('ent', '01IM00000005AJe'); 
            return myPage;
        }

    static testMethod void testredirectCustomPageForCreate(){

      //create SVOC_Request__c for type create
       SVOC_Request__c createSVOCRequest = new SVOC_Request__c();
          string svocRequestRecordTypeId = '';        
            Map<ID, Schema.RecordTypeInfo> rtMap = Schema.SObjectType.SVOC_Request__c.getRecordTypeInfosById();
            for(String key : rtMap.keySet())
            {
                if ('Create' == rtMap.get(key).getName())
                {
                    svocRequestRecordTypeId  = key;
                }                
            }
        //System.assert(svocRequestRecordTypeId != '');    
        createSVOCRequest.RecordTypeId = svocRequestRecordTypeId;
       //createSVOCRequest.RecordTypeId = '012M00000008u7O';
       //createSVOCRequest.Name = 'testCreateSVOCRequest';
              
        /* Switch to runtime context */
        Test.startTest();
        
        PageReference SVOCRequest_RedirectPage= SVOCRequestpage('Create');//(new ApexPages.StandardController(createSVOCRequest)).new();
        //SVOCRequest_RedirectPage.getParameters().put( 'RecordType', createSVOCRequest.RecordTypeId );
        Test.setCurrentPage( SVOCRequest_RedirectPage);
        
    

        
        // Instanciate Controller
        SVOCRequest_Controller controller = new SVOCRequest_Controller(new ApexPages.StandardController(createSVOCRequest));
        
        
        PageReference  redirectResult = controller.redirectDefaultSVOCRequest();
        string returnURL=  Page.SVOCRequestCreate.getUrl();        
        //System.assert(redirectResult.getUrl().contains(returnURL));
        
        
        test.stopTest();
    }
    
        static testMethod void testredirectCustomPageForNonCreate(){

      //maintainSVOC_Request__c for type create
       SVOC_Request__c maintainSVOCRequest = new SVOC_Request__c();
                 string svocRequestRecordTypeId = '';        
            Map<ID, Schema.RecordTypeInfo> rtMap = Schema.SObjectType.SVOC_Request__c.getRecordTypeInfosById();
            for(String key : rtMap.keySet())
            {
                if ('Maintain' == rtMap.get(key).getName())
                {
                    svocRequestRecordTypeId  = key;
                }                
            }
        //System.assert(svocRequestRecordTypeId != '');    
        maintainSVOCRequest.RecordTypeId = svocRequestRecordTypeId;

              
        /* Switch to runtime context */
        Test.startTest();
        
        PageReference SVOCRequest_RedirectPage= SVOCRequestpage('Maintain');

        Test.setCurrentPage( SVOCRequest_RedirectPage);
        
    

        
        // Instanciate Controller
        SVOCRequest_Controller controller = new SVOCRequest_Controller(new ApexPages.StandardController(maintainSVOCRequest));
        
        
        PageReference  redirectResult = controller.redirectDefaultSVOCRequest();
        string returnURL=  Page.SVOCRequestCreate.getUrl();        
       //System.assert(redirectResult.getUrl().contains(returnURL) != true);
        
        
        test.stopTest();
    }
      static testMethod void testredirectCustomPageForCreateEdit(){

      //create SVOC_Request__c for type create
       SVOC_Request__c createSVOCRequest = new SVOC_Request__c();
          string svocRequestRecordTypeId = '';        
            Map<ID, Schema.RecordTypeInfo> rtMap = Schema.SObjectType.SVOC_Request__c.getRecordTypeInfosById();
            for(String key : rtMap.keySet())
            {
                if ('Create' == rtMap.get(key).getName())
                {
                    svocRequestRecordTypeId  = key;
                }                
            }
        //System.assert(svocRequestRecordTypeId != '');    
        createSVOCRequest.RecordTypeId = svocRequestRecordTypeId;
       //createSVOCRequest.RecordTypeId = '012M00000008u7O';
       //createSVOCRequest.Name = 'testCreateSVOCRequest';
        insert createSVOCRequest;
        /* Switch to runtime context */
        Test.startTest();
        
        //PageReference SVOCRequest_RedirectPage= SVOCRequestpage('Create');
        PageReference SVOCRequest_RedirectPage=(new ApexPages.StandardController(createSVOCRequest)).Edit();
          SVOCRequest_RedirectPage.getParameters().put( 'Id', createSVOCRequest.Id );
        SVOCRequest_RedirectPage.getParameters().put( 'RecordType', createSVOCRequest.RecordTypeId );
        Test.setCurrentPage( SVOCRequest_RedirectPage);
        
    

        
        // Instanciate Controller
        SVOCRequest_Controller controller = new SVOCRequest_Controller(new ApexPages.StandardController(createSVOCRequest));
        
        
        PageReference  redirectResult = controller.redirectDefaultSVOCRequest();
        string returnURL=  Page.SVOCRequestCreate.getUrl();        
        //System.assert(redirectResult.getUrl().contains(returnURL));
        
        
        test.stopTest();
    }
    
       static testMethod void testredirectCustomPageForNonCreateEdit(){

      //maintain SVOC_Request__c for type create
       SVOC_Request__c mainatainSVOCRequest = new SVOC_Request__c();
          string svocRequestRecordTypeId = '';        
            Map<ID, Schema.RecordTypeInfo> rtMap = Schema.SObjectType.SVOC_Request__c.getRecordTypeInfosById();
            for(String key : rtMap.keySet())
            {
                if ('Maintain' == rtMap.get(key).getName())
                {
                    svocRequestRecordTypeId  = key;
                }                
            }
        //System.assert(svocRequestRecordTypeId != '');    
        mainatainSVOCRequest.RecordTypeId = svocRequestRecordTypeId;
       //createSVOCRequest.RecordTypeId = '012M00000008u7O';
       //createSVOCRequest.Name = 'testCreateSVOCRequest';
        insert mainatainSVOCRequest;
        /* Switch to runtime context */
        Test.startTest();
        
        //PageReference SVOCRequest_RedirectPage= SVOCRequestpage('Create');
        PageReference SVOCRequest_RedirectPage=(new ApexPages.StandardController(mainatainSVOCRequest)).Edit();
          SVOCRequest_RedirectPage.getParameters().put( 'Id', mainatainSVOCRequest.Id );
        SVOCRequest_RedirectPage.getParameters().put( 'RecordType', mainatainSVOCRequest.RecordTypeId );
        Test.setCurrentPage( SVOCRequest_RedirectPage);
        
    

        
        // Instanciate Controller
        SVOCRequest_Controller controller = new SVOCRequest_Controller(new ApexPages.StandardController(mainatainSVOCRequest));
        
        
        PageReference  redirectResult = controller.redirectDefaultSVOCRequest();
        string returnURL=  Page.SVOCRequestCreate.getUrl();        
        //System.assert(redirectResult.getUrl().contains(returnURL) != true);
        
        
        test.stopTest();
    }
    
    
            static testMethod void testAccountDupeCheck(){

        //create an account
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
        accAux.RecordTypeId = '012E000000052TQ';
        insert accAux;
        
        //try  creating a createRequest 
        
      //createSVOC_Request__c for type create
       SVOC_Request__c createSVOCRequest = new SVOC_Request__c();
    /* createSVOCRequest.New_Customer_Name__c =  accAux.Name;
     createSVOCRequest.Street_Name__c = accAux.BillingStreet;
  createSVOCRequest.State__c = accAux.BillingState;
     createSVOCRequest.City__c =  accAux.BillingCity;
   createSVOCRequest.Zip_Code__c = accAux.BillingPostalCode; */
   createSVOCRequest.New_Customer_Name__c =  'Ramey Test 3.1.2';
     createSVOCRequest.Street_Name__c ='195 TECHNOLOGY DR Suite 200';
  createSVOCRequest.State__c = 'CA';
     createSVOCRequest.City__c =  'Irvine';
   createSVOCRequest.Zip_Code__c = '92618'; 
   
          
                 string svocRequestRecordTypeId = '';        
            Map<ID, Schema.RecordTypeInfo> rtMap = Schema.SObjectType.SVOC_Request__c.getRecordTypeInfosById();
            for(String key : rtMap.keySet())
            {
                if ('Create' == rtMap.get(key).getName())
                {
                    svocRequestRecordTypeId  = key;
                }                
            }
        //System.assert(svocRequestRecordTypeId != '');    
        createSVOCRequest.RecordTypeId = svocRequestRecordTypeId;
        
        //Create request with same name, address

               System.debug('$$$$$$$$$$$$RecordTypeId $$$$$$$$$$$$$$$$$');
               System.debug(svocRequestRecordTypeId);
        /* Switch to runtime context */
        Test.startTest();
        
        PageReference SVOCRequest_RedirectPage= SVOCRequestpage('Create');

        Test.setCurrentPage( SVOCRequest_RedirectPage);
        
    

        
        // Instanciate Controller
        SVOCRequest_Controller controller = new SVOCRequest_Controller(new ApexPages.StandardController(createSVOCRequest ));
        //SVOCRequest_Controller controller = new SVOCRequest_Controller();
        
        PageReference  redirectResult = controller.redirectDefaultSVOCRequest();
      
        //System.assert(redirectResult.getUrl().contains(Page.SVOCRequestCreate.getUrl()) == true);
        
        //Test.setCurrentPage(redirectResult);
        
        PageReference  saveResultPage= controller.saveSVOCRequest();
        List<Account> dupWarningAccountsLists = controller.dupWarningAccountsList;
       // System.Assert(dupWarningAccountsLists.size() > 0);
         Boolean flag = controller.dupsFound;
         //System.Assert(flag);
        if(saveResultPage != null)
        {
         System.debug('$$$$$$$$$$$$New URL$$$$$$$$$$$$$$$$$');
           System.debug(saveResultPage.getUrl());
        //check save did not create and it is on the same page
        //System.assert(redirectResult.getUrl().contains(Page.SVOCRequestCreate.getUrl()));
        }
        test.stopTest();
    }
    
    
}