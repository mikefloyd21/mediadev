/**
 *@author Original: Cloud Sherpas
 *@description: This is the controller of OrderConfiguratioVF used to display the fields that are rendered true from Product Configuration,
 *              and these fields are required upon saving once the user checked the Configured tag.
 */

public class OrderConfigurationController {
    public OrderItem orderItemObj {get; set;}
    public Product_Configuration__c prodConfigObj {get; set;}
    public Map<String, Boolean> fieldPositionMap {get; set;}
    public Boolean isAddTierFieldsVisible {get; set;}
    public Boolean isRemoveTierFieldsVisible {get; set;}
    public Boolean isAddCarMakeFieldsVisible {get; set;}    
    public Boolean isRemoveCarMakeFieldsVisible {get; set;}     
    public Boolean isAddKbbLeadDriverFieldsVisible {get; set;} 
    public Boolean isRemoveKbbLeadDriverFieldsVisible {get; set;}    
    public Boolean isInternalError {get; set;}
    
    /* Two different List<PackageConfigWrapper> variables are created to cover a scenario where a Product is configured 
     * with both "Car Make" fields and "Tier Governor" fields enabled.
     */
    public List<PackageConfigWrapper> pkgConfigWrapperLst {get; set;}                
    public List<PackageConfigWrapper> pkgConfigWrapperLst2 {get; set;} 
    public List<PackageConfigWrapper> pkgConfigWrapperLst4 {get; set;}    
    private List<PackageConfigWrapper> deleteQueuePkgConfigWrp;
    public Map<String, Schema.SObjectField> fieldMap;    
    private final Map<String, String> pkgConfigRecTypMap = ApexUtil.getActiveSObjectRecordTypes('Package_Configuration__c', false);
    private Set<String> prodConfigExceptionFields = Constants.PRODUCT_CONFIG_REQUIRED_FIELD_EXCEPTION.clone();    

    public OrderConfigurationController(ApexPages.StandardController controller) {
        orderItemObj = (OrderItem) controller.getRecord();
        isInternalError = false;
        init();                                                               //Initialize method to do initial setup
    }
    
    /**
     * init
     * @description:        Method called used to initial setup and fetch data from database
     */    
    public void init(){
        fieldPositionMap = new Map<String, Boolean>{};
        List<Package_Configuration__c> pkgConfigLst = new List<Package_Configuration__c>();
        List<Package_Configuration__c> pkgConfigLst2 = new List<Package_Configuration__c>();     

        isAddTierFieldsVisible = true;                                         //set the parameters for the initial state of the commandlink in the VF page
        isRemoveTierFieldsVisible = false;
        isAddCarMakeFieldsVisible = true;
        isRemoveCarMakeFieldsVisible = false;
        isAddKbbLeadDriverFieldsVisible = true;
        isRemoveKbbLeadDriverFieldsVisible = false;
        
        pkgConfigWrapperLst = new List<PackageConfigWrapper>();
        pkgConfigWrapperLst2 = new List<PackageConfigWrapper>(); 
        pkgConfigWrapperLst4 = new List<PackageConfigWrapper>();    
        
        deleteQueuePkgConfigWrp = new List<PackageConfigWrapper>();

        //get the fields from Order Item and assign to list of String to be used to setup query
        List<String> odrItemFieldLst = new List<String>(OrderItem.SObjectType.getDescribe().fields.getMap().keySet());
        String odrItemQryStr = ' SELECT ' + String.join(odrItemFieldLst, ',') 
                                + ',PricebookEntry.Product2.Id, PricebookEntry.Product2.Name, PricebookEntry.Product2.ProductCode, Order.AccountId, Order.Status FROM OrderItem WHERE Id = \'' + orderItemObj.Id + '\'';
        try{
            orderItemObj = Database.query(odrItemQryStr);                      //query the Order Item fields if the controller holds an Order Item record then assign to a list
        }
        catch(Exception e){
            System.debug(LoggingLevel.ERROR, e.getMessage() + e.getStackTraceString());    //throw an exception if an error occured in the query
            isInternalError = true;
            return;
        }
        
        //get the fields from Product Configuration and assign to list of String to be used to setup query
        List<String> prodConfigFieldLst = new List<String>(Product_Configuration__c.SObjectType.getDescribe().fields.getMap().keySet());
        String prodConfigQryStr = ' SELECT ' + String.join(prodConfigFieldLst, ',') + ' FROM Product_Configuration__c WHERE Product2__c = \'' + 
                                                orderItemObj.PricebookEntry.Product2.Id + '\'';
        try{
            prodConfigObj = Database.query(prodConfigQryStr);                  //query the Product Configuration if it has an Order Item Product Id then assign to a list
        }
        catch(Exception e){
            System.debug(LoggingLevel.ERROR, e.getMessage() + e.getStackTraceString());     //throw an exception if an error occured in the query
            isInternalError = true;
            return;
        }                
        
        //get the fields from Package Configuration and assign to list of String to be used to setup query
        List<String> pkgConfigFieldLst = new List<String>(Package_Configuration__c.SObjectType.getDescribe().fields.getMap().keySet());
        String pkgConfigQryStr = ' SELECT ' + String.join(pkgConfigFieldLst, ',') + ' FROM Package_Configuration__c WHERE Product_Configuration__c = \'' + 
                                            prodConfigObj.Id + '\' AND Order_Product__c = \'' + orderItemObj.Id + '\' Order By Name ASC';
                                            
        System.debug('Package Configuration Query String: ' + pkgConfigQryStr);
        try{
            pkgConfigLst = Database.query(pkgConfigQryStr);                   //query the Package Configuration if it has an Order Item Product and Product Configuration then assign to a list
        }
        catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'Internal Error while trying to query related package configuration records, please contact system administrator.'));
            System.debug(LoggingLevel.ERROR, e.getMessage() + e.getStackTraceString());
        }
                
        
        for(Package_Configuration__c pkgObjItr : pkgConfigLst){               //iterate the Package Configuration from the queried list of Package Config 
            if(pkgConfigRecTypMap.get('Premium_Package') == pkgObjItr.RecordTypeId){        //add to a list if the Package Config RecordType is equals to Premium Package
                pkgConfigWrapperLst.add(new PackageConfigWrapper(pkgObjItr));
            }
        }
        for(Integer itr = pkgConfigWrapperLst.size(); itr < Constants.DEFAULT_FIELD_SET_SIZE; itr++){
            PackageConfigWrapper pkgConfigWprObj = this.newPkgConfigWrapperInstance(true);
            pkgConfigWprObj.updateTierGovPkLstVal(true,true,true);
            pkgConfigWrapperLst.add(pkgConfigWprObj);
        }               
        
        for(Package_Configuration__c pkgObjItr2 : pkgConfigLst){              //iterate the Package Configuration from the queried list of Package Config 
            if(pkgConfigRecTypMap.get('GM_Package') == pkgObjItr2.RecordTypeId){            //add to a list if the Package Config RecordType is equals to Premium Package
                pkgConfigWrapperLst2.add(new PackageConfigWrapper(pkgObjItr2));
                pkgConfigWrapperLst4.add(new PackageConfigWrapper(pkgObjItr2));                
            }
        }            
          
        for(Integer itr2 = pkgConfigWrapperLst2.size(); itr2 < Constants.DEFAULT_FIELD_SET_SIZE; itr2++){
            pkgConfigWrapperLst2.add(this.newPkgConfigWrapperInstance(false));
        }  
                
        for(Integer itr4 = pkgConfigWrapperLst4.size(); itr4 < Constants.DEFAULT_FIELD_SET_SIZE; itr4++){
            pkgConfigWrapperLst4.add(this.newPkgConfigWrapperInstance(false));
        }     
        
        if(pkgConfigWrapperLst.size() > 1){
            isRemoveTierFieldsVisible = true;
        }
        if(pkgConfigWrapperLst2.size() > 1){
            isRemoveCarMakeFieldsVisible = true;
        }         
        if(pkgConfigWrapperLst4.size() > 1){
            isRemoveKbbLeadDriverFieldsVisible = true;
        }

        
        Map<String, Schema.FieldSet> prdConfigFSMap = Schema.SObjectType.Product_Configuration__c.fieldSets.getMap();
        Integer columnLoc = 0;
        String prevFieldAPIName = '';
                        
        /* iterate the fields from Product Configuration,
         * set each field position from left to right,
         * if either field in left or right is rendered false, then all the following fields will be adjusted,
         * if both fields in left and right are rendered false, then the whole row will collapse                
         */
        for(String fieldSetItr : prdConfigFSMap.keySet()){                  
            columnLoc = 0;
            fieldPositionMap.put(fieldSetItr, false);                       

            for(FieldSetMember fieldSetMemItr : prdConfigFSMap.get(fieldSetItr).getFields()){
                columnLoc++;
                
                if(columnLoc == 1 && prodConfigObj.get(fieldSetMemItr.getFieldPath()) == true){
                    fieldPositionMap.put(fieldSetItr + fieldSetMemItr.getFieldPath(), true);
                    if(!fieldPositionMap.get(fieldSetItr)){
                        fieldPositionMap.put(fieldSetItr, true);
                    }
                }
                else if(columnLoc == 2 && prodConfigObj.get(fieldSetMemItr.getFieldPath()) == true){
                    fieldPositionMap.put(fieldSetItr + fieldSetMemItr.getFieldPath(), true);
                    fieldPositionMap.put(fieldSetItr + prevFieldAPIName, true);
                    
                    if(!fieldPositionMap.get(fieldSetItr)){
                        fieldPositionMap.put(fieldSetItr, true);
                    }
                }
                else if(columnLoc == 2 && prodConfigObj.get(fieldSetMemItr.getFieldPath()) == false && prodConfigObj.get(prevFieldAPIName) == true){
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
        
        if(orderItemObj.Order.Status.equalsIgnoreCase(Constants.ORDER_STATUS_ACTIVATED)){
            System.debug(LoggingLevel.INFO, 'OrderConfigurationController:init(): ' + Label.Order_Activated_Status_Message);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, Label.Order_Activated_Status_Message));
        }
        
    }        
    
    /**
     * newPkgConfigWrapperInstance    
     * @param   isTierGovMake:  Tag to indicate which to assign Record Type    
     * @description:            Method that sets a Record Type based on the param: isTierGovMake
     * @return:                 Package Configuration with Record Type
     */         
    private PackageConfigWrapper newPkgConfigWrapperInstance(Boolean isTierGovMake){
        PackageConfigWrapper pkgConfigWprObj = new PackageConfigWrapper();
            
        pkgConfigWprObj.pkgConfigObj.Product_Configuration__c = prodConfigObj.Id;
        pkgConfigWprObj.pkgConfigObj.Order_Product__c = orderItemObj.Id;
        
        try{
            if(isTierGovMake){
                pkgConfigWprObj.pkgConfigObj.RecordTypeId = pkgConfigRecTypMap.get(Constants.PACKAGE_CONFIG_RECORD_TYPE_PREMIUM_PACKAGE);
            }
            else{
                pkgConfigWprObj.pkgConfigObj.RecordTypeId = pkgConfigRecTypMap.get(Constants.PACKAGE_CONFIG_RECORD_TYPE_GM_PACKAGE);
            }
        }
        catch(Exception e){
            System.debug(LoggingLevel.ERROR, e.getMessage() + e.getStackTraceString());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, Label.Internal_Error_Message));
        }
        
        return pkgConfigWprObj;
    }
        
    public PageReference addCarMakeFields(){                                        //add new set of Car Make Fields
        if(pkgConfigWrapperLst2.size() < Constants.CAR_MAKE_FIELD_SET_MAX_SIZE){            
            PackageConfigWrapper newObj = this.newPkgConfigWrapperInstance(false);
                pkgConfigWrapperLst2.add(newObj);
                System.debug('$$$Add New Fields = ' + pkgConfigWrapperLst2);
                isRemoveCarMakeFieldsVisible = true;                             
        }
        if(pkgConfigWrapperLst2.size() == Constants.CAR_MAKE_FIELD_SET_MAX_SIZE){
            isAddCarMakeFieldsVisible = false;                                                
        }          
        return null;
    }  
    
    public PageReference addKbbLeadDriverFields(){                                        //add new set of KBB Lead Driver Fields
        if(pkgConfigWrapperLst4.size() < Constants.CAR_MAKE_FIELD_SET_MAX_SIZE){            
            PackageConfigWrapper newObj = this.newPkgConfigWrapperInstance(false);
                pkgConfigWrapperLst4.add(newObj);
                isRemoveKbbLeadDriverFieldsVisible = true;                          
        }
        if(pkgConfigWrapperLst4.size() == Constants.CAR_MAKE_FIELD_SET_MAX_SIZE){
            isAddKbbLeadDriverFieldsVisible = false;                                      
        }          
        return null;
    }      
        
    public PageReference removeCarMakeFields(){                                     //remove the last set of Car Make Fields
        if(pkgConfigWrapperLst2.size() > 1){
            deleteQueuePkgConfigWrp.add(pkgConfigWrapperLst2.remove(pkgConfigWrapperLst2.size() - 1));  
            System.debug('$$$Remove New Fields = ' + pkgConfigWrapperLst2);                     
        }
        
        if(pkgConfigWrapperLst2.size() == 1){
            isRemoveCarMakeFieldsVisible = false;
        }
        else{
            isAddCarMakeFieldsVisible = true;
        }
        
        return null;
    }    
    
    public PageReference removeKbbLeadDriverFields(){                                     //remove the last set KBB Lead Driver Fields
        if(pkgConfigWrapperLst4.size() > 1){
            deleteQueuePkgConfigWrp.add(pkgConfigWrapperLst4.remove(pkgConfigWrapperLst4.size() - 1));                       
        }
        
        if(pkgConfigWrapperLst4.size() == 1){
            isRemoveKbbLeadDriverFieldsVisible = false;
        }
        else{
            isAddKbbLeadDriverFieldsVisible = true;
        }
        
        return null;
    }
    
    public PageReference tierGovTypeChangeAction(){                                 //setup the state of the commandlink in VF page depending the value selected in Tier Goevernor Type
        //System.debug('==test== ' + pkgConfigWrapperLst.get(pkgConfigWrapperLst.size() - 1).pkgConfigObj.Tier_Governor_Type__c);
        if(pkgConfigWrapperLst.get(pkgConfigWrapperLst.size() - 1).pkgConfigObj.Tier_Governor_Type__c == Constants.ALL_CAR){
            isAddTierFieldsVisible = false;
        }
        else{
            isAddTierFieldsVisible = true;
        }
        return null;
    }
    
    public PageReference addTierGovernorFields(){                                       //add new set of Tier Goevernor Fields
        Boolean addNewFieldSet = true;
        if(pkgConfigWrapperLst.size() < Constants.TIER_FIELD_SET_MAX_SIZE ){
           PackageConfigWrapper currObj;
           PackageConfigWrapper newObj = this.newPkgConfigWrapperInstance(true);
           if(pkgConfigWrapperLst.size() >= 1){                                         //Assumption: List will atleast have one record by default, adding this validation to avoid List Exception
               currObj = pkgConfigWrapperLst[pkgConfigWrapperLst.size() - 1];           //if more than 1 Tier fields set available get the current values
           }
           else{
               currObj = new PackageConfigWrapper();
           }
           
           if(currObj.pkgConfigObj.Tier_Governor_Type__c != null && currObj.pkgConfigObj.Tier_Governor_Type__c.equalsIgnoreCase(Constants.EARLY_MODEL)){
                newObj.updateTierGovPkLstVal(false,false,true);
           }
           else if(currObj.pkgConfigObj.Tier_Governor_Type__c != null && (currObj.pkgConfigObj.Tier_Governor_Type__c.equalsIgnoreCase(Constants.ALL_CAR) ||
                                                                            currObj.pkgConfigObj.Tier_Governor_Type__c.equalsIgnoreCase(''))){
               newObj.updateTierGovPkLstVal(false,false,false);
               //isAddTierFieldsVisible = false;
               addNewFieldSet = false;
           }
           else{
               newObj.updateTierGovPkLstVal(true,true,true);
           }
            if(addNewFieldSet){
                pkgConfigWrapperLst.add(newObj);
                isRemoveTierFieldsVisible = true;
                if(pkgConfigWrapperLst.size() == Constants.TIER_FIELD_SET_MAX_SIZE ){
                    isAddTierFieldsVisible = false;
                }
                
            }
        }
        return null;
    }
        
    public PageReference removeTierGovernorFields(){                                    //remove the last set of Tier Governor Fields
        if(pkgConfigWrapperLst.size() > 1){
            deleteQueuePkgConfigWrp.add(pkgConfigWrapperLst.remove(pkgConfigWrapperLst.size() - 1));
        }
        if(pkgConfigWrapperLst.size() == 1){
            isRemoveTierFieldsVisible = false;
        }
        else{
            isAddTierFieldsVisible = true;
        }
        return null;
    }

    public List<String> getFeatureConfigSubSections(){
        return Constants.FEATURE_CONFIG_SUB_SECTION_SEQ;
    }
        
    public PageReference saveAction(){                                                  //save the Order Product once validated
        PageReference pgRef = null;
        List<Package_Configuration__c> pkgConfigLst = new List<Package_Configuration__c>();
        List<Package_Configuration__c> deletePkgConfigLst = new List<Package_Configuration__c>();
        Package_Configuration__c prevPkgConfigObj;
        Boolean isEarlyModelExist = false;
        Boolean isAllCarExist = false;
        
        if(prodConfigObj.Tier_Governor_Fields_Premium_Package__c){
            for(PackageConfigWrapper objItr : pkgConfigWrapperLst){
                if(!(objItr.pkgConfigObj.Tier_Governor_Type__c == null || objItr.pkgConfigObj.Tier_Governor_Type__c == '')){
                    if(objItr.pkgConfigObj.Tier_Governor_Type__c.equalsIgnoreCase(Constants.EARLY_MODEL)){
                        if(isAllCarExist || isEarlyModelExist){
                            System.debug(LoggingLevel.ERROR, Label.Tier_Governor_Type_Incorrect_Sequence_Message);
                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.Tier_Governor_Type_Incorrect_Sequence_Message));
                            return pgRef;                        //returns page to the Order Product record
                        }
                        isEarlyModelExist = true;
                    }
                    else if(objItr.pkgConfigObj.Tier_Governor_Type__c.equalsIgnoreCase(Constants.ALL_CAR)){
                        if(isAllCarExist){
                            System.debug(LoggingLevel.ERROR, Label.Tier_Governor_Type_Incorrect_Sequence_Message);
                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.Tier_Governor_Type_Incorrect_Sequence_Message)); 
                            return pgRef;                       //returns page to the Order Product record
                        }
                        isEarlyModelExist = true;
                        isAllCarExist = true;
                    }
                    else if(objItr.pkgConfigObj.Tier_Governor_Type__c.equalsIgnoreCase(Constants.MAKE)){
                        if(isAllCarExist || isEarlyModelExist){
                            System.debug(LoggingLevel.ERROR, Label.Tier_Governor_Type_Incorrect_Sequence_Message);
                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.Tier_Governor_Type_Incorrect_Sequence_Message)); 
                            return pgRef;                       //returns page to the Order Product record
                        }
                    }
                    pkgConfigLst.add(objItr.pkgConfigObj);
                }
            }
            
            if(!validateTierFields()){
                return pgRef;                                   //returns page to the Order Product record
            }
        }

        //If the Car Make fields in Product Configuration are rendered true, add them to the Package Configuration list
        /**
        if((prodConfigObj.New_Car_Make_Fields_GM_Package__c)){
            for(PackageConfigWrapper objItr : pkgConfigWrapperLst2){
                pkgConfigLst.add(objItr.pkgConfigObj);
            }
                    
            if(!validateCarMakeFields()){
                return pgRef;                                  //returns page to the Order Product record
            }
        }
        **/
                
        
        //If the KBB Lead Driver fields in Product Configuration are rendered true, add them to the Package Configuration list
        if((prodConfigObj.KBB_Lead_Driver_Fields__c)){
            for(PackageConfigWrapper objItr : pkgConfigWrapperLst4){
                pkgConfigLst.add(objItr.pkgConfigObj);
            }
                    
            if(!validateKbbLeadDriverFields()){
                return pgRef;                                  //returns page to the Order Product record
            }
        }
        
        if(orderItemObj.Configured__c == true && !this.validateRequiredFields()){
            return pgRef;                                      //returns page to the Order Product record
        }
        
        for(PackageConfigWrapper objItr : deleteQueuePkgConfigWrp){
            deletePkgConfigLst.add(objItr.pkgConfigObj);
        }
        
       
        try{
            update orderItemObj;  
            if(!pkgConfigLst.isEmpty()){
                upsert pkgConfigLst;
            }
            delete deletePkgConfigLst;
        }
        catch(Exception e){
            System.debug(LoggingLevel.ERROR, e.getMessage() + e.getStackTraceString());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.Internal_Error_Message));
        }
        
        pgRef = new PageReference('/' + orderItemObj.OrderId);                          //returns page to the Order Product record
        if(ApexPages.currentPage().getParameters().get('retURL') != null){
            pgRef = new PageReference(ApexPages.currentPage().getParameters().get('retURL'));
        }
        return pgRef;
    }
    
    public PageReference cancelAction(){
        PageReference pgRef = new PageReference('/' + orderItemObj.OrderId);            //returns page to the Order Product record
        if(ApexPages.currentPage().getParameters().get('retURL') != null){
            pgRef = new PageReference(ApexPages.currentPage().getParameters().get('retURL'));
        }
        return pgRef;
    }
    
    /**
     * validateRequiredFields     
     * @description:        Method that checks all the fields available in the Order Product have values.
     * @return:             Tag that indicates all fields are validated and have values   
     */     
    public Boolean validateRequiredFields(){        
        fieldMap = Schema.getGlobalDescribe().get('Product_Configuration__c').getDescribe().fields.getMap();
        List<String> failedFields = new List<String>();
        try{
            this.processProductConfigRuleSetup();            //check rules from Product Config Custom Setting
        }
        catch(Exception e){
            System.debug(LoggingLevel.ERROR, 'OrderConfigurationController:validateRequiredFields(): Error while processing Product Config Rule Setup custom setting');
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Error while processing Product Config Rule Setup custom setting'));
        }
             
        for(Schema.SObjectField sfield : fieldMap.Values()){
            Schema.describefieldresult dfield = sfield.getDescribe();               
            if(prodConfigObj.get(dfield.getName()) == true){
                if(!(prodConfigExceptionFields.contains(dfield.getName()))){                    
                    sObject oItem = orderItemObj;
                    String fieldVal = String.valueOf(oItem.get(dfield.getName()));
                    if(fieldVal == null){
                        failedFields.add(dfield.getLabel());
                        System.debug(LoggingLevel.ERROR, 'OrderConfigurationController:validateRequiredFields(): Validation failed for: ' + dfield.getName());
                    }
                } 
            }
        }
        
        if(!failedFields.isEmpty()){
            System.debug(LoggingLevel.ERROR, 'OrderConfigurationController:validateRequiredFields(): Validation failed for: ' + failedFields);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,  failedFields + '<br/>'+ Label.Order_Product_Required_Fields_Message));
            return false;
        }  
        return true;       
    }
    
    /**
     * processProductConfigRuleSetup
     * @description:        Method that process the Product Configuration Rule in Custom Setting
     */
    private void processProductConfigRuleSetup(){        
        Map<String, Product_Config_Rule_Setup__c> prodCongifLst = Product_Config_Rule_Setup__c.getAll();        //get all Custom Setting data
        String fieldValue;
        
        for(String sett : prodCongifLst.keySet()){            
            Product_Config_Rule_Setup__c prodConfigSett = Product_Config_Rule_Setup__c.getValues(sett);         //get all the field values associated to the data set
            if(prodConfigSett.Rule_Type__c == Constants.EXCEPTION_RULE){
                if(prodConfigSett.Product_SKU_Name__c == Constants.PRODUCT_SKU_ALL){
                    if(prodConfigSett.Controlling_Field_API_Name__c == Constants.CONTROLLING_FIELD_NONE){
                        prodConfigExceptionFields.add(prodConfigSett.Dependent_Field_API_Name__c);
                    }
                }
                else if(prodConfigSett.Product_SKU_Name__c == orderItemObj.PricebookEntry.Product2.Name){
                    if(prodConfigSett.Controlling_Field_API_Name__c == Constants.CONTROLLING_FIELD_NONE){
                        prodConfigExceptionFields.add(prodConfigSett.Dependent_Field_API_Name__c);
                    }                    
                }
            }
            else if(prodConfigSett.Rule_Type__c == Constants.CONDITIONAL_RULE){
                if(prodConfigSett.Product_SKU_Name__c == Constants.PRODUCT_SKU_ALL){
                    for(Schema.SObjectField soField : fieldMap.Values()){                                       //get Field Name to compare in the Custom Setting Controlling Field Name
                        Schema.describefieldresult desfield = soField.getDescribe();
                        if(prodConfigSett.Controlling_Field_API_Name__c == desfield.getName()){
                            fieldValue = String.valueOf(orderItemObj.get(desfield.getName()));  
                            if(fieldValue != null){
                                if(fieldValue == Constants.STATE_FALSE){
                                    prodConfigExceptionFields.add(prodConfigSett.Dependent_Field_API_Name__c);
                                }
                                else {
                                    prodConfigExceptionFields.remove(prodConfigSett.Dependent_Field_API_Name__c);
                                }
                            }
                        }
                    }
                }
                else if(prodConfigSett.Product_SKU_Name__c == orderItemObj.PricebookEntry.Product2.Name){
                    for(Schema.SObjectField soField : fieldMap.Values()){
                        Schema.describefieldresult desfield = soField.getDescribe();
                        if(prodConfigSett.Controlling_Field_API_Name__c == desfield.getName()){
                            fieldValue = String.valueOf(orderItemObj.get(desfield.getName()));  
                            if(fieldValue != null){
                                if(fieldValue == Constants.STATE_FALSE){
                                    prodConfigExceptionFields.add(prodConfigSett.Dependent_Field_API_Name__c);
                                }
                                else {
                                    prodConfigExceptionFields.remove(prodConfigSett.Dependent_Field_API_Name__c);
                                }
                            }
                        }
                    }                    
                }
            }
        }
        System.debug('//test exception list: ' + prodConfigExceptionFields);
    }
    
    /**
     * validateTierFields     
     * @description:        Method that checks all the fields in Tier Governor section have values.
     * @return:             Tag that indicates all fields are validated and have values   
     */     
    public Boolean validateTierFields(){              
        for(PackageConfigWrapper pkgTier : pkgConfigWrapperLst){
            if(pkgTier.pkgConfigObj.Tier_Governor_Type__c != null){
                if(pkgTier.pkgConfigObj.Tier_Governor_Value__c == null 
                    || pkgTier.pkgConfigObj.Tier_Governor_Advertised_Make__c == null
                    || pkgTier.pkgConfigObj.Tier_Governor_Vehicle_Quantity__c == null 
                    || pkgTier.pkgConfigObj.Tier_Governor_Vehicle_Monthly_Rate__c == null
                    || pkgTier.pkgConfigObj.Tier_Governor_Co_op_Level_of_Service__c == null){
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.Order_Product_Tier_Governor_Required_Fields));
                        return false;
                }
            }
            else {
                System.debug(LoggingLevel.ERROR, 'OrderConfigurationController:validateTierFields(): Validation failed for Tier Governor Fields ');
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.Order_Product_Tier_Governor_Required_Fields));
                return false;
            }      
        }
        return true;
    }
    
    /**
     * validateTierFields     
     * @description:        Method that checks all the fields in Car Make section have values.
     * @return:             Tag that indicates all fields are validated and have values   
     */     
     /**
     public Boolean validateCarMakeFields(){
        Boolean isSuccess = true;
        for(PackageConfigWrapper pkgCM : pkgConfigWrapperLst2){
            if(prodConfigObj.New_Car_Make_Fields_GM_Package__c){
                if(pkgCM.pkgConfigObj.New_Car_Make__c == null || pkgCM.pkgConfigObj.New_Car_Make_Quantity__c == null){
                    isSuccess = false;
                }
                else if(pkgCM.pkgConfigObj.New_Car_Make__c == 'Not Applicable' && pkgCM.pkgConfigObj.New_Car_Make_Quantity__c == 0){
                    isSuccess = true;
                }
            }
            
            if(prodConfigObj.Used_Car_Make_GM_Package__c){
                if(pkgCM.pkgConfigObj.Used_Car_Make__c == null || pkgCM.pkgConfigObj.Used_Car_Make_Quantity__c == null){
                        isSuccess = false;
                    }
                else if(pkgCM.pkgConfigObj.Used_Car_Make__c == 'Not Applicable' && pkgCM.pkgConfigObj.Used_Car_Make_Quantity__c == 0){
                    isSuccess = true;
                    }  
            }    
                      
            if(prodConfigObj.Front_Line_Pro_Model_Fields_GM_Package__c && pkgCM.pkgConfigObj.Front_Line_Pro_Model__c == null){
                isSuccess = false;
            }
            
            if(!isSuccess){
                break;
            }
            
         }
         
         if(!isSuccess){
             System.debug(LoggingLevel.ERROR, 'OrderConfigurationController:validateCarMakeFields(): Validation failed for Car Make Fields ');
             ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.Order_Product_Car_Make_Required_Fields));
         }
         return isSuccess;
    }
    **/    
    
    public Boolean validateKbbLeadDriverFields(){
        Boolean isSuccess = true;
        for(PackageConfigWrapper pkgCM : pkgConfigWrapperLst4){
            if(prodConfigObj.KBB_Lead_Driver_Fields__c && (pkgCM.pkgConfigObj.Dealer_Website_URL__c == null 
            //|| pkgCM.pkgConfigObj.Text_Email_Address__c == null
            //|| pkgCM.pkgConfigObj.XML_Email_Address__c == null
            || pkgCM.pkgConfigObj.Make_KBB_Lead_Driver__c == null)){
                isSuccess = false;
            }            
            
            if(!isSuccess){
                break;
            }
         }
         
         if(!isSuccess){
             System.debug(LoggingLevel.ERROR, 'OrderConfigurationController:validateKbbLeadDriverFields(): Validation failed for KBB Lead Driver Fields ');
             ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.Order_Product_KBB_Lead_Driver_Required_Fields));
         }
         return isSuccess;
    }

    /**
     * PackageConfigWrapper     
     * @description:        Class that captures the Package Configuration record related to the Order Item,
     *                      and dynamically displays the Tier Governor Type picklist value depending on the user selection.
     */     
    public class PackageConfigWrapper{
        public Package_Configuration__c pkgConfigObj {get; set;}
        public List<SelectOption> tierGovPkLstVal {get; set;}
        
        public PackageConfigWrapper(){
            pkgConfigObj = new Package_Configuration__c();
            tierGovPkLstVal = new List<SelectOption>{new SelectOption('', Constants.NONE)};
        }
        public PackageConfigWrapper(Package_Configuration__c pkgObj){
            this();
            pkgConfigObj = pkgObj;
            this.updateTierGovPkLstVal(true, true, true);            
        }

        public void updateTierGovPkLstVal(Boolean addMake, Boolean addEarlyModel, Boolean addAllCar){
            if(addMake != null && addMake){
                tierGovPkLstVal.add(new SelectOption(Constants.MAKE, Constants.MAKE));
            }
            if(addEarlyModel != null && addEarlyModel){
                tierGovPkLstVal.add(new SelectOption(Constants.EARLY_MODEL, Constants.EARLY_MODEL));
            }
            if(addAllCar != null && addAllCar){
                tierGovPkLstVal.add(new SelectOption(Constants.ALL_CAR, Constants.ALL_CAR));
            }
        }
    }
  
}