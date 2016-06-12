/**
 *@author Original: Aakash Wankhede - Cloud Sherpas/Auto Trader, Last Modified: Aakash Wankhede - Cloud Sherpas/Auto Trader
 *@description:This  is a class that generate the test data for "TestCustomerOpsController", "OrderTriggerClassTest", "OrderConfigurationControllerTest", "PackageConfigurationTriggerClassTest"
 *              with all object that is needed for testing.
 */
public with sharing class GenerateTestData {

    public static List<Order> ordrLst = new List<Order>();
    public static List<OrderItem> orItemLst = new List<OrderItem>();
    public static List<Package_Configuration__c> pkgConfigLst = new List<Package_Configuration__c>();
    
    public static List<OrderItem> orderItemlist = new List<OrderItem>();

    public static Case createCase(Id accountId){
        Case case1 = new Case(Priority = 'Low', Status = 'New', ATC_Case_Reason__c = 'Applications', Origin = 'Phone', 
                             AccountId = accountId, Subject = 'test' + Math.random(), 
                             Description = 'Testing Purpose' + Math.random());
        return case1;
    }

    public static Account createAccount(){
        Account account = new Account(Name = 'Test Account' + Math.random(), BillingStreet = '123 Main' + Math.random(),BillingCity = 'Anytown', BillingState = 'CA', BillingPostalCode = '12345' );
        return account;
    }     

    public static Product2 createProduct(){
        Product2 product = new Product2(Name = 'Test Product' + Math.random(), isActive = true);
        system.debug('product '+ product);
        return product;
    }  

    public static Product2 createProductSett(){
        Product2 product = new Product2(Name = 'Test Product', isActive = true);
        return product;
    }     

    public static PricebookEntry createPricebookentry(Id product, Id pricebook){
        Id pricebookId = Test.getStandardPricebookId();
        PricebookEntry standardPrice = new PricebookEntry(Pricebook2Id = pricebookId,Product2Id = product, 
                                                            UnitPrice = 10000, IsActive = true);  
        insert standardPrice;

        PricebookEntry custompricebookEntry = new PricebookEntry(Pricebook2Id = pricebook, Product2Id = product, 
                                                                    UnitPrice = 10000, UseStandardPrice = false);
        return custompricebookEntry ;
    }

    public static Pricebook2 createPricebook(){
        Pricebook2 pricebook = new Pricebook2(Name = 'Test Price Book' + Math.random() ,IsActive = true);
        return pricebook;
    }    

    public static Order createOrders(Id accountId, Id pricebookId){
        Order newOrder = new Order(EffectiveDate = date.today(), Pricebook2Id = pricebookId,
                                    AccountId = accountId, Status = 'Draft');
        return newOrder;
    }    

    public static List<OrderItem> createOrderItem(Id caseId, Id pricebookentryId, Id accountId, Id pricebookId){
        Order ordr = new Order(AccountId = accountId, Status = 'Draft', EffectiveDate = Date.today(),
                                Pricebook2Id = pricebookId);
        insert ordr;

        for(integer i=0;i<2;i++){
            orderItemlist.add(new OrderItem(OrderId = ordr.id, Case__c = caseId, PricebookEntryId = pricebookentryId, 
                                Quantity = 1+i, UnitPrice=1+i, DMA__c = 'ABILENE-SWEETWATER'));
        }
        return orderItemlist;
    }    

    public static List<OrderItem> createOItem(Id pricebookentryId, Id accountId, Id pricebookId, Id oppId){        
        for(integer i=0;i<2;i++){
            Order ordrObj = new Order(AccountId = accountId, OpportunityId = oppId, Status='Draft', EffectiveDate = Date.today(), Pricebook2Id = pricebookId);
            ordrLst.add(ordrObj);
        }
        insert ordrLst;

        for(Order o : ordrLst){
            OrderItem oItem = new OrderItem(OrderId = o.Id, PricebookEntryId = pricebookentryId, Quantity = 1, UnitPrice = 1);
            orItemLst.add(oItem);
        }
        return orItemLst;
    }  

    public static OrderItem newOrderItem(Id caseId, Id pricebookentryId, Id accountId, Id pricebookId){
        Order ordr = new Order(AccountId = accountId, Status = 'Draft', EffectiveDate = Date.today(), Pricebook2Id = pricebookId);
        insert ordr;

        OrderItem oItem = new OrderItem(OrderId = ordr.id, Case__c = caseId, PricebookEntryId = pricebookentryId,
                                            Quantity = 1, UnitPrice = 1);
        return oItem;
    }     

    public static OrderItem orderStatAct(Id orderId, Id caseId, Id pricebookentryId, Id accountId, Id pricebookId){
        OrderItem oItem = new OrderItem(OrderId = orderId, Case__c = caseId, PricebookEntryId = pricebookentryId, 
                                            Quantity = 1, UnitPrice = 1);
        return oItem;
    }    

    public static Package_Configuration__c createPackageConfig(Id orderItemId, Id productConfig){
        Package_Configuration__c packageConfig = new Package_Configuration__c(Order_Product__c = orderItemId, 
                                                                                Product_Configuration__c = productConfig);
        return packageConfig;
    }    

    public static List<Package_Configuration__c> createPkgConfig(Integer oItems, Id orderItemId, Id productConfig){
        for(integer i=0;i<oItems;i++){
            Package_Configuration__c packageConfig = new Package_Configuration__c(Order_Product__c = orderItemId,
                                Product_Configuration__c = productConfig, Tier_Governor_Co_op_Level_of_Service__c = 'Dealer Managed');
            pkgConfigLst.add(packageConfig);
        }      
        return pkgConfigLst;
    }    
        
    public static Product_Configuration__c createProductConfig(Id product){
      Product_Configuration__c productConfig = new Product_Configuration__c(Name = 'TestProductConfig' + Math.random(),
                                                                            Product2__c = product, DMA__c = true,
                                                                            Artwork_Dropdown__c = true, BMWs_Location_ID__c = true,
                                                                            Term_Duration__c = true, Bill_to_Account__c = true);
        system.debug('ProductConfig '+productConfig );
        return productConfig;
    } 

    public static Product_Configuration__c createProdConfig(Id product){
        Product_Configuration__c productConfig = new Product_Configuration__c(Name = 'TestProductConfig' + Math.random(), Product2__c = product,
            Tier_Governor_Fields_Premium_Package__c = true, New_Car_Make_Fields_GM_Package__c = true, 
            Used_Car_Make_GM_Package__c = true, Used_Car_Make_Quantity_GM_Package__c = true, 
            DMA__c = true, Make__c = true, Artwork_Dropdown__c = true);
        return productConfig;    
    }

    public static Opportunity createOpp(Id accountId){
        Opportunity oppty = new Opportunity(Name = 'Test Opportunity', AccountId = accountId, Type = 'New Business',
                                                BU__c = 'ATC Media', CloseDate = Date.today(), StageName = 'Prospect');
        return oppty;
    }

    public static Product_Config_Rule_Setup__c createExceptionAll(){
        Product_Config_Rule_Setup__c exceptAll = new Product_Config_Rule_Setup__c(Name = 'Rule Test', Rule_Type__c = 'Exception', 
                                                    Product_SKU_Name__c = 'All', Controlling_Field_API_Name__c = 'None', 
                                                    Dependent_Field_API_Name__c = 'DMA__c');
        return exceptAll;
    }

    public static Product_Config_Rule_Setup__c createExceptionValue(){
        Product_Config_Rule_Setup__c exceptVal = new Product_Config_Rule_Setup__c(Name = 'Rule Test', Rule_Type__c = 'Exception',
                                                    Product_SKU_Name__c = 'Test Product', Controlling_Field_API_Name__c = 'None',
                                                    Dependent_Field_API_Name__c = 'DMA__c');

        return exceptVal;
    }

    public static Product_Config_Rule_Setup__c createConditionalAll(){
        Product_Config_Rule_Setup__c conditionalAll = new Product_Config_Rule_Setup__c(Name = 'Rule Test', Rule_Type__c = 'Conditional Required',
                                                        Product_SKU_Name__c = 'All', Controlling_Field_API_Name__c = 'Approved_for_Future_Delivery__c',
                                                        Dependent_Field_API_Name__c = 'APFD_Date__c');
        return conditionalAll;
    }

    public static Product_Config_Rule_Setup__c createConditionalValue(){
        Product_Config_Rule_Setup__c conditionalVal = new Product_Config_Rule_Setup__c(Name = 'Rule Test', Rule_Type__c = 'Conditional Required',
                                                        Product_SKU_Name__c = 'Test Product', Controlling_Field_API_Name__c = 'Approved_for_Future_Delivery__c',
                                                        Dependent_Field_API_Name__c = 'APFD_Date__c');
        return conditionalVal;
    }
}