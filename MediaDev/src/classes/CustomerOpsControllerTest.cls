/**
 * This class contains unit tests for validating the behavior of 
 * VisualForce Extensions.
 * The @isTest class annotation indicates this class only contains testmethods.
 */   
    @isTest
    public class CustomerOpsControllerTest{
         
        public static Case testCase {get; set;}
        public static PricebookEntry pricebookEntryObj {get; set;}
        public static Product2 productobj {get; set;}
        public static Product2 productobj2 {get; set;}
        public static Pricebook2 pricebookObj {get; set;}
        public static PricebookEntry pricebookEntryObj2{get; set;}
        public static List<OrderItem> orderItemlist{get; set;}
        public static Account accountObj {get; set;}
        public static Order orderObj{get; set;}
        public static Product_Configuration__c productConfig{get; set;}
        public static Package_Configuration__c packageConfigObj{get; set;}
        
        //Test method for testing whether OrderItems is related to Case on
        //what we are working.
        public static testmethod void testOrderItem()
        {
            Test.startTest();
            //Takes data from GenerateTestData class
            accountObj=GenerateTestData.createAccount();
            insert accountObj;
           
            testCase = GenerateTestData.createCase(accountObj.Id);
            insert testCase;
           
            productobj = GenerateTestData.createProduct();
            insert productobj;
           
            pricebookObj = GenerateTestData.createPricebook();
            insert pricebookObj;
            
            pricebookEntryObj = GenerateTestData.createPricebookentry(productobj.Id,pricebookObj.Id);
            insert pricebookEntryObj;
            
            productConfig=GenerateTestData.createProductConfig(productobj.Id);
            insert productConfig;
           
            orderItemlist=GenerateTestData.createOrderItem(testCase.Id,pricebookEntryObj.Id,accountObj.Id,pricebookObj.Id);
            insert orderItemlist;
            
            packageConfigObj=GenerateTestData.createPackageConfig(orderItemlist[0].Id,productConfig.Id);
            insert packageConfigObj;
            
            //setting page reference to current page 
            PageReference pRef= Page.CustomerOpsVF;
            Test.setCurrentPageReference(pRef); 
  
            ApexPages.StandardController stdControllerObj = new ApexPages.StandardController(testCase);
            CustomerOpsController controllerObj = new CustomerOpsController(stdControllerObj);
            List<OrderItem> orderItemTestList = [Select id,Case__c,DMA__c from OrderItem where Case__c =: testCase.id];
            system.assertEquals(2, orderItemTestList.size());                       //list of orderitem per case
            system.assertEquals(orderItemTestList[0].DMA__c,'ABILENE-SWEETWATER');
            Test.stopTest();
      }
        //TestMethod to test OrderItem without Case.
        public static testmethod void testOrderItemWithoutCaseId(){
            
            accountObj=GenerateTestData.createAccount();
            insert accountObj;
            
            testCase = GenerateTestData.createCase(accountObj.Id);
          
            productobj = GenerateTestData.createProduct();
            insert productobj;
           
            pricebookObj = GenerateTestData.createPricebook();
            insert pricebookObj;
            
            pricebookEntryObj = GenerateTestData.createPricebookentry(productobj.Id,pricebookObj.Id);
            insert pricebookEntryObj;
            
            productConfig=GenerateTestData.createProductConfig(productobj.Id);
            insert productConfig;
            
            orderObj = new Order(AccountId=accountObj.Id ,Status='Draft',EffectiveDate=Date.today(),Pricebook2Id=pricebookObj.Id );
            insert orderObj;
            
            orderItemlist=GenerateTestData.createOrderItem(null,pricebookEntryObj.Id,accountObj.Id,pricebookObj.Id);
            insert orderItemlist;
            
            packageConfigObj=GenerateTestData.createPackageConfig(orderItemlist[0].Id,productConfig.Id);
            insert packageConfigObj;
            
            //sets the currrent page reference for testing
            PageReference pRef= Page.CustomerOpsVF;
            Test.setCurrentPageReference(pRef); 
            
            Test.startTest();
            ApexPages.StandardController stdControllerObj = new ApexPages.StandardController(testCase);
            CustomerOpsController controllerObj = new CustomerOpsController(stdControllerObj);
            
            Test.stopTest();   
            system.assertEquals(orderItemlist[0].Case__c,Null);
           
            List<Apexpages.Message> msgs = ApexPages.getMessages();
            Boolean error = false;
            System.debug('//test order: ' + ApexPages.getMessages().size());
            if (ApexPages.getMessages().size() == 0) {                    
                error = true;                
            }    
            System.assert(error);                   
        }
        //test method without OrderItem to Case
        public static testMethod void testNoOrderItem(){
         
            accountObj=GenerateTestData.createAccount();
            insert accountObj;
            
            testCase = GenerateTestData.createCase(accountObj.Id);
            insert testCase;
            
            PageReference pRef= Page.CustomerOpsVF;
            Test.setCurrentPageReference(pRef);

            Test.startTest();

            ApexPages.StandardController stdControllerObj = new ApexPages.StandardController(testCase);
            CustomerOpsController controllerObj = new CustomerOpsController(stdControllerObj);
                                                 
            Test.stopTest();

            List<Apexpages.Message> msgs = ApexPages.getMessages();
            Boolean error = false;
            System.debug('//test order: ' + ApexPages.getMessages().size());
            if (ApexPages.getMessages().size() == 0) {                    
                error = true;                
            }    
            System.assert(error);                    
        }
        //Testmethod to check OrderItem without Product Configuration
        public static testmethod void testOrderItemWithoutProductConfig(){
            productobj = GenerateTestData.createProduct();
            insert productobj;
            
            pricebookObj = GenerateTestData.createPricebook();
            insert pricebookObj;
            
            pricebookEntryObj = GenerateTestData.createPricebookentry(productobj.Id,pricebookObj.Id);
            insert pricebookEntryObj;
            
            accountObj=GenerateTestData.createAccount();
            insert accountObj;
            
            testCase = GenerateTestData.createCase(accountObj.Id);
            insert testCase;
            
            orderObj = new Order(AccountId=accountObj.Id ,Status='Draft',EffectiveDate=Date.today());
            insert orderObj;
            
            orderItemlist=GenerateTestData.createOrderItem(testCase.Id,pricebookEntryObj.Id,accountObj.Id,pricebookObj.Id);
            insert orderItemlist;
            
            //sets current page reference for testing
            PageReference pRef= Page.CustomerOpsVF;
            Test.setCurrentPageReference(pRef);

            Test.startTest();

            ApexPages.StandardController stdControllerObj = new ApexPages.StandardController(testCase);
            CustomerOpsController controllerObj = new CustomerOpsController(stdControllerObj);
                                                 
            Test.stopTest();           
       }

    }