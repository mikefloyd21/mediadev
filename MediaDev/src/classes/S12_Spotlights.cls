global with sharing class S12_Spotlights extends SkyEditor2.SkyEditorPageBaseWithSharing {
    
    public Opp_Product__c record {get{return (Opp_Product__c)mainRecord;}}
    public with sharing class CanvasException extends Exception {}

    public String recordTypeRecordsJSON_Opp_Product_c {get; private set;}
    public String defaultRecordTypeId_Opp_Product_c {get; private set;}
    public String metadataJSON_Opp_Product_c {get; private set;}
    public String picklistValuesJSON_Opp_Product_c_Business_Type_c {get; private set;}
    public String picklistValuesJSON_Opp_Product_c_Duration_1_c {get; private set;}
    public String picklistValuesJSON_Opp_Product_c_Deliver_1_c {get; private set;}
    public String picklistValuesJSON_Opp_Product_c_Type_1_c {get; private set;}
    public String picklistValuesJSON_Opp_Product_c_Duration_2_c {get; private set;}
    public String picklistValuesJSON_Opp_Product_c_Deliver_2_c {get; private set;}
    public String picklistValuesJSON_Opp_Product_c_Type_2_c {get; private set;}
    public String picklistValuesJSON_Opp_Product_c_Duration_3_c {get; private set;}
    public String picklistValuesJSON_Opp_Product_c_Deliver_3_c {get; private set;}
    public String picklistValuesJSON_Opp_Product_c_Type_3_c {get; private set;}
    public String picklistValuesJSON_Opp_Product_c_Required_Information_c {get; private set;}
    public Map<String,Map<String,Object>> appComponentProperty {get; set;}
    public S12_SpotlightsExtender getExtender() {return (S12_SpotlightsExtender)extender;}
    
    
    public S12_Spotlights(ApexPages.StandardController controller) {
        super(controller);

        appComponentProperty = new Map<String, Map<String, Object>>();
        Map<String, Object> tmpPropMap = null;

        tmpPropMap = new Map<String,Object>();
        tmpPropMap.put('id','');
        tmpPropMap.put('top','');
        tmpPropMap.put('left','');
        tmpPropMap.put('width','');
        tmpPropMap.put('height','');
        tmpPropMap.put('rendered','');
        tmpPropMap.put('Component__Width','1024');
        tmpPropMap.put('Component__Height','272');
        tmpPropMap.put('Component__id','Component1');
        tmpPropMap.put('Component__Name','OppProdFormHeader');
        tmpPropMap.put('Component__NameSpace','');
        tmpPropMap.put('Component__Top','127');
        tmpPropMap.put('Component__Left','0');
        appComponentProperty.put('Component1',tmpPropMap);


        SObjectField f;

        f = Opp_Product__c.fields.Business_Type__c;
        f = Opp_Product__c.fields.Duration_1__c;
        f = Opp_Product__c.fields.Vehicle_Type_1__c;
        f = Opp_Product__c.fields.Deliver_1__c;
        f = Opp_Product__c.fields.Type_1__c;
        f = Opp_Product__c.fields.Monthly_Quantity_1__c;
        f = Opp_Product__c.fields.New_Car_Make_1__c;
        f = Opp_Product__c.fields.Duration_2__c;
        f = Opp_Product__c.fields.Vehicle_Type_2__c;
        f = Opp_Product__c.fields.Deliver_2__c;
        f = Opp_Product__c.fields.Type_2__c;
        f = Opp_Product__c.fields.New_Car_Make_2__c;
        f = Opp_Product__c.fields.Monthly_Quantity_2__c;
        f = Opp_Product__c.fields.Duration_3__c;
        f = Opp_Product__c.fields.Vehicle_Type_3__c;
        f = Opp_Product__c.fields.Deliver_3__c;
        f = Opp_Product__c.fields.Type_3__c;
        f = Opp_Product__c.fields.New_Car_Make_3__c;
        f = Opp_Product__c.fields.Monthly_Quantity_3__c;
        f = Opp_Product__c.fields.Notes__c;
        f = Opp_Product__c.fields.Required_Information__c;
        f = Opp_Product__c.fields.Total_Production_Cost__c;
        f = Opp_Product__c.fields.Total_Monthly_Rate__c;
        f = Opp_Product__c.fields.Monthly_Base_Rate_2__c;
        f = Opp_Product__c.fields.Monthly_Base_Rate_3__c;
        f = Opp_Product__c.fields.Monthly_Base_Rate_1__c;

        List<RecordTypeInfo> recordTypes;
        List<RecordType> recordTypeRecords_Opp_Product_c = [SELECT Id, DeveloperName, NamespacePrefix FROM RecordType WHERE SobjectType = 'Opp_Product__c'];
        Map<Id, RecordType> recordTypeMap_Opp_Product_c = new Map<Id, RecordType>(recordTypeRecords_Opp_Product_c);
        List<RecordType> availableRecordTypes_Opp_Product_c = new List<RecordType>();
        recordTypeRecordsJSON_Opp_Product_c = System.JSON.serialize(recordTypeRecords_Opp_Product_c);
        recordTypes = SObjectType.Opp_Product__c.getRecordTypeInfos();

        for (RecordTypeInfo t: recordTypes) {
            if (t.isDefaultRecordTypeMapping()) {
                defaultRecordTypeId_Opp_Product_c = t.getRecordTypeId();
            }
            if (t.isAvailable()) {
                RecordType rtype = recordTypeMap_Opp_Product_c.get(t.getRecordTypeId());
                if (rtype != null) {
                    availableRecordTypes_Opp_Product_c.add(rtype);
                }
            }
        }
        metadataJSON_Opp_Product_c = System.JSON.serialize(filterMetadataJSON(
            System.JSON.deserializeUntyped('{"CustomObject":{"recordTypes":[{"fullName":"S12_Featured","picklistValues":[{"picklist":"Business_Type__c","values":[{"fullName":"AD","default":false},{"fullName":"DN","default":false},{"fullName":"NB","default":false},{"fullName":"UP","default":false}]},{"picklist":"Deliver_1__c","values":[{"fullName":"Deliver 1st of next month","default":false},{"fullName":"Deliver Now","default":false}]},{"picklist":"Deliver_2__c","values":[{"fullName":"Deliver 1st of next month","default":false},{"fullName":"Deliver Now","default":false}]},{"picklist":"Deliver_3__c","values":[{"fullName":"Deliver 1st of next month","default":false},{"fullName":"Deliver Now","default":false}]},{"picklist":"Duration_1__c","values":[{"fullName":"14 Day %28inc%2E car swap%29","default":false},{"fullName":"28 Day %28inc%2E car swap%29","default":false},{"fullName":"4 Day","default":false},{"fullName":"7 Day","default":false}]},{"picklist":"Duration_2__c","values":[{"fullName":"14 Day %28inc%2E car swap%29","default":false},{"fullName":"28 Day %28inc%2E car swap%29","default":false},{"fullName":"4 Day","default":false},{"fullName":"7 Day","default":false}]},{"picklist":"Duration_3__c","values":[{"fullName":"14 Day %28inc%2E car swap%29","default":false},{"fullName":"28 Day %28inc%2E car swap%29","default":false},{"fullName":"4 Day","default":false},{"fullName":"7 Day","default":false}]},{"picklist":"Required_Information__c","values":[{"fullName":"In Addition to Current Spotlights","default":false},{"fullName":"Replace Current Spotlights","default":false}]},{"picklist":"Type_1__c","values":[{"fullName":"BASE","default":false},{"fullName":"PLATINUM","default":false}]},{"picklist":"Type_2__c","values":[{"fullName":"BASE","default":false},{"fullName":"PLATINUM","default":false}]},{"picklist":"Type_3__c","values":[{"fullName":"BASE","default":false},{"fullName":"PLATINUM","default":false}]}]},{"fullName":"S12_KBB_Used","picklistValues":[{"picklist":"Business_Type__c","values":[{"fullName":"AD","default":false},{"fullName":"DN","default":false},{"fullName":"NB","default":false},{"fullName":"UP","default":false}]},{"picklist":"Deliver_1__c","values":[{"fullName":"Deliver 1st of next month","default":false},{"fullName":"Deliver Now","default":false}]},{"picklist":"Deliver_2__c","values":[{"fullName":"Deliver 1st of next month","default":false},{"fullName":"Deliver Now","default":false}]},{"picklist":"Deliver_3__c","values":[{"fullName":"Deliver 1st of next month","default":false},{"fullName":"Deliver Now","default":false}]},{"picklist":"Duration_1__c","values":[{"fullName":"14 Day %28inc%2E car swap%29","default":false},{"fullName":"28 Day %28inc%2E car swap%29","default":false},{"fullName":"4 Day","default":false},{"fullName":"7 Day","default":false}]},{"picklist":"Duration_2__c","values":[{"fullName":"14 Day %28inc%2E car swap%29","default":false},{"fullName":"28 Day %28inc%2E car swap%29","default":false},{"fullName":"4 Day","default":false},{"fullName":"7 Day","default":false}]},{"picklist":"Duration_3__c","values":[{"fullName":"14 Day %28inc%2E car swap%29","default":false},{"fullName":"28 Day %28inc%2E car swap%29","default":false},{"fullName":"4 Day","default":false},{"fullName":"7 Day","default":false}]},{"picklist":"Required_Information__c","values":[{"fullName":"In Addition to Current Spotlights","default":false},{"fullName":"Replace Current Spotlights","default":false}]},{"picklist":"Type_1__c","values":[{"fullName":"BASE","default":false},{"fullName":"PLATINUM","default":false}]},{"picklist":"Type_2__c","values":[{"fullName":"BASE","default":false},{"fullName":"PLATINUM","default":false}]},{"picklist":"Type_3__c","values":[{"fullName":"BASE","default":false},{"fullName":"PLATINUM","default":false}]}]},{"fullName":"S12_Premium","picklistValues":[{"picklist":"Business_Type__c","values":[{"fullName":"AD","default":false},{"fullName":"DN","default":false},{"fullName":"NB","default":false},{"fullName":"UP","default":false}]},{"picklist":"Deliver_1__c","values":[{"fullName":"Deliver 1st of next month","default":false},{"fullName":"Deliver Now","default":false}]},{"picklist":"Deliver_2__c","values":[{"fullName":"Deliver 1st of next month","default":false},{"fullName":"Deliver Now","default":false}]},{"picklist":"Deliver_3__c","values":[{"fullName":"Deliver 1st of next month","default":false},{"fullName":"Deliver Now","default":false}]},{"picklist":"Duration_1__c","values":[{"fullName":"14 Day %28inc%2E car swap%29","default":false},{"fullName":"28 Day %28inc%2E car swap%29","default":false},{"fullName":"4 Day","default":false},{"fullName":"7 Day","default":false}]},{"picklist":"Duration_2__c","values":[{"fullName":"14 Day %28inc%2E car swap%29","default":false},{"fullName":"28 Day %28inc%2E car swap%29","default":false},{"fullName":"4 Day","default":false},{"fullName":"7 Day","default":false}]},{"picklist":"Duration_3__c","values":[{"fullName":"14 Day %28inc%2E car swap%29","default":false},{"fullName":"28 Day %28inc%2E car swap%29","default":false},{"fullName":"4 Day","default":false},{"fullName":"7 Day","default":false}]},{"picklist":"Required_Information__c","values":[{"fullName":"In Addition to Current Spotlights","default":false},{"fullName":"Replace Current Spotlights","default":false}]},{"picklist":"Type_1__c","values":[{"fullName":"BASE","default":false},{"fullName":"PLATINUM","default":false}]},{"picklist":"Type_2__c","values":[{"fullName":"BASE","default":false},{"fullName":"PLATINUM","default":false}]},{"picklist":"Type_3__c","values":[{"fullName":"BASE","default":false},{"fullName":"PLATINUM","default":false}]}]},{"fullName":"S12_Premium_Core","picklistValues":[{"picklist":"Business_Type__c","values":[{"fullName":"AD","default":false},{"fullName":"DN","default":false},{"fullName":"NB","default":false},{"fullName":"UP","default":false}]},{"picklist":"Deliver_1__c","values":[{"fullName":"Deliver 1st of next month","default":false},{"fullName":"Deliver Now","default":false}]},{"picklist":"Deliver_2__c","values":[{"fullName":"Deliver 1st of next month","default":false},{"fullName":"Deliver Now","default":false}]},{"picklist":"Deliver_3__c","values":[{"fullName":"Deliver 1st of next month","default":false},{"fullName":"Deliver Now","default":false}]},{"picklist":"Duration_1__c","values":[{"fullName":"14 Day %28inc%2E car swap%29","default":false},{"fullName":"28 Day %28inc%2E car swap%29","default":false},{"fullName":"4 Day","default":false},{"fullName":"7 Day","default":false}]},{"picklist":"Duration_2__c","values":[{"fullName":"14 Day %28inc%2E car swap%29","default":false},{"fullName":"28 Day %28inc%2E car swap%29","default":false},{"fullName":"4 Day","default":false},{"fullName":"7 Day","default":false}]},{"picklist":"Duration_3__c","values":[{"fullName":"14 Day %28inc%2E car swap%29","default":false},{"fullName":"28 Day %28inc%2E car swap%29","default":false},{"fullName":"4 Day","default":false},{"fullName":"7 Day","default":false}]},{"picklist":"Required_Information__c","values":[{"fullName":"In Addition to Current Spotlights","default":false},{"fullName":"Replace Current Spotlights","default":false}]},{"picklist":"Type_1__c","values":[{"fullName":"BASE","default":false},{"fullName":"PLATINUM","default":false}]},{"picklist":"Type_2__c","values":[{"fullName":"BASE","default":false},{"fullName":"PLATINUM","default":false}]},{"picklist":"Type_3__c","values":[{"fullName":"BASE","default":false},{"fullName":"PLATINUM","default":false}]}]},{"fullName":"S12_Spotlights","picklistValues":[{"picklist":"Business_Type__c","values":[{"fullName":"AD","default":false},{"fullName":"DN","default":false},{"fullName":"NB","default":false},{"fullName":"UP","default":false}]},{"picklist":"Deliver_1__c","values":[{"fullName":"Deliver 1st of next month","default":false},{"fullName":"Deliver Now","default":false}]},{"picklist":"Deliver_2__c","values":[{"fullName":"Deliver 1st of next month","default":false},{"fullName":"Deliver Now","default":false}]},{"picklist":"Deliver_3__c","values":[{"fullName":"Deliver 1st of next month","default":false},{"fullName":"Deliver Now","default":false}]},{"picklist":"Duration_1__c","values":[{"fullName":"14 Day %28inc%2E car swap%29","default":false},{"fullName":"28 Day %28inc%2E car swap%29","default":false},{"fullName":"4 Day","default":false},{"fullName":"7 Day","default":false}]},{"picklist":"Duration_2__c","values":[{"fullName":"14 Day %28inc%2E car swap%29","default":false},{"fullName":"28 Day %28inc%2E car swap%29","default":false},{"fullName":"4 Day","default":false},{"fullName":"7 Day","default":false}]},{"picklist":"Duration_3__c","values":[{"fullName":"14 Day %28inc%2E car swap%29","default":false},{"fullName":"28 Day %28inc%2E car swap%29","default":false},{"fullName":"4 Day","default":false},{"fullName":"7 Day","default":false}]},{"picklist":"Required_Information__c","values":[{"fullName":"In Addition to Current Spotlights","default":false},{"fullName":"Replace Current Spotlights","default":false}]},{"picklist":"Type_1__c","values":[{"fullName":"BASE","default":false},{"fullName":"PLATINUM","default":false}]},{"picklist":"Type_2__c","values":[{"fullName":"BASE","default":false},{"fullName":"PLATINUM","default":false}]},{"picklist":"Type_3__c","values":[{"fullName":"BASE","default":false},{"fullName":"PLATINUM","default":false}]}]},{"fullName":"S14_New","picklistValues":[{"picklist":"Business_Type__c","values":[{"fullName":"AD","default":false},{"fullName":"DN","default":false},{"fullName":"NB","default":false},{"fullName":"UP","default":false}]},{"picklist":"Deliver_1__c","values":[{"fullName":"Deliver 1st of next month","default":false},{"fullName":"Deliver Now","default":false}]},{"picklist":"Deliver_2__c","values":[{"fullName":"Deliver 1st of next month","default":false},{"fullName":"Deliver Now","default":false}]},{"picklist":"Deliver_3__c","values":[{"fullName":"Deliver 1st of next month","default":false},{"fullName":"Deliver Now","default":false}]},{"picklist":"Duration_1__c","values":[{"fullName":"14 Day %28inc%2E car swap%29","default":false},{"fullName":"28 Day %28inc%2E car swap%29","default":false},{"fullName":"4 Day","default":false},{"fullName":"7 Day","default":false}]},{"picklist":"Duration_2__c","values":[{"fullName":"14 Day %28inc%2E car swap%29","default":false},{"fullName":"28 Day %28inc%2E car swap%29","default":false},{"fullName":"4 Day","default":false},{"fullName":"7 Day","default":false}]},{"picklist":"Duration_3__c","values":[{"fullName":"14 Day %28inc%2E car swap%29","default":false},{"fullName":"28 Day %28inc%2E car swap%29","default":false},{"fullName":"4 Day","default":false},{"fullName":"7 Day","default":false}]},{"picklist":"Required_Information__c","values":[{"fullName":"In Addition to Current Spotlights","default":false},{"fullName":"Replace Current Spotlights","default":false}]},{"picklist":"Type_1__c","values":[{"fullName":"BASE","default":false},{"fullName":"PLATINUM","default":false}]},{"picklist":"Type_2__c","values":[{"fullName":"BASE","default":false},{"fullName":"PLATINUM","default":false}]},{"picklist":"Type_3__c","values":[{"fullName":"BASE","default":false},{"fullName":"PLATINUM","default":false}]}]},{"fullName":"Skyscrapers","picklistValues":[{"picklist":"Business_Type__c","values":[{"fullName":"AD","default":false},{"fullName":"DN","default":false},{"fullName":"NB","default":false},{"fullName":"UP","default":false}]},{"picklist":"Deliver_1__c","values":[{"fullName":"Deliver 1st of next month","default":false},{"fullName":"Deliver Now","default":false}]},{"picklist":"Deliver_2__c","values":[{"fullName":"Deliver 1st of next month","default":false},{"fullName":"Deliver Now","default":false}]},{"picklist":"Deliver_3__c","values":[{"fullName":"Deliver 1st of next month","default":false},{"fullName":"Deliver Now","default":false}]},{"picklist":"Duration_1__c","values":[{"fullName":"14 Day %28inc%2E car swap%29","default":false},{"fullName":"28 Day %28inc%2E car swap%29","default":false},{"fullName":"4 Day","default":false},{"fullName":"7 Day","default":false}]},{"picklist":"Duration_2__c","values":[{"fullName":"14 Day %28inc%2E car swap%29","default":false},{"fullName":"28 Day %28inc%2E car swap%29","default":false},{"fullName":"4 Day","default":false},{"fullName":"7 Day","default":false}]},{"picklist":"Duration_3__c","values":[{"fullName":"14 Day %28inc%2E car swap%29","default":false},{"fullName":"28 Day %28inc%2E car swap%29","default":false},{"fullName":"4 Day","default":false},{"fullName":"7 Day","default":false}]},{"picklist":"Required_Information__c","values":[{"fullName":"In Addition to Current Spotlights","default":false},{"fullName":"Replace Current Spotlights","default":false}]},{"picklist":"Type_1__c","values":[{"fullName":"BASE","default":false},{"fullName":"PLATINUM","default":false}]},{"picklist":"Type_2__c","values":[{"fullName":"BASE","default":false},{"fullName":"PLATINUM","default":false}]},{"picklist":"Type_3__c","values":[{"fullName":"BASE","default":false},{"fullName":"PLATINUM","default":false}]}]}]}}'),
            recordTypeFullNames(availableRecordTypes_Opp_Product_c)
        ));
        picklistValuesJSON_Opp_Product_c_Business_Type_c = System.JSON.serialize(Opp_Product__c.SObjectType.Business_Type__c.getDescribe().getPicklistValues());
        picklistValuesJSON_Opp_Product_c_Duration_1_c = System.JSON.serialize(Opp_Product__c.SObjectType.Duration_1__c.getDescribe().getPicklistValues());
        picklistValuesJSON_Opp_Product_c_Deliver_1_c = System.JSON.serialize(Opp_Product__c.SObjectType.Deliver_1__c.getDescribe().getPicklistValues());
        picklistValuesJSON_Opp_Product_c_Type_1_c = System.JSON.serialize(Opp_Product__c.SObjectType.Type_1__c.getDescribe().getPicklistValues());
        picklistValuesJSON_Opp_Product_c_Duration_2_c = System.JSON.serialize(Opp_Product__c.SObjectType.Duration_2__c.getDescribe().getPicklistValues());
        picklistValuesJSON_Opp_Product_c_Deliver_2_c = System.JSON.serialize(Opp_Product__c.SObjectType.Deliver_2__c.getDescribe().getPicklistValues());
        picklistValuesJSON_Opp_Product_c_Type_2_c = System.JSON.serialize(Opp_Product__c.SObjectType.Type_2__c.getDescribe().getPicklistValues());
        picklistValuesJSON_Opp_Product_c_Duration_3_c = System.JSON.serialize(Opp_Product__c.SObjectType.Duration_3__c.getDescribe().getPicklistValues());
        picklistValuesJSON_Opp_Product_c_Deliver_3_c = System.JSON.serialize(Opp_Product__c.SObjectType.Deliver_3__c.getDescribe().getPicklistValues());
        picklistValuesJSON_Opp_Product_c_Type_3_c = System.JSON.serialize(Opp_Product__c.SObjectType.Type_3__c.getDescribe().getPicklistValues());
        picklistValuesJSON_Opp_Product_c_Required_Information_c = System.JSON.serialize(Opp_Product__c.SObjectType.Required_Information__c.getDescribe().getPicklistValues());
        try {
            mainSObjectType = Opp_Product__c.SObjectType;
            setPageReferenceFactory(new PageReferenceFactory());
            
            mainQuery = new SkyEditor2.Query('Opp_Product__c');
            mainQuery.addField('Business_Type__c');
            mainQuery.addField('Duration_1__c');
            mainQuery.addField('Vehicle_Type_1__c');
            mainQuery.addField('Deliver_1__c');
            mainQuery.addField('Type_1__c');
            mainQuery.addField('Monthly_Quantity_1__c');
            mainQuery.addField('New_Car_Make_1__c');
            mainQuery.addField('Duration_2__c');
            mainQuery.addField('Vehicle_Type_2__c');
            mainQuery.addField('Deliver_2__c');
            mainQuery.addField('Type_2__c');
            mainQuery.addField('New_Car_Make_2__c');
            mainQuery.addField('Monthly_Quantity_2__c');
            mainQuery.addField('Duration_3__c');
            mainQuery.addField('Vehicle_Type_3__c');
            mainQuery.addField('Deliver_3__c');
            mainQuery.addField('Type_3__c');
            mainQuery.addField('New_Car_Make_3__c');
            mainQuery.addField('Monthly_Quantity_3__c');
            mainQuery.addField('Notes__c');
            mainQuery.addField('Required_Information__c');
            mainQuery.addField('Total_Production_Cost__c');
            mainQuery.addField('Total_Monthly_Rate__c');
            mainQuery.addField('Monthly_Base_Rate_2__c');
            mainQuery.addField('Monthly_Base_Rate_3__c');
            mainQuery.addField('Monthly_Base_Rate_1__c');
            mainQuery.addFieldAsOutput('Name');
            mainQuery.addFieldAsOutput('RecordTypeId');
            mainQuery.addWhere('Id', mainRecord.Id, SkyEditor2.WhereOperator.Eq)
                .limitRecords(1);
            
            
            
            mode = SkyEditor2.LayoutMode.LayoutFree; 
            
            queryMap = new Map<String, SkyEditor2.Query>();
            SkyEditor2.Query query;
            
            
            p_showHeader = true;
            p_sidebar = true;
            addInheritParameter('RecordTypeId', 'RecordType');
            extender = new S12_SpotlightsExtender(this);
            init();
            
            if (record.Id == null) {
                
                saveOldValues();
                
            }

            
            extender.init();
            
        }  catch (SkyEditor2.Errors.FieldNotFoundException e) {
            fieldNotFound(e);
        } catch (SkyEditor2.Errors.RecordNotFoundException e) {
            recordNotFound(e);
        } catch (SkyEditor2.ExtenderException e) {
            e.setMessagesToPage();
        }
    }
    

    private void sObjectNotFound(SkyEditor2.Errors.SObjectNotFoundException e) {
        SkyEditor2.Messages.addErrorMessage(e.getMessage());
        hidePageBody = true;
    }
    private void fieldNotFound(SkyEditor2.Errors.FieldNotFoundException e) {
        SkyEditor2.Messages.addErrorMessage(e.getMessage());
        hidePageBody = true;
    }
    private void recordNotFound(SkyEditor2.Errors.RecordNotFoundException e) {
        SkyEditor2.Messages.addErrorMessage(e.getMessage());
        hidePageBody = true;
    }
    
    private static testMethod void testPageMethods() {        S12_Spotlights extension = new S12_Spotlights(new ApexPages.StandardController(new Opp_Product__c()));
        SkyEditor2.Messages.clear();
        extension.sObjectNotFound(new SkyEditor2.Errors.SObjectNotFoundException(SkyEditor2.Messages.sObjectNotFound('SkyEditor2__SkyEditorDummy__c')));
        System.assert(extension.getErrorMessages().endsWith(SkyEditor2.Messages.sObjectNotFound('SkyEditor2__SkyEditorDummy__c')));
        SkyEditor2.Messages.clear();
        extension.fieldNotFound(new SkyEditor2.Errors.FieldNotFoundException(SkyEditor2.Messages.fieldNotFound(SkyEditor2__SkyEditorDummy__c.SObjectType, 'Name')));
        System.assert(extension.getErrorMessages().endsWith(SkyEditor2.Messages.fieldNotFound(SkyEditor2__SkyEditorDummy__c.SObjectType, 'Name')));
        SkyEditor2.Messages.clear();
        extension.recordNotFound(new SkyEditor2.Errors.RecordNotFoundException(SkyEditor2.Messages.DATA_NOT_FOUND));
        System.assert(extension.getErrorMessages().endsWith(SkyEditor2.Messages.DATA_NOT_FOUND));

        Integer defaultSize;
        extension.getComponent42OptionsJS();
        extension.getComponent28OptionsJS();
        extension.getComponent13OptionsJS();
        extension.getComponent31OptionsJS();
        extension.getComponent29OptionsJS();
        extension.getComponent14OptionsJS();
        extension.getComponent32OptionsJS();
        extension.getComponent30OptionsJS();
        extension.getComponent15OptionsJS();
        extension.getComponent33OptionsJS();
        extension.getComponent37OptionsJS();
        extension.getExtender();
    }
    public String getComponent42OptionsJS() {
        return SkyEditor2.JSON.stringify(SkyEditor2.PicklistValueSelector.getEntries(
        Opp_Product__c.getSObjectType(),
        SObjectType.Opp_Product__c.fields.Business_Type__c.getSObjectField()
        ));
        }
    public String getComponent28OptionsJS() {
        return SkyEditor2.JSON.stringify(SkyEditor2.PicklistValueSelector.getEntries(
        Opp_Product__c.getSObjectType(),
        SObjectType.Opp_Product__c.fields.Duration_1__c.getSObjectField()
        ));
        }
    public String getComponent13OptionsJS() {
        return SkyEditor2.JSON.stringify(SkyEditor2.PicklistValueSelector.getEntries(
        Opp_Product__c.getSObjectType(),
        SObjectType.Opp_Product__c.fields.Deliver_1__c.getSObjectField()
        ));
        }
    public String getComponent31OptionsJS() {
        return SkyEditor2.JSON.stringify(SkyEditor2.PicklistValueSelector.getEntries(
        Opp_Product__c.getSObjectType(),
        SObjectType.Opp_Product__c.fields.Type_1__c.getSObjectField()
        ));
        }
    public String getComponent29OptionsJS() {
        return SkyEditor2.JSON.stringify(SkyEditor2.PicklistValueSelector.getEntries(
        Opp_Product__c.getSObjectType(),
        SObjectType.Opp_Product__c.fields.Duration_2__c.getSObjectField()
        ));
        }
    public String getComponent14OptionsJS() {
        return SkyEditor2.JSON.stringify(SkyEditor2.PicklistValueSelector.getEntries(
        Opp_Product__c.getSObjectType(),
        SObjectType.Opp_Product__c.fields.Deliver_2__c.getSObjectField()
        ));
        }
    public String getComponent32OptionsJS() {
        return SkyEditor2.JSON.stringify(SkyEditor2.PicklistValueSelector.getEntries(
        Opp_Product__c.getSObjectType(),
        SObjectType.Opp_Product__c.fields.Type_2__c.getSObjectField()
        ));
        }
    public String getComponent30OptionsJS() {
        return SkyEditor2.JSON.stringify(SkyEditor2.PicklistValueSelector.getEntries(
        Opp_Product__c.getSObjectType(),
        SObjectType.Opp_Product__c.fields.Duration_3__c.getSObjectField()
        ));
        }
    public String getComponent15OptionsJS() {
        return SkyEditor2.JSON.stringify(SkyEditor2.PicklistValueSelector.getEntries(
        Opp_Product__c.getSObjectType(),
        SObjectType.Opp_Product__c.fields.Deliver_3__c.getSObjectField()
        ));
        }
    public String getComponent33OptionsJS() {
        return SkyEditor2.JSON.stringify(SkyEditor2.PicklistValueSelector.getEntries(
        Opp_Product__c.getSObjectType(),
        SObjectType.Opp_Product__c.fields.Type_3__c.getSObjectField()
        ));
        }
    public String getComponent37OptionsJS() {
        return SkyEditor2.JSON.stringify(SkyEditor2.PicklistValueSelector.getEntries(
        Opp_Product__c.getSObjectType(),
        SObjectType.Opp_Product__c.fields.Required_Information__c.getSObjectField()
        ));
        }
    static Set<String> recordTypeFullNames(RecordType[] records) {
        Set<String> result = new Set<String>();
        for (RecordType r : records) {
            result.add(r.DeveloperName);
            if (r.NamespacePrefix != null) {
                result.add(r.NamespacePrefix + '__' + r.DeveloperName);
            }
        }
        return result;
    }
    
    static Object filterMetadataJSON(Object metadata, Set<String> recordTypeFullNames) {
        Map<String, Object> metadataMap = (Map<String, Object>) metadata;
        Map<String, Object> customObject = (Map<String, Object>) metadataMap.get('CustomObject');
        List<Object> recordTypes = (List<Object>) customObject.get('recordTypes');
        for (Integer i = recordTypes.size() - 1; i >= 0; i--) {
            Map<String, Object> recordType = (Map<String, Object>)recordTypes[i];
            String fullName = (String)recordType.get('fullName');
            if (! recordTypeFullNames.contains(fullName)) {
                recordTypes.remove(i);
                continue;
            }
        }
        return metadata;
    }
    
    private static testMethod void testRecordTypeFullNames() {
        Set<String> result = recordTypeFullNames(new RecordType[] {
            new RecordType(DeveloperName = 'TestRecordType')
        });
        System.assertEquals(result.size(), 1);
        System.assert(result.contains('TestRecordType'));
    }
    
    private static testMethod void testFilterMetadataJSON() {
        String json = '{"CustomObject":{"recordTypes":[{"fullName":"RecordType1"},{"fullName":"RecordType2"},{"fullName":"RecordType3"}]}}';        Set<String> recordTypeSet = new Set<String>();
        recordTypeSet.add('RecordType2');
        Object metadata = System.JSON.deserializeUntyped(json);
        Map<String, Object> result = (Map<String, Object>) filterMetadataJSON(metadata, recordTypeSet);
        Map<String, Object> customObject = (Map<String, Object>) result.get('CustomObject');
        List<Object> recordTypes = (List<Object>) customObject.get('recordTypes');
        System.assertEquals(recordTypes.size(), 1);
        Map<String, Object> recordType = (Map<String, Object>) recordTypes[0];
        System.assertEquals('RecordType2', recordType.get('fullName'));
    }
    with sharing class PageReferenceFactory implements SkyEditor2.PageReferenceFactory.Implementation {
        public PageReference newPageReference(String url) {
            return new PageReference(url);
        }
    }
}