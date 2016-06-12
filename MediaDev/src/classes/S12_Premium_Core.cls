global with sharing class S12_Premium_Core extends SkyEditor2.SkyEditorPageBaseWithSharing {
    
    public Opp_Product__c record {get{return (Opp_Product__c)mainRecord;}}
    public with sharing class CanvasException extends Exception {}

    public String recordTypeRecordsJSON_Opp_Product_c {get; private set;}
    public String defaultRecordTypeId_Opp_Product_c {get; private set;}
    public String metadataJSON_Opp_Product_c {get; private set;}
    public String picklistValuesJSON_Opp_Product_c_Business_Type_c {get; private set;}
    public String picklistValuesJSON_Opp_Product_c_Sequence_Order_c {get; private set;}
    public String picklistValuesJSON_Opp_Product_c_Sorting_Criteria_c {get; private set;}
    public String picklistValuesJSON_Opp_Product_c_Artwork_c {get; private set;}
    public Map<String,Map<String,Object>> appComponentProperty {get; set;}
    public S12_Premium_CoreExtender getExtender() {return (S12_Premium_CoreExtender)extender;}
    
    
    public S12_Premium_Core(ApexPages.StandardController controller) {
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
        tmpPropMap.put('Component__id','Component68');
        tmpPropMap.put('Component__Name','OppProdFormHeader');
        tmpPropMap.put('Component__NameSpace','');
        tmpPropMap.put('Component__Top','115');
        tmpPropMap.put('Component__Left','0');
        appComponentProperty.put('Component68',tmpPropMap);


        SObjectField f;

        f = Opp_Product__c.fields.Business_Type__c;
        f = Opp_Product__c.fields.Sequence_Order__c;
        f = Opp_Product__c.fields.Any_Car__c;
        f = Opp_Product__c.fields.Num_Any_Car__c;
        f = Opp_Product__c.fields.Any_Car_Amount__c;
        f = Opp_Product__c.fields.Early_Model__c;
        f = Opp_Product__c.fields.Num_Early_Model__c;
        f = Opp_Product__c.fields.Early_Model_Amount__c;
        f = Opp_Product__c.fields.Used_Makes__c;
        f = Opp_Product__c.fields.Sorting_Criteria__c;
        f = Opp_Product__c.fields.Used_Makes_1__c;
        f = Opp_Product__c.fields.Num_Used_Makes_1__c;
        f = Opp_Product__c.fields.Used_Makes_Amount_1__c;
        f = Opp_Product__c.fields.Used_Makes_2__c;
        f = Opp_Product__c.fields.Num_Used_Makes_2__c;
        f = Opp_Product__c.fields.Used_Makes_Amount_2__c;
        f = Opp_Product__c.fields.Used_Makes_3__c;
        f = Opp_Product__c.fields.Num_Used_Makes_3__c;
        f = Opp_Product__c.fields.Used_Makes_Amount_3__c;
        f = Opp_Product__c.fields.Used_Makes_4__c;
        f = Opp_Product__c.fields.Num_Used_Makes_4__c;
        f = Opp_Product__c.fields.Used_Makes_Amount_4__c;
        f = Opp_Product__c.fields.Used_Car_Lot_Size__c;
        f = Opp_Product__c.fields.Used_Makes_5__c;
        f = Opp_Product__c.fields.Num_Used_Makes_5__c;
        f = Opp_Product__c.fields.Used_Makes_Amount_5__c;
        f = Opp_Product__c.fields.Used_Makes_6__c;
        f = Opp_Product__c.fields.Num_Used_Makes_6__c;
        f = Opp_Product__c.fields.Used_Makes_Amount_6__c;
        f = Opp_Product__c.fields.Production_Cost__c;
        f = Opp_Product__c.fields.Total_Monthly_Base_Rate__c;
        f = Opp_Product__c.fields.Artwork__c;
        f = Opp_Product__c.fields.Incentives_C__c;
        f = Opp_Product__c.fields.Co_Op_Pre_Approval_Case__c;
        f = Opp_Product__c.fields.Incentives_C_C__c;
        f = Opp_Product__c.fields.Vehicle_Images_P_F_C__c;
        f = Opp_Product__c.fields.Vehicle_Images_P_F_C_C__c;
        f = Opp_Product__c.fields.Sitelink_Pro_Opt_In__c;
        f = Opp_Product__c.fields.Video_PRO_Opt_In_P_F_P__c;
        f = Opp_Product__c.fields.Video_PRO_Opt_In_P_F_C_C__c;
        f = Opp_Product__c.fields.Sitelink__c;
        f = Opp_Product__c.fields.Connections_Pro__c;
        f = Opp_Product__c.fields.Connections_Pro_Amount_c__c;
        f = Opp_Product__c.fields.New_Re_Direct__c;
        f = Opp_Product__c.fields.Call_Record__c;
        f = Opp_Product__c.fields.Whisper__c;
        f = Opp_Product__c.fields.Enhanced_Call_Tracking__c;
        f = Opp_Product__c.fields.Enhanced_Features_Total__c;
        f = Opp_Product__c.fields.Approved_Future_Delivery__c;
        f = Opp_Product__c.fields.Total_Production_Cost__c;
        f = Opp_Product__c.fields.Total_Monthly_Rate__c;
        f = Opp_Product__c.fields.Delivery_Date__c;

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
            System.JSON.deserializeUntyped('{"CustomObject":{"recordTypes":[{"fullName":"S12_Featured","picklistValues":[{"picklist":"Artwork__c","values":[{"fullName":"Co-Op Pre-Approval","default":false},{"fullName":"Enclose","default":false},{"fullName":"Make Simple Logo","default":false},{"fullName":"Sent EQS","default":false},{"fullName":"Use Co-Op Template","default":false},{"fullName":"Use Dealer Site","default":false},{"fullName":"Use Existing","default":false}]},{"picklist":"Business_Type__c","values":[{"fullName":"AD","default":false},{"fullName":"DN","default":false},{"fullName":"NB","default":false},{"fullName":"UP","default":false}]},{"picklist":"Sequence_Order__c","values":[{"fullName":"Sent EQS","default":false},{"fullName":"Use Default Sequence Order","default":false}]},{"picklist":"Sorting_Criteria__c","values":[{"fullName":"Sent EQS","default":false},{"fullName":"Use Default Sorting Order","default":false}]}]},{"fullName":"S12_KBB_Used","picklistValues":[{"picklist":"Artwork__c","values":[{"fullName":"Co-Op Pre-Approval","default":false},{"fullName":"Enclose","default":false},{"fullName":"Make Simple Logo","default":false},{"fullName":"Sent EQS","default":false},{"fullName":"Use Co-Op Template","default":false},{"fullName":"Use Dealer Site","default":false},{"fullName":"Use Existing","default":false}]},{"picklist":"Business_Type__c","values":[{"fullName":"AD","default":false},{"fullName":"DN","default":false},{"fullName":"NB","default":false},{"fullName":"UP","default":false}]},{"picklist":"Sequence_Order__c","values":[{"fullName":"Sent EQS","default":false},{"fullName":"Use Default Sequence Order","default":false}]},{"picklist":"Sorting_Criteria__c","values":[{"fullName":"Sent EQS","default":false},{"fullName":"Use Default Sorting Order","default":false}]}]},{"fullName":"S12_Premium","picklistValues":[{"picklist":"Artwork__c","values":[{"fullName":"Co-Op Pre-Approval","default":false},{"fullName":"Enclose","default":false},{"fullName":"Make Simple Logo","default":false},{"fullName":"Sent EQS","default":false},{"fullName":"Use Co-Op Template","default":false},{"fullName":"Use Dealer Site","default":false},{"fullName":"Use Existing","default":false}]},{"picklist":"Business_Type__c","values":[{"fullName":"AD","default":false},{"fullName":"DN","default":false},{"fullName":"NB","default":false},{"fullName":"UP","default":false}]},{"picklist":"Sequence_Order__c","values":[{"fullName":"Sent EQS","default":false},{"fullName":"Use Default Sequence Order","default":false}]},{"picklist":"Sorting_Criteria__c","values":[{"fullName":"Sent EQS","default":false},{"fullName":"Use Default Sorting Order","default":false}]}]},{"fullName":"S12_Premium_Core","picklistValues":[{"picklist":"Artwork__c","values":[{"fullName":"Co-Op Pre-Approval","default":false},{"fullName":"Enclose","default":false},{"fullName":"Make Simple Logo","default":false},{"fullName":"Sent EQS","default":false},{"fullName":"Use Co-Op Template","default":false},{"fullName":"Use Dealer Site","default":false},{"fullName":"Use Existing","default":false}]},{"picklist":"Business_Type__c","values":[{"fullName":"AD","default":false},{"fullName":"DN","default":false},{"fullName":"NB","default":false},{"fullName":"UP","default":false}]},{"picklist":"Sequence_Order__c","values":[{"fullName":"Sent EQS","default":false},{"fullName":"Use Default Sequence Order","default":false}]},{"picklist":"Sorting_Criteria__c","values":[{"fullName":"Sent EQS","default":false},{"fullName":"Use Default Sorting Order","default":false}]}]},{"fullName":"S12_Spotlights","picklistValues":[{"picklist":"Artwork__c","values":[{"fullName":"Co-Op Pre-Approval","default":false},{"fullName":"Enclose","default":false},{"fullName":"Make Simple Logo","default":false},{"fullName":"Sent EQS","default":false},{"fullName":"Use Co-Op Template","default":false},{"fullName":"Use Dealer Site","default":false},{"fullName":"Use Existing","default":false}]},{"picklist":"Business_Type__c","values":[{"fullName":"AD","default":false},{"fullName":"DN","default":false},{"fullName":"NB","default":false},{"fullName":"UP","default":false}]},{"picklist":"Sequence_Order__c","values":[{"fullName":"Sent EQS","default":false},{"fullName":"Use Default Sequence Order","default":false}]},{"picklist":"Sorting_Criteria__c","values":[{"fullName":"Sent EQS","default":false},{"fullName":"Use Default Sorting Order","default":false}]}]},{"fullName":"S14_New","picklistValues":[{"picklist":"Artwork__c","values":[{"fullName":"Co-Op Pre-Approval","default":false},{"fullName":"Enclose","default":false},{"fullName":"Make Simple Logo","default":false},{"fullName":"Sent EQS","default":false},{"fullName":"Use Co-Op Template","default":false},{"fullName":"Use Dealer Site","default":false},{"fullName":"Use Existing","default":false}]},{"picklist":"Business_Type__c","values":[{"fullName":"AD","default":false},{"fullName":"DN","default":false},{"fullName":"NB","default":false},{"fullName":"UP","default":false}]},{"picklist":"Sequence_Order__c","values":[{"fullName":"Sent EQS","default":false},{"fullName":"Use Default Sequence Order","default":false}]},{"picklist":"Sorting_Criteria__c","values":[{"fullName":"Sent EQS","default":false},{"fullName":"Use Default Sorting Order","default":false}]}]},{"fullName":"Skyscrapers","picklistValues":[{"picklist":"Artwork__c","values":[{"fullName":"Co-Op Pre-Approval","default":false},{"fullName":"Enclose","default":false},{"fullName":"Make Simple Logo","default":false},{"fullName":"Sent EQS","default":false},{"fullName":"Use Co-Op Template","default":false},{"fullName":"Use Dealer Site","default":false},{"fullName":"Use Existing","default":false}]},{"picklist":"Business_Type__c","values":[{"fullName":"AD","default":false},{"fullName":"DN","default":false},{"fullName":"NB","default":false},{"fullName":"UP","default":false}]},{"picklist":"Sequence_Order__c","values":[{"fullName":"Sent EQS","default":false},{"fullName":"Use Default Sequence Order","default":false}]},{"picklist":"Sorting_Criteria__c","values":[{"fullName":"Sent EQS","default":false},{"fullName":"Use Default Sorting Order","default":false}]}]}]}}'),
            recordTypeFullNames(availableRecordTypes_Opp_Product_c)
        ));
        picklistValuesJSON_Opp_Product_c_Business_Type_c = System.JSON.serialize(Opp_Product__c.SObjectType.Business_Type__c.getDescribe().getPicklistValues());
        picklistValuesJSON_Opp_Product_c_Sequence_Order_c = System.JSON.serialize(Opp_Product__c.SObjectType.Sequence_Order__c.getDescribe().getPicklistValues());
        picklistValuesJSON_Opp_Product_c_Sorting_Criteria_c = System.JSON.serialize(Opp_Product__c.SObjectType.Sorting_Criteria__c.getDescribe().getPicklistValues());
        picklistValuesJSON_Opp_Product_c_Artwork_c = System.JSON.serialize(Opp_Product__c.SObjectType.Artwork__c.getDescribe().getPicklistValues());
        try {
            mainSObjectType = Opp_Product__c.SObjectType;
            setPageReferenceFactory(new PageReferenceFactory());
            
            mainQuery = new SkyEditor2.Query('Opp_Product__c');
            mainQuery.addField('Business_Type__c');
            mainQuery.addField('Sequence_Order__c');
            mainQuery.addField('Any_Car__c');
            mainQuery.addField('Num_Any_Car__c');
            mainQuery.addField('Any_Car_Amount__c');
            mainQuery.addField('Early_Model__c');
            mainQuery.addField('Num_Early_Model__c');
            mainQuery.addField('Early_Model_Amount__c');
            mainQuery.addField('Used_Makes__c');
            mainQuery.addField('Sorting_Criteria__c');
            mainQuery.addField('Used_Makes_1__c');
            mainQuery.addField('Num_Used_Makes_1__c');
            mainQuery.addField('Used_Makes_Amount_1__c');
            mainQuery.addField('Used_Makes_2__c');
            mainQuery.addField('Num_Used_Makes_2__c');
            mainQuery.addField('Used_Makes_Amount_2__c');
            mainQuery.addField('Used_Makes_3__c');
            mainQuery.addField('Num_Used_Makes_3__c');
            mainQuery.addField('Used_Makes_Amount_3__c');
            mainQuery.addField('Used_Makes_4__c');
            mainQuery.addField('Num_Used_Makes_4__c');
            mainQuery.addField('Used_Makes_Amount_4__c');
            mainQuery.addField('Used_Car_Lot_Size__c');
            mainQuery.addField('Used_Makes_5__c');
            mainQuery.addField('Num_Used_Makes_5__c');
            mainQuery.addField('Used_Makes_Amount_5__c');
            mainQuery.addField('Used_Makes_6__c');
            mainQuery.addField('Num_Used_Makes_6__c');
            mainQuery.addField('Used_Makes_Amount_6__c');
            mainQuery.addField('Production_Cost__c');
            mainQuery.addField('Total_Monthly_Base_Rate__c');
            mainQuery.addField('Artwork__c');
            mainQuery.addField('Incentives_C__c');
            mainQuery.addField('Co_Op_Pre_Approval_Case__c');
            mainQuery.addField('Incentives_C_C__c');
            mainQuery.addField('Vehicle_Images_P_F_C__c');
            mainQuery.addField('Vehicle_Images_P_F_C_C__c');
            mainQuery.addField('Sitelink_Pro_Opt_In__c');
            mainQuery.addField('Video_PRO_Opt_In_P_F_P__c');
            mainQuery.addField('Video_PRO_Opt_In_P_F_C_C__c');
            mainQuery.addField('Sitelink__c');
            mainQuery.addField('Connections_Pro__c');
            mainQuery.addField('Connections_Pro_Amount_c__c');
            mainQuery.addField('New_Re_Direct__c');
            mainQuery.addField('Call_Record__c');
            mainQuery.addField('Whisper__c');
            mainQuery.addField('Enhanced_Call_Tracking__c');
            mainQuery.addField('Enhanced_Features_Total__c');
            mainQuery.addField('Approved_Future_Delivery__c');
            mainQuery.addField('Total_Production_Cost__c');
            mainQuery.addField('Total_Monthly_Rate__c');
            mainQuery.addField('Delivery_Date__c');
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
            extender = new S12_Premium_CoreExtender(this);
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
    
    private static testMethod void testPageMethods() {        S12_Premium_Core extension = new S12_Premium_Core(new ApexPages.StandardController(new Opp_Product__c()));
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
        extension.getComponent67OptionsJS();
        extension.getComponent4OptionsJS();
        extension.getComponent5OptionsJS();
        extension.getComponent18OptionsJS();
        extension.getExtender();
    }
    public String getComponent67OptionsJS() {
        return SkyEditor2.JSON.stringify(SkyEditor2.PicklistValueSelector.getEntries(
        Opp_Product__c.getSObjectType(),
        SObjectType.Opp_Product__c.fields.Business_Type__c.getSObjectField()
        ));
        }
    public String getComponent4OptionsJS() {
        return SkyEditor2.JSON.stringify(SkyEditor2.PicklistValueSelector.getEntries(
        Opp_Product__c.getSObjectType(),
        SObjectType.Opp_Product__c.fields.Sequence_Order__c.getSObjectField()
        ));
        }
    public String getComponent5OptionsJS() {
        return SkyEditor2.JSON.stringify(SkyEditor2.PicklistValueSelector.getEntries(
        Opp_Product__c.getSObjectType(),
        SObjectType.Opp_Product__c.fields.Sorting_Criteria__c.getSObjectField()
        ));
        }
    public String getComponent18OptionsJS() {
        return SkyEditor2.JSON.stringify(SkyEditor2.PicklistValueSelector.getEntries(
        Opp_Product__c.getSObjectType(),
        SObjectType.Opp_Product__c.fields.Artwork__c.getSObjectField()
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