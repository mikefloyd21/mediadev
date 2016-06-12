/**
 *@author Original: Aakash Wankhede - Cloud Sherpas/Auto Trader, Last Modified: Aakash Wankhede - Cloud Sherpas/Auto Trader
 *@description:This  is a controller of customerOpsVf page used to display 
    the fields of Order products with read only mode and whose checkbox value
    is equal to true(Checked) from product configuration.
 */
public class CustomerOpsController {
    transient public Case caseObj {get; set;}
    transient public List<OrderItem> orderItemLst {get; set;}
    transient public List<ProductConfigWrapper> prodConfigWrpLst {get; set;}
    
    transient public Map<String, Boolean> mainSectionMap {get; set;}
    transient public List<Product_Configuration__c> prodConfigLst {get; set;}
    transient public String customErrorMsg {get; set;}
    
    private final Map<String, String> pkgConfigRecTypMap = ApexUtil.getActiveSObjectRecordTypes('Package_Configuration__c', false);
    private Map<String, Schema.FieldSet> prdConfigFSMap = Schema.SObjectType.Product_Configuration__c.fieldSets.getMap();
     
    transient public Boolean isInternalError {get; set;}
    
    public CustomerOpsController(ApexPages.StandardController controller) {
        caseObj = (Case) controller.getRecord();
        isInternalError = false;
        init();                              //Initialize method to do initial setup and fetch data from database
    }
    
    public void init(){
        orderItemLst = new List<OrderItem>();
        prodConfigLst = new List<Product_Configuration__c>();
        prodConfigWrpLst = new List<ProductConfigWrapper>();
        mainSectionMap = new Map<String, Boolean>();
        customErrorMsg = Label.Internal_Error_Message;
       
        List<String> odrItemFieldLst = new List<String>(OrderItem.SObjectType.getDescribe().fields.getMap().keySet());
        String odrItemQryStr = ' SELECT ' + String.join(odrItemFieldLst, ',') 
                                + ',PricebookEntry.Product2.Id, PricebookEntry.Product2.ProductCode, PricebookEntry.Product2.Name, '
                                + 'Order.AccountId FROM OrderItem WHERE Case__c= \'' 
                                + caseObj.Id + '\'';
        try{
            orderItemLst = Database.query(odrItemQryStr);
            system.debug('Order Item ***'+orderItemLst);
        }
        catch(Exception e){
             System.debug(LoggingLevel.ERROR, e.getMessage() + e.getStackTraceString());
             isInternalError = true;
             return;
        }
        
        if(orderItemLst.isEmpty()){
        //display error message when order item is not there in realted case
            isInternalError = true;
            customErrorMsg = Label.Case_Related_OrderItem_Does_Not_Exist;
            return;
        }
        //list of product ids realted to orderItem
        List<Id> prodIds = new List<Id>();
        for(OrderItem odrItmObjItr : orderItemLst){
            prodIds.add(odrItmObjItr.PricebookEntry.Product2.Id);
        }
        List<String> prodConfigFieldLst = new List<String>(Product_Configuration__c.SObjectType.getDescribe().fields.getMap().keySet());
        String prodConfigQryStr = ' SELECT ' + String.join(prodConfigFieldLst, ',') + ' FROM Product_Configuration__c WHERE Product2__c IN :prodIds';
        System.debug('Product Configuration Query String: ' + prodConfigQryStr);
        try{
            prodConfigLst = Database.query(prodConfigQryStr);
        }
        catch(Exception e){
           System.debug(LoggingLevel.ERROR, e.getMessage() + e.getStackTraceString());
            isInternalError = true;
            return;
        }                
        //map of product id and product configuration
        Map<Id, Product_Configuration__c> prodToProdConfigMap = new Map<Id, Product_Configuration__c>();
        for(Product_Configuration__c prodConfigItr : prodConfigLst){
            prodToProdConfigMap.put(prodConfigItr.Product2__c, prodConfigItr);
        }
        //List of package configuration fields
        List<Package_Configuration__c> pkgConfigLst = new List<Package_Configuration__c>();
        List<String> pkgConfigFieldLst = new List<String>(Package_Configuration__c.SObjectType.getDescribe().fields.getMap().keySet());
        String pkgConfigQryStr = ' SELECT ' + String.join(pkgConfigFieldLst, ',') + ' FROM Package_Configuration__c WHERE Product_Configuration__c IN :prodConfigLst AND Order_Product__c IN :orderItemLst  Order By Name';
                                            
        System.debug('Package Configuration Query String: ' + pkgConfigQryStr);
        try{
            pkgConfigLst = Database.query(pkgConfigQryStr);  
        }
        catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'Internal Error while trying to query related package configuration records, please contact system administrator.'));
            System.debug(LoggingLevel.ERROR, e.getMessage() + e.getStackTraceString());
        }
        //iterate all order item list 
        for(OrderItem odrItmItr : orderItemLst){
            ProductConfigWrapper prodConfigObj = new ProductConfigWrapper(odrItmItr);
            for(Package_Configuration__c pkgConfigItr : pkgConfigLst){
                if(odrItmItr.Id == pkgConfigItr.Order_Product__c){
                    if(pkgConfigRecTypMap.get('Premium_Package') == pkgConfigItr.RecordTypeId){
                        prodConfigObj.pkgConfigLst.add(pkgConfigItr);
                    }
                    if(pkgConfigRecTypMap.get('GM_Package') == pkgConfigItr.RecordTypeId){
                        prodConfigObj.pkgConfigLst2.add(pkgConfigItr);
                    }
                }
            }
            if(prodToProdConfigMap.get(odrItmItr.PricebookEntry.Product2.Id) != null){
                prodConfigObj.prodConfigObj = prodToProdConfigMap.get(odrItmItr.PricebookEntry.Product2.Id);
                prodConfigObj.fieldPositionMap = this.getProductConfigFieldSetup(prodToProdConfigMap.get(odrItmItr.PricebookEntry.Product2.Id));
            }
            
            prodConfigWrpLst.add(prodConfigObj);
            
        }
        Set<String> fieldSetLst = prdConfigFSMap.keySet().clone();
        fieldSetLst.add('feature_configuration');
        for(String strItr : fieldSetLst){
            mainSectionMap.put(strItr, false);
            for(ProductConfigWrapper objItr : prodConfigWrpLst){
                if(objItr.fieldPositionMap.get(strItr) == true){
                    mainSectionMap.put(strItr, true);
                }
            }
        }
        
        for(ProductConfigWrapper objItr : prodConfigWrpLst){
            System.debug('==test1== ' + objItr);
            System.debug('==test2== ' + objItr.prodConfigObj.Tier_Governor_Fields_Premium_Package__c);
            if(objItr.prodConfigObj.Tier_Governor_Fields_Premium_Package__c == true){
                mainSectionMap.put('cust_ops_co_op_configuration', true);
                System.debug('==test3== ' + mainSectionMap.get('cust_ops_co_op_configuration'));
            }
        }    
        
        for(ProductConfigWrapper objItr : prodConfigWrpLst){            
            if(objItr.prodConfigObj.KBB_Lead_Driver_Fields__c == true){
                mainSectionMap.put('feature_configuration', true);
            }
        }          
        
    }        

    //map of field names and their boolean values(Checkbox)
    private Map<String, Boolean> getProductConfigFieldSetup(Product_Configuration__c prodConfigVal){
        Map<String, Boolean> fieldPositionMap = new Map<String, Boolean>();

        Integer columnLoc = 0;
        String prevFieldAPIName = '';
        //iterate all through the product configuration fields
        for(String fieldSetItr : prdConfigFSMap.keySet()){
            columnLoc = 0;
            fieldPositionMap.put(fieldSetItr, false);
            for(FieldSetMember fieldSetMemItr : prdConfigFSMap.get(fieldSetItr).getFields()){
                columnLoc++;
                
                if(columnLoc == 1 && prodConfigVal.get(fieldSetMemItr.getFieldPath()) == true){
                    fieldPositionMap.put(fieldSetItr + fieldSetMemItr.getFieldPath(), true);
                    if(!fieldPositionMap.get(fieldSetItr)){
                        fieldPositionMap.put(fieldSetItr, true);
                    }
                }
                else if(columnLoc == 2 && prodConfigVal.get(fieldSetMemItr.getFieldPath()) == true){
                    fieldPositionMap.put(fieldSetItr + fieldSetMemItr.getFieldPath(), true);
                    fieldPositionMap.put(fieldSetItr + prevFieldAPIName, true);
                    
                    if(!fieldPositionMap.get(fieldSetItr)){
                        fieldPositionMap.put(fieldSetItr, true);
                    }
                }
                else if(columnLoc == 2 && prodConfigVal.get(fieldSetMemItr.getFieldPath()) == false && prodConfigVal.get(prevFieldAPIName) == true){
                    fieldPositionMap.put(fieldSetItr + fieldSetMemItr.getFieldPath(), true);
                    fieldPositionMap.put(fieldSetItr + prevFieldAPIName, true);
                    
                    if(!fieldPositionMap.get(fieldSetItr)){
                        fieldPositionMap.put(fieldSetItr, true);
                    }
                }
                else{
                    fieldPositionMap.put(fieldSetItr + fieldSetMemItr.getFieldPath(), false);
                }
                
                prevFieldAPIName = fieldSetMemItr.getFieldPath();
                if(columnLoc >= 2){
                    columnLoc = 0;
                }
            }
        }
        
        //Set visibility of "Feature Configuration" master section
        fieldPositionMap.put('feature_configuration', false);
        for(string featureConfigSubSec : Constants.FEATURE_CONFIG_SUB_SECTION_SEQ){
            if(fieldPositionMap.get(featureConfigSubSec)){
                fieldPositionMap.put('feature_configuration', true);                //If any subsection is visible set "Feature Configuration" section visible
                break;
            }
        }
        return fieldPositionMap;
   }
    
    public class ProductConfigWrapper{
        public OrderItem orderItemObj {get; set;}
        public List<Package_Configuration__c> pkgConfigLst {get; set;}
        public List<Package_Configuration__c> pkgConfigLst2 {get; set;}
        
        public Product_Configuration__c prodConfigObj {get; set;}
        public Map<String, Boolean> fieldPositionMap {get; set;}
        
        public ProductConfigWrapper(){
            this(new OrderItem(), new Map<String, Boolean>(), new List<Package_Configuration__c>(), new List<Package_Configuration__c>());
        }
        public ProductConfigWrapper(OrderItem odrItemVal){
            this(odrItemVal, new Map<String, Boolean>(), new List<Package_Configuration__c>(), new List<Package_Configuration__c>());
        }
        public ProductConfigWrapper(OrderItem odrItmVal, Map<String, Boolean> fieldPositionVal, List<Package_Configuration__c> premPkgLst, List<Package_Configuration__c> gmPkgLst){
            orderItemObj = odrItmVal;
            pkgConfigLst = premPkgLst;
            pkgConfigLst2 = gmPkgLst;
            
            fieldPositionMap = fieldPositionVal;
            prodConfigObj = new Product_Configuration__c();
        }
    }
}