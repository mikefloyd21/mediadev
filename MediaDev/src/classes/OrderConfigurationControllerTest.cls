@isTest
    public class OrderConfigurationControllerTest {
        
        static Case caseObj {get; set;}
        static Account acctObj {get; set;}
        static Order orderObj {get; set;}
        static Order orderObj2 {get; set;}
        static Product2 prodObj {get; set;}
        static Pricebook2 pbObj {get; set;}
        static PricebookEntry pbeObj {get; set;}  
        static OrderItem oItemObj {get; set;}    
        static Product_Configuration__c productConfig {get; set;}    
        static Package_Configuration__c pkgConfigObj {get; set;}
        static Product_Config_Rule_Setup__c exceptionAll {get; set;}
        static Product_Config_Rule_Setup__c exceptionValue {get; set;}
        static Product_Config_Rule_Setup__c conditionalAll {get; set;}
        static Product_Config_Rule_Setup__c conditionalValue {get; set;}
        static OrderConfigurationController orderConfigCtrl;

        //method to used for setting up data for test methods
        private static void setupData(){
            acctObj=GenerateTestData.createAccount();
            insert acctObj;
           
            caseObj = GenerateTestData.createCase(acctObj.Id);
            insert caseObj;
           
            prodObj = GenerateTestData.createProductSett();
            insert prodObj;
           
            pbObj = GenerateTestData.createPricebook();
            insert pbObj;
            
            pbeObj = GenerateTestData.createPricebookentry(prodObj.Id,pbObj.Id);
            insert pbeObj;      

            oItemObj = GenerateTestData.newOrderItem(caseObj.Id,pbeObj.Id,acctObj.Id,pbObj.Id);

            productConfig = GenerateTestData.createProdConfig(prodObj.Id);       
            insert productConfig;       
        }

        //method to used for setting up an empty data for test methods
        private static void setupEmptyData(){
            acctObj=GenerateTestData.createAccount();
            insert acctObj;
           
            caseObj = GenerateTestData.createCase(acctObj.Id);
            insert caseObj;
           
            prodObj = GenerateTestData.createProduct();

           
            pbObj = GenerateTestData.createPricebook();    
        }        

        //method to used for setting up data with Activated Order for test methods
        private static void setupDataOrderActivated(){
            acctObj=GenerateTestData.createAccount();
            insert acctObj;
           
            caseObj = GenerateTestData.createCase(acctObj.Id);
            insert caseObj;
           
            prodObj = GenerateTestData.createProduct();
            insert prodObj;
           
            pbObj = GenerateTestData.createPricebook();
            insert pbObj;
            
            pbeObj = GenerateTestData.createPricebookentry(prodObj.Id,pbObj.Id);
            insert pbeObj;      

            orderObj = GenerateTestData.createOrders(acctObj.Id, pbObj.Id);
            insert orderObj;                        

            oItemObj = GenerateTestData.orderStatAct(orderObj.Id, caseObj.Id,pbeObj.Id,acctObj.Id,pbObj.Id);
            insert oItemObj;     

            orderObj.Status = 'Activated';
            update orderObj;               

            productConfig = GenerateTestData.createProdConfig(prodObj.Id);       
            insert productConfig;       
        } 

        public static void packagesValues(){
            orderConfigCtrl.pkgConfigWrapperLst[0].pkgConfigObj.Tier_Governor_Type__c = 'Make';
            orderConfigCtrl.pkgConfigWrapperLst[0].pkgConfigObj.Tier_Governor_Value__c = 'Acura';
            orderConfigCtrl.pkgConfigWrapperLst[0].pkgConfigObj.Tier_Governor_Advertised_Make__c = 'Acura';
            orderConfigCtrl.pkgConfigWrapperLst[0].pkgConfigObj.Tier_Governor_Vehicle_Quantity__c = 1;
            orderConfigCtrl.pkgConfigWrapperLst[0].pkgConfigObj.Tier_Governor_Vehicle_Monthly_Rate__c = 1;
            orderConfigCtrl.pkgConfigWrapperLst[0].pkgConfigObj.Tier_Governor_Co_op_Level_of_Service__c = 'Dealer Managed';
            orderConfigCtrl.pkgConfigWrapperLst2[0].pkgConfigObj.New_Car_Make__c = 'GMC';
            orderConfigCtrl.pkgConfigWrapperLst2[0].pkgConfigObj.New_Car_Make_Quantity__c = 1;        
            orderConfigCtrl.pkgConfigWrapperLst2[0].pkgConfigObj.Used_Car_Make__c = 'GMC';
            orderConfigCtrl.pkgConfigWrapperLst2[0].pkgConfigObj.Used_Car_Make_Quantity__c = 1;            
        }       

        //test if an Order is Activated, (Activated Order cannot be configured)
        public static testMethod void testOrderStatus(){
            setupDataOrderActivated();            
            PageReference pageRef = Page.OrderConfigurationVF;
            Test.setCurrentPage(pageRef);

            Test.startTest();

            ApexPages.StandardController stdctrl = new ApexPages.StandardController(oItemObj);
            orderConfigCtrl = new  OrderConfigurationController(stdctrl);                    

            Test.stopTest();

            List<Apexpages.Message> msgs = ApexPages.getMessages();
            Boolean error = false;   
            for(Apexpages.Message msg: msgs) {                
                if (msg.getDetail().contains(Label.Order_Activated_Status_Message)) {
                    error = true;                
                }
            }   
            System.assert(error);            
        }    

        //test if there are Order Items in each Order
        public static testMethod void testNoOrderItem(){
            OrderItem newOItem = new OrderItem();

            PageReference pageRef = Page.OrderConfigurationVF;
            Test.setCurrentPage(pageRef);

            Test.startTest();

            ApexPages.StandardController stdctrl = new ApexPages.StandardController(newOItem);
            orderConfigCtrl = new  OrderConfigurationController(stdctrl); 
                                                 
            Test.stopTest();

            List<Apexpages.Message> msgs = ApexPages.getMessages();
            Boolean error = false;
            System.debug('//test order: ' + ApexPages.getMessages().size());
            if (ApexPages.getMessages().size() == 0) {                    
                error = true;                
            }    
            System.assert(error);                   
        }          

        //test if the commandlink can add field set sections
        public static testMethod void testAddLink(){
            setupData();
            insert oItemObj;
            
            PageReference pageRef = Page.OrderConfigurationVF;
            Test.setCurrentPage(pageRef);

            Test.startTest();

            ApexPages.StandardController stdctrl = new ApexPages.StandardController(oItemObj);
            orderConfigCtrl = new  OrderConfigurationController(stdctrl);                  
           
            orderConfigCtrl.addCarMakeFields();  
            orderConfigCtrl.addCarMakeFields();  
            orderConfigCtrl.addCarMakeFields();  
            orderConfigCtrl.addCarMakeFields();  
            orderConfigCtrl.addCarMakeFields();  
            orderConfigCtrl.addCarMakeFields();  
            orderConfigCtrl.addCarMakeFields();  
            orderConfigCtrl.addCarMakeFields();  

            orderConfigCtrl.addTierGovernorFields();  
            orderConfigCtrl.addTierGovernorFields();  
            orderConfigCtrl.addTierGovernorFields();  
            orderConfigCtrl.addTierGovernorFields();  
            orderConfigCtrl.addTierGovernorFields();  
            orderConfigCtrl.addTierGovernorFields();  
            orderConfigCtrl.addTierGovernorFields();  
            orderConfigCtrl.addTierGovernorFields();            
            Test.stopTest();
                   
        }

        //test if the commandlink can remove field set sections
        public static testMethod void testRemoveLink(){
            setupData();
            insert oItemObj;
            
            PageReference pageRef = Page.OrderConfigurationVF;
            Test.setCurrentPage(pageRef);

            Test.startTest();

            ApexPages.StandardController stdctrl = new ApexPages.StandardController(oItemObj);
            orderConfigCtrl = new  OrderConfigurationController(stdctrl);                  
           
            orderConfigCtrl.addTierGovernorFields();
            orderConfigCtrl.addTierGovernorFields();
            orderConfigCtrl.removeTierGovernorFields();
            orderConfigCtrl.addCarMakeFields();
            orderConfigCtrl.addCarMakeFields();
            orderConfigCtrl.removeCarMakeFields();           
  
            Test.stopTest();
                   
        }        

        //test the Tier Governor Sequence
        public static testMethod void testTierGovernorSequence(){
            setupData();
            insert oItemObj;
            
            PageReference pageRef = Page.OrderConfigurationVF;
            Test.setCurrentPage(pageRef);

            Test.startTest();

            ApexPages.StandardController stdctrl = new ApexPages.StandardController(oItemObj);
            orderConfigCtrl = new  OrderConfigurationController(stdctrl);                  

            orderConfigCtrl.addTierGovernorFields();
            orderConfigCtrl.addTierGovernorFields();
            orderConfigCtrl.addTierGovernorFields();

            orderConfigCtrl.pkgConfigWrapperLst[0].pkgConfigObj.Tier_Governor_Type__c = 'Early Model';              
            orderConfigCtrl.pkgConfigWrapperLst[1].pkgConfigObj.Tier_Governor_Type__c = 'All Car';              
            orderConfigCtrl.pkgConfigWrapperLst[2].pkgConfigObj.Tier_Governor_Type__c = 'Make';

            orderConfigCtrl.saveAction(); 
            Test.stopTest();     

            List<Apexpages.Message> msgs = ApexPages.getMessages();
            Boolean error = false;
            System.debug('//test msg: ' + msgs);
            for(Apexpages.Message msg: msgs) {
                if (msg.getDetail().contains(Label.Tier_Governor_Type_Incorrect_Sequence_Message)) {
                    error = true;                
                }
            }   
            System.assert(error);                          
        }          

        //test if Car Make fields have values
        /*public static testMethod void testCarMakeRequiredFields(){
            setupData();

            oItemObj.DMA__c = 'ABILENE-SWEETWATER';
            oItemObj.Make__c = 'Acura';
            oItemObj.Artwork_Dropdown__c = 'Alpha Sent EQS';  
            oItemObj.Configured__c = true;          
            insert oItemObj;

            PageReference pageRef = Page.OrderConfigurationVF;
            Test.setCurrentPage(pageRef);

            Test.startTest();

            ApexPages.StandardController stdctrl = new ApexPages.StandardController(oItemObj);
            orderConfigCtrl = new  OrderConfigurationController(stdctrl);        

            orderConfigCtrl.pkgConfigWrapperLst[0].pkgConfigObj.Tier_Governor_Type__c = 'Early Model';
            orderConfigCtrl.pkgConfigWrapperLst[0].pkgConfigObj.Tier_Governor_Value__c = 'Acura';
            orderConfigCtrl.pkgConfigWrapperLst[0].pkgConfigObj.Tier_Governor_Advertised_Make__c = 'Acura';
            orderConfigCtrl.pkgConfigWrapperLst[0].pkgConfigObj.Tier_Governor_Vehicle_Quantity__c = 1;
            orderConfigCtrl.pkgConfigWrapperLst[0].pkgConfigObj.Tier_Governor_Vehicle_Monthly_Rate__c = 1;
            orderConfigCtrl.pkgConfigWrapperLst[0].pkgConfigObj.Tier_Governor_Co_op_Level_of_Service__c = 'Dealer Managed';

            orderConfigCtrl.addCarMakeFields();
            orderConfigCtrl.removeCarMakeFields();            
            orderConfigCtrl.saveAction();
            Test.stopTest();

            List<Apexpages.Message> msgs = ApexPages.getMessages();
            Boolean error = false;
            for(Apexpages.Message msg: msgs) {
                if (msg.getDetail().contains(Label.Order_Product_Car_Make_Required_Fields)) {
                    error = true;                
                }
            }   
            System.assert(error);
        }*/        

        //test if Tier Governor fields have values
        public static testMethod void testTierGovernorRequiredFields(){
            setupData();

            oItemObj.DMA__c = 'ABILENE-SWEETWATER';
            oItemObj.Make__c = 'Acura';
            oItemObj.Artwork_Dropdown__c = 'Alpha Sent EQS';  
            oItemObj.Configured__c = true;    

            insert oItemObj;

            PageReference pageRef = Page.OrderConfigurationVF;
            pageRef.getParameters().put('retURL', '/' + oItemObj.OrderId);
            Test.setCurrentPage(pageRef);
            Test.startTest();

            ApexPages.StandardController stdctrl = new ApexPages.StandardController(oItemObj);
            orderConfigCtrl = new  OrderConfigurationController(stdctrl);

            orderConfigCtrl.saveAction();

            orderConfigCtrl.pkgConfigWrapperLst[0].pkgConfigObj.Tier_Governor_Type__c = 'All Car';

            orderConfigCtrl.addTierGovernorFields();
            orderConfigCtrl.removeTierGovernorFields();
            orderConfigCtrl.saveAction();
            orderConfigCtrl.cancelAction();
            Test.stopTest();

            List<Apexpages.Message> msgs = ApexPages.getMessages();
            Boolean error = false;
            for(Apexpages.Message msg: msgs) {
                if (msg.getDetail().contains(Label.Order_Product_Tier_Governor_Required_Fields)) {
                    error = true;                
                }
            }   
            System.assert(error);        
        }        

        //test if the fields rendered true in Product Configuration have values
        public static testMethod void testOrderProductRequiredFields(){
            setupData();
  
            oItemObj.Configured__c = true;          
            insert oItemObj;

            PageReference pageRef = Page.OrderConfigurationVF;
            Test.setCurrentPage(pageRef);

            Test.startTest();

            ApexPages.StandardController stdctrl = new ApexPages.StandardController(oItemObj);
            orderConfigCtrl = new  OrderConfigurationController(stdctrl);    

            packagesValues();  
            
            orderConfigCtrl.tierGovTypeChangeAction();
            orderConfigCtrl.saveAction();
            Test.stopTest();

            List<Apexpages.Message> msgs = ApexPages.getMessages();
            Boolean error = false;
            for(Apexpages.Message msg: msgs) {                           
                if (msg.getDetail().contains(Label.Order_Product_Required_Fields_Message)) {                    
                    error = true;                
                }
            }   
            System.assert(error);                    
        } 

        //test if all fields available in the Order Product have values
        public static testMethod void testAllRequiredFields(){
            setupData();

            oItemObj.DMA__c = 'ABILENE-SWEETWATER';
            oItemObj.Make__c = 'Acura';
            oItemObj.Artwork_Dropdown__c = 'Alpha Sent EQS';  
            oItemObj.Configured__c = true;          
            insert oItemObj;

            PageReference pageRef = Page.OrderConfigurationVF;
            pageRef.getParameters().put('retURL', '/' + oItemObj.OrderId);
            Test.setCurrentPage(pageRef);

            Test.startTest();

            ApexPages.StandardController stdctrl = new ApexPages.StandardController(oItemObj);
            orderConfigCtrl = new  OrderConfigurationController(stdctrl); 
                    
            packagesValues();

            orderConfigCtrl.tierGovTypeChangeAction();
            orderConfigCtrl.saveAction();        
            Test.stopTest();

            List<Apexpages.Message> msgs = ApexPages.getMessages();
            Boolean error = false;
            if (ApexPages.getMessages().size() == 0) {                    
                error = true;                
            }    
            System.assert(error);                   
        }                       

        /* Rule Type: Exception
         * SKU: All
         * Controlling Field: None
         */
        public static testMethod void testCustomSettingExceptionAll(){
            setupData();

            exceptionAll = GenerateTestData.createExceptionAll();
            insert exceptionAll;
            
            oItemObj.Make__c = 'Acura';
            oItemObj.Artwork_Dropdown__c = 'Alpha Sent EQS';  
            oItemObj.Configured__c = true;          
            insert oItemObj;

            Test.startTest();

            ApexPages.StandardController stdctrl = new ApexPages.StandardController(oItemObj);
            orderConfigCtrl = new  OrderConfigurationController(stdctrl); 
            
            packagesValues();                   
            
            orderConfigCtrl.saveAction();    
            Test.stopTest();  

            List<Apexpages.Message> msgs = ApexPages.getMessages();
            Boolean error = false;
            if (ApexPages.getMessages().size() == 0) {                    
                error = true;                
            }    
            System.assert(error);                     
        }    

        /* Rule Type: Exception
         * SKU: Specific Value
         * Controlling Field: None
         */
        public static testMethod void testCustomSettingExceptionValue(){
            setupData();
            
            exceptionValue = GenerateTestData.createExceptionValue();
            insert exceptionValue;
            
            oItemObj.Make__c = 'Acura';
            oItemObj.Artwork_Dropdown__c = 'Alpha Sent EQS';  
            oItemObj.Configured__c = true;          
            insert oItemObj;

            Test.startTest();

            ApexPages.StandardController stdctrl = new ApexPages.StandardController(oItemObj);
            orderConfigCtrl = new  OrderConfigurationController(stdctrl); 
            
            packagesValues();                   
            
            orderConfigCtrl.saveAction();    
            Test.stopTest();  

            List<Apexpages.Message> msgs = ApexPages.getMessages();
            Boolean error = false;
            if (ApexPages.getMessages().size() == 0) {                    
                error = true;                
            }    
            System.assert(error);                      
        }        

        /* Rule Type: Conditional Required
         * SKU: All
         * Controlling Field: Specific Value
         */
        public static testMethod void testCustomSettingConditionalAll(){            
            setupData();            

            productConfig.APFD_Date__c = true;
            productConfig.Approved_for_Future_Delivery__c = true;
            update productConfig;

            conditionalAll = GenerateTestData.createConditionalAll();
            insert conditionalAll;

            oItemObj.DMA__c = 'ABILENE-SWEETWATER';
            oItemObj.Make__c = 'Acura';
            oItemObj.Artwork_Dropdown__c = 'Alpha Sent EQS'; 
            oItemObj.Approved_for_Future_Delivery__c = false;
            oItemObj.Configured__c = true;          
            insert oItemObj;

            Test.startTest();

            ApexPages.StandardController stdctrl = new ApexPages.StandardController(oItemObj);
            orderConfigCtrl = new  OrderConfigurationController(stdctrl); 
                  
            packagesValues();  
            
            orderConfigCtrl.saveAction();    
            Test.stopTest();          

            List<Apexpages.Message> msgs = ApexPages.getMessages();
            Boolean error = false;
            if (ApexPages.getMessages().size() == 0) {                    
                error = true;                
            }    
            System.assert(error);              
        }                

        /* Rule Type: Conditional Required
         * SKU: Specific Value
         * Controlling Field: Specific Value
         */
        public static testMethod void testCustomSettingConditionalValue(){            
            setupData();            

            productConfig.APFD_Date__c = true;
            productConfig.Approved_for_Future_Delivery__c = true;
            update productConfig;

            conditionalValue = GenerateTestData.createConditionalValue();
            insert conditionalValue;

            oItemObj.DMA__c = 'ABILENE-SWEETWATER';
            oItemObj.Make__c = 'Acura';
            oItemObj.Artwork_Dropdown__c = 'Alpha Sent EQS'; 
            oItemObj.Approved_for_Future_Delivery__c = true;
            oItemObj.Configured__c = true;          
            insert oItemObj;

            Test.startTest();

            ApexPages.StandardController stdctrl = new ApexPages.StandardController(oItemObj);
            orderConfigCtrl = new  OrderConfigurationController(stdctrl); 
                  
            packagesValues();  
            
            orderConfigCtrl.saveAction();    
            Test.stopTest();          

            List<Apexpages.Message> msgs = ApexPages.getMessages();
            Boolean error = false;
            for(Apexpages.Message msg: msgs) {                           
                if (msg.getDetail().contains(Label.Order_Product_Required_Fields_Message)) {                    
                    error = true;                
                }
            }   
            System.assert(error);              
        }                                        
    }