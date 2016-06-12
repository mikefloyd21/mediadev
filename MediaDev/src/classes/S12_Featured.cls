global with sharing class S12_Featured extends SkyEditor2.SkyEditorPageBaseWithSharing {
    
    public Opp_Product__c record {get{return (Opp_Product__c)mainRecord;}}
    public with sharing class CanvasException extends Exception {}

    public String recordTypeRecordsJSON_Opp_Product_c {get; private set;}
    public String defaultRecordTypeId_Opp_Product_c {get; private set;}
    public String metadataJSON_Opp_Product_c {get; private set;}
    public String picklistValuesJSON_Opp_Product_c_Business_Type_c {get; private set;}
    public String picklistValuesJSON_Opp_Product_c_Subscription_Featured_c {get; private set;}
    public String picklistValuesJSON_Opp_Product_c_Artwork_c {get; private set;}
    public String picklistValuesJSON_Opp_Product_c_Dealer_Ratings_PL_c {get; private set;}
    public Map<String,Map<String,Object>> appComponentProperty {get; set;}
    public S12_FeaturedExtender getExtender() {return (S12_FeaturedExtender)extender;}
    
    
    public S12_Featured(ApexPages.StandardController controller) {
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
        tmpPropMap.put('Component__id','Component27');
        tmpPropMap.put('Component__Name','OppProdFormHeader');
        tmpPropMap.put('Component__NameSpace','');
        appComponentProperty.put('Component27',tmpPropMap);

        lastPageNumber = 2;
        pagesMap.put(1,'S12_Featured');
        pagesMap.put(2,'S12_Featured_1');

        SObjectField f;

        f = Opp_Product__c.fields.Business_Type__c;
        f = Opp_Product__c.fields.Subscription_Featured__c;
        f = Opp_Product__c.fields.Co_Op__c;
        f = Opp_Product__c.fields.Co_Op_Make__c;
        f = Opp_Product__c.fields.Production_Cost__c;
        f = Opp_Product__c.fields.Total_Monthly_Base_Rate__c;
        f = Opp_Product__c.fields.Used_Car_Lot_Size__c;
        f = Opp_Product__c.fields.Approved_Future_Delivery__c;
        f = Opp_Product__c.fields.Video_PRO_Opt_In_P_F_P__c;
        f = Opp_Product__c.fields.Video_PRO_Opt_In_P_F_C_C__c;
        f = Opp_Product__c.fields.New_Re_Direct__c;
        f = Opp_Product__c.fields.Vehicle_Images_P_F_C__c;
        f = Opp_Product__c.fields.Vehicle_Images_P_F_C_C__c;
        f = Opp_Product__c.fields.Delivery_Date__c;
        f = Opp_Product__c.fields.Whisper__c;
        f = Opp_Product__c.fields.Enhanced_Call_Tracking__c;
        f = Opp_Product__c.fields.Call_Record__c;
        f = Opp_Product__c.fields.Incentives_C__c;
        f = Opp_Product__c.fields.Incentives_C_C__c;
        f = Opp_Product__c.fields.Sitelink_Pro_Opt_In__c;
        f = Opp_Product__c.fields.Vehicle_Images__c;
        f = Opp_Product__c.fields.Vehicle_Images_Amount_c__c;
        f = Opp_Product__c.fields.Video_PRO_Opt_In_P__c;
        f = Opp_Product__c.fields.Video_PRO_Opt_In_P_Amount__c;
        f = Opp_Product__c.fields.Total_Production_Cost__c;
        f = Opp_Product__c.fields.Incentives__c;
        f = Opp_Product__c.fields.Incentives_Amount__c;
        f = Opp_Product__c.fields.Sitelink__c;
        f = Opp_Product__c.fields.Connections_Pro__c;
        f = Opp_Product__c.fields.Connections_Pro_Amount_c__c;
        f = Opp_Product__c.fields.Total_Monthly_Rate__c;
        f = Opp_Product__c.fields.Vehicle_Images_P_F_P__c;
        f = Opp_Product__c.fields.Vehicle_Images_P_F_P_C__c;
        f = Opp_Product__c.fields.Video_PRO_Opt_In_PP__c;
        f = Opp_Product__c.fields.Video_PRO_Opt_In_PP_Amount__c;
        f = Opp_Product__c.fields.Artwork__c;
        f = Opp_Product__c.fields.Incentives_P__c;
        f = Opp_Product__c.fields.Incentives_P_C__c;
        f = Opp_Product__c.fields.Co_Op_Pre_Approval_Case__c;
        f = Opp_Product__c.fields.Connections_Exp__c;
        f = Opp_Product__c.fields.Connections_Exp_C__c;
        f = Opp_Product__c.fields.Vehicle_Images_P_F_M__c;
        f = Opp_Product__c.fields.Vehicle_Images_P_F_M_C__c;
        f = Opp_Product__c.fields.Notes__c;
        f = Opp_Product__c.fields.Video_PRO_Opt_In_PM__c;
        f = Opp_Product__c.fields.Video_PRO_Opt_In_PM_Amount__c;
        f = Opp_Product__c.fields.Enhanced_Features_Total__c;
        f = Account.fields.SVOC_Id__c;
        f = Account.fields.Name;
        f = Account.fields.Dealer_Nameplates__c;
        f = Opp_Product__c.fields.Chat__c;
        f = Opp_Product__c.fields.First_Name_Chat__c;
        f = Opp_Product__c.fields.Last_Name_Chat__c;
        f = Opp_Product__c.fields.Email_Chat__c;
        f = Opp_Product__c.fields.Phone_Chat__c;
        f = Opp_Product__c.fields.Sitelinks_Advanced__c;
        f = Opp_Product__c.fields.Use_Existing_Sitelinks__c;
        f = Opp_Product__c.fields.Social_Connections__c;
        f = Opp_Product__c.fields.Facebook_Inventory__c;
        f = Opp_Product__c.fields.Facebook__c;
        f = Opp_Product__c.fields.Facebook_ID__c;
        f = Opp_Product__c.fields.Facebook_Page__c;
        f = Opp_Product__c.fields.Twitter__c;
        f = Opp_Product__c.fields.Twitter_ID__c;
        f = Opp_Product__c.fields.Dealer_Ratings__c;
        f = Opp_Product__c.fields.Dealer_Ratings_PL__c;
        f = Opp_Product__c.fields.Rating_Link__c;
        f = Opp_Product__c.fields.Other_Rating__c;
        f = Opp_Product__c.fields.Additional_Notes__c;
        f = Opp_Product__c.fields.Bill_To_ID__c;
        f = Opp_Product__c.fields.Invoice_Name__c;
        f = Opportunity.fields.Physical_Street__c;
        f = Opportunity.fields.Physical_City__c;
        f = Opportunity.fields.Physical_State__c;
        f = Opportunity.fields.Physical_Zip_Postal_Code__c;
        f = Opportunity.fields.Billing_Street__c;
        f = Opportunity.fields.Billing_City__c;
        f = Opportunity.fields.Billing_State__c;
        f = Opportunity.fields.Billing_Zip_Postal_Code__c;

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
            System.JSON.deserializeUntyped('{"CustomObject":{"recordTypes":[{"fullName":"S12_Featured","picklistValues":[{"picklist":"Artwork__c","values":[{"fullName":"Co-Op Pre-Approval","default":false},{"fullName":"Enclose","default":false},{"fullName":"Make Simple Logo","default":false},{"fullName":"Sent EQS","default":false},{"fullName":"Use Co-Op Template","default":false},{"fullName":"Use Dealer Site","default":false},{"fullName":"Use Existing","default":false}]},{"picklist":"Business_Type__c","values":[{"fullName":"AD","default":false},{"fullName":"DN","default":false},{"fullName":"NB","default":false},{"fullName":"UP","default":false}]},{"picklist":"Dealer_Ratings_PL__c","values":[{"fullName":"CitySearch%2Ecom","default":false},{"fullName":"DealerRater%2Ecom","default":false},{"fullName":"Kudzu%2Ecom","default":false},{"fullName":"Other","default":false},{"fullName":"Yelp%2Ecom","default":false}]},{"picklist":"Subscription_Featured__c","values":[{"fullName":"Featured","default":false},{"fullName":"Featured Core","default":false},{"fullName":"Featured Max","default":false},{"fullName":"Featured Plus","default":false}]}]},{"fullName":"S12_KBB_Used","picklistValues":[{"picklist":"Artwork__c","values":[{"fullName":"Co-Op Pre-Approval","default":false},{"fullName":"Enclose","default":false},{"fullName":"Make Simple Logo","default":false},{"fullName":"Sent EQS","default":false},{"fullName":"Use Co-Op Template","default":false},{"fullName":"Use Dealer Site","default":false},{"fullName":"Use Existing","default":false}]},{"picklist":"Business_Type__c","values":[{"fullName":"AD","default":false},{"fullName":"DN","default":false},{"fullName":"NB","default":false},{"fullName":"UP","default":false}]},{"picklist":"Dealer_Ratings_PL__c","values":[{"fullName":"CitySearch%2Ecom","default":false},{"fullName":"DealerRater%2Ecom","default":false},{"fullName":"Kudzu%2Ecom","default":false},{"fullName":"Other","default":false},{"fullName":"Yelp%2Ecom","default":false}]},{"picklist":"Subscription_Featured__c","values":[{"fullName":"Featured","default":false},{"fullName":"Featured Core","default":false},{"fullName":"Featured Max","default":false},{"fullName":"Featured Plus","default":false}]}]},{"fullName":"S12_Premium","picklistValues":[{"picklist":"Artwork__c","values":[{"fullName":"Co-Op Pre-Approval","default":false},{"fullName":"Enclose","default":false},{"fullName":"Make Simple Logo","default":false},{"fullName":"Sent EQS","default":false},{"fullName":"Use Co-Op Template","default":false},{"fullName":"Use Dealer Site","default":false},{"fullName":"Use Existing","default":false}]},{"picklist":"Business_Type__c","values":[{"fullName":"AD","default":false},{"fullName":"DN","default":false},{"fullName":"NB","default":false},{"fullName":"UP","default":false}]},{"picklist":"Dealer_Ratings_PL__c","values":[{"fullName":"CitySearch%2Ecom","default":false},{"fullName":"DealerRater%2Ecom","default":false},{"fullName":"Kudzu%2Ecom","default":false},{"fullName":"Other","default":false},{"fullName":"Yelp%2Ecom","default":false}]},{"picklist":"Subscription_Featured__c","values":[{"fullName":"Featured","default":false},{"fullName":"Featured Core","default":false},{"fullName":"Featured Max","default":false},{"fullName":"Featured Plus","default":false}]}]},{"fullName":"S12_Premium_Core","picklistValues":[{"picklist":"Artwork__c","values":[{"fullName":"Co-Op Pre-Approval","default":false},{"fullName":"Enclose","default":false},{"fullName":"Make Simple Logo","default":false},{"fullName":"Sent EQS","default":false},{"fullName":"Use Co-Op Template","default":false},{"fullName":"Use Dealer Site","default":false},{"fullName":"Use Existing","default":false}]},{"picklist":"Business_Type__c","values":[{"fullName":"AD","default":false},{"fullName":"DN","default":false},{"fullName":"NB","default":false},{"fullName":"UP","default":false}]},{"picklist":"Dealer_Ratings_PL__c","values":[{"fullName":"CitySearch%2Ecom","default":false},{"fullName":"DealerRater%2Ecom","default":false},{"fullName":"Kudzu%2Ecom","default":false},{"fullName":"Other","default":false},{"fullName":"Yelp%2Ecom","default":false}]},{"picklist":"Subscription_Featured__c","values":[{"fullName":"Featured","default":false},{"fullName":"Featured Core","default":false},{"fullName":"Featured Max","default":false},{"fullName":"Featured Plus","default":false}]}]},{"fullName":"S12_Spotlights","picklistValues":[{"picklist":"Artwork__c","values":[{"fullName":"Co-Op Pre-Approval","default":false},{"fullName":"Enclose","default":false},{"fullName":"Make Simple Logo","default":false},{"fullName":"Sent EQS","default":false},{"fullName":"Use Co-Op Template","default":false},{"fullName":"Use Dealer Site","default":false},{"fullName":"Use Existing","default":false}]},{"picklist":"Business_Type__c","values":[{"fullName":"AD","default":false},{"fullName":"DN","default":false},{"fullName":"NB","default":false},{"fullName":"UP","default":false}]},{"picklist":"Dealer_Ratings_PL__c","values":[{"fullName":"CitySearch%2Ecom","default":false},{"fullName":"DealerRater%2Ecom","default":false},{"fullName":"Kudzu%2Ecom","default":false},{"fullName":"Other","default":false},{"fullName":"Yelp%2Ecom","default":false}]},{"picklist":"Subscription_Featured__c","values":[{"fullName":"Featured","default":false},{"fullName":"Featured Core","default":false},{"fullName":"Featured Max","default":false},{"fullName":"Featured Plus","default":false}]}]},{"fullName":"S14_New","picklistValues":[{"picklist":"Artwork__c","values":[{"fullName":"Co-Op Pre-Approval","default":false},{"fullName":"Enclose","default":false},{"fullName":"Make Simple Logo","default":false},{"fullName":"Sent EQS","default":false},{"fullName":"Use Co-Op Template","default":false},{"fullName":"Use Dealer Site","default":false},{"fullName":"Use Existing","default":false}]},{"picklist":"Business_Type__c","values":[{"fullName":"AD","default":false},{"fullName":"DN","default":false},{"fullName":"NB","default":false},{"fullName":"UP","default":false}]},{"picklist":"Dealer_Ratings_PL__c","values":[{"fullName":"CitySearch%2Ecom","default":false},{"fullName":"DealerRater%2Ecom","default":false},{"fullName":"Kudzu%2Ecom","default":false},{"fullName":"Other","default":false},{"fullName":"Yelp%2Ecom","default":false}]},{"picklist":"Subscription_Featured__c","values":[{"fullName":"Featured","default":false},{"fullName":"Featured Core","default":false},{"fullName":"Featured Max","default":false},{"fullName":"Featured Plus","default":false}]}]},{"fullName":"Skyscrapers","picklistValues":[{"picklist":"Artwork__c","values":[{"fullName":"Co-Op Pre-Approval","default":false},{"fullName":"Enclose","default":false},{"fullName":"Make Simple Logo","default":false},{"fullName":"Sent EQS","default":false},{"fullName":"Use Co-Op Template","default":false},{"fullName":"Use Dealer Site","default":false},{"fullName":"Use Existing","default":false}]},{"picklist":"Business_Type__c","values":[{"fullName":"AD","default":false},{"fullName":"DN","default":false},{"fullName":"NB","default":false},{"fullName":"UP","default":false}]},{"picklist":"Dealer_Ratings_PL__c","values":[{"fullName":"CitySearch%2Ecom","default":false},{"fullName":"DealerRater%2Ecom","default":false},{"fullName":"Kudzu%2Ecom","default":false},{"fullName":"Other","default":false},{"fullName":"Yelp%2Ecom","default":false}]},{"picklist":"Subscription_Featured__c","values":[{"fullName":"Featured","default":false},{"fullName":"Featured Core","default":false},{"fullName":"Featured Max","default":false},{"fullName":"Featured Plus","default":false}]}]}]}}'),
            recordTypeFullNames(availableRecordTypes_Opp_Product_c)
        ));
        picklistValuesJSON_Opp_Product_c_Business_Type_c = System.JSON.serialize(Opp_Product__c.SObjectType.Business_Type__c.getDescribe().getPicklistValues());
        picklistValuesJSON_Opp_Product_c_Subscription_Featured_c = System.JSON.serialize(Opp_Product__c.SObjectType.Subscription_Featured__c.getDescribe().getPicklistValues());
        picklistValuesJSON_Opp_Product_c_Artwork_c = System.JSON.serialize(Opp_Product__c.SObjectType.Artwork__c.getDescribe().getPicklistValues());
        picklistValuesJSON_Opp_Product_c_Dealer_Ratings_PL_c = System.JSON.serialize(Opp_Product__c.SObjectType.Dealer_Ratings_PL__c.getDescribe().getPicklistValues());
        try {
            mainSObjectType = Opp_Product__c.SObjectType;
            setPageReferenceFactory(new PageReferenceFactory());
            
            recordTypeIdMap = SkyEditor2.Util.SetRecordTypesMap('Opp_Product__c');
            mainQuery = new SkyEditor2.Query('Opp_Product__c');
            mainQuery.addField('Business_Type__c');
            mainQuery.addField('Subscription_Featured__c');
            mainQuery.addField('Co_Op__c');
            mainQuery.addField('Co_Op_Make__c');
            mainQuery.addField('Production_Cost__c');
            mainQuery.addField('Total_Monthly_Base_Rate__c');
            mainQuery.addField('Used_Car_Lot_Size__c');
            mainQuery.addField('Approved_Future_Delivery__c');
            mainQuery.addField('Video_PRO_Opt_In_P_F_P__c');
            mainQuery.addField('Video_PRO_Opt_In_P_F_C_C__c');
            mainQuery.addField('New_Re_Direct__c');
            mainQuery.addField('Vehicle_Images_P_F_C__c');
            mainQuery.addField('Vehicle_Images_P_F_C_C__c');
            mainQuery.addField('Delivery_Date__c');
            mainQuery.addField('Whisper__c');
            mainQuery.addField('Enhanced_Call_Tracking__c');
            mainQuery.addField('Call_Record__c');
            mainQuery.addField('Incentives_C__c');
            mainQuery.addField('Incentives_C_C__c');
            mainQuery.addField('Sitelink_Pro_Opt_In__c');
            mainQuery.addField('Vehicle_Images__c');
            mainQuery.addField('Vehicle_Images_Amount_c__c');
            mainQuery.addField('Video_PRO_Opt_In_P__c');
            mainQuery.addField('Video_PRO_Opt_In_P_Amount__c');
            mainQuery.addField('Total_Production_Cost__c');
            mainQuery.addField('Incentives__c');
            mainQuery.addField('Incentives_Amount__c');
            mainQuery.addField('Sitelink__c');
            mainQuery.addField('Connections_Pro__c');
            mainQuery.addField('Connections_Pro_Amount_c__c');
            mainQuery.addField('Total_Monthly_Rate__c');
            mainQuery.addField('Vehicle_Images_P_F_P__c');
            mainQuery.addField('Vehicle_Images_P_F_P_C__c');
            mainQuery.addField('Video_PRO_Opt_In_PP__c');
            mainQuery.addField('Video_PRO_Opt_In_PP_Amount__c');
            mainQuery.addField('Artwork__c');
            mainQuery.addField('Incentives_P__c');
            mainQuery.addField('Incentives_P_C__c');
            mainQuery.addField('Co_Op_Pre_Approval_Case__c');
            mainQuery.addField('Connections_Exp__c');
            mainQuery.addField('Connections_Exp_C__c');
            mainQuery.addField('Vehicle_Images_P_F_M__c');
            mainQuery.addField('Vehicle_Images_P_F_M_C__c');
            mainQuery.addField('Notes__c');
            mainQuery.addField('Video_PRO_Opt_In_PM__c');
            mainQuery.addField('Video_PRO_Opt_In_PM_Amount__c');
            mainQuery.addField('Enhanced_Features_Total__c');
            mainQuery.addField('Chat__c');
            mainQuery.addField('First_Name_Chat__c');
            mainQuery.addField('Last_Name_Chat__c');
            mainQuery.addField('Email_Chat__c');
            mainQuery.addField('Phone_Chat__c');
            mainQuery.addField('Sitelinks_Advanced__c');
            mainQuery.addField('Use_Existing_Sitelinks__c');
            mainQuery.addField('Social_Connections__c');
            mainQuery.addField('Facebook_Inventory__c');
            mainQuery.addField('Facebook__c');
            mainQuery.addField('Facebook_ID__c');
            mainQuery.addField('Facebook_Page__c');
            mainQuery.addField('Twitter__c');
            mainQuery.addField('Twitter_ID__c');
            mainQuery.addField('Dealer_Ratings__c');
            mainQuery.addField('Dealer_Ratings_PL__c');
            mainQuery.addField('Rating_Link__c');
            mainQuery.addField('Other_Rating__c');
            mainQuery.addField('Additional_Notes__c');
            mainQuery.addFieldAsOutput('Name');
            mainQuery.addFieldAsOutput('RecordTypeId');
            mainQuery.addFieldAsOutput('Opportunity__r.Account.SVOC_Id__c');
            mainQuery.addFieldAsOutput('Opportunity__r.Account.Name');
            mainQuery.addFieldAsOutput('Opportunity__r.Account.Dealer_Nameplates__c');
            mainQuery.addFieldAsOutput('Bill_To_ID__c');
            mainQuery.addFieldAsOutput('Invoice_Name__c');
            mainQuery.addFieldAsOutput('Opportunity__r.Physical_Street__c');
            mainQuery.addFieldAsOutput('Opportunity__r.Physical_City__c');
            mainQuery.addFieldAsOutput('Opportunity__r.Physical_State__c');
            mainQuery.addFieldAsOutput('Opportunity__r.Physical_Zip_Postal_Code__c');
            mainQuery.addFieldAsOutput('Opportunity__r.Billing_Street__c');
            mainQuery.addFieldAsOutput('Opportunity__r.Billing_City__c');
            mainQuery.addFieldAsOutput('Opportunity__r.Billing_State__c');
            mainQuery.addFieldAsOutput('Opportunity__r.Billing_Zip_Postal_Code__c');
            mainQuery.addWhere('Id', mainRecord.Id, SkyEditor2.WhereOperator.Eq)
                .limitRecords(1);
            
            
            queryMap = new Map<String, SkyEditor2.Query>();
            SkyEditor2.Query query;
            
            addInheritParameter('RecordTypeId', 'RecordType');
            extender = new S12_FeaturedExtender(this);
            p_showHeader = true;
            p_sidebar = true;
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

    private static testMethod void testPageMethods() {        S12_Featured extension = new S12_Featured(new ApexPages.StandardController(new Opp_Product__c()));
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
        extension.getComponent28OptionsJS();
        extension.getComponent29OptionsJS();
        extension.getComponent42OptionsJS();
        extension.getComponent94OptionsJS();
        extension.getExtender();
    }
    public String getComponent28OptionsJS() {
        return SkyEditor2.JSON.stringify(SkyEditor2.PicklistValueSelector.getEntries(
        Opp_Product__c.getSObjectType(),
        SObjectType.Opp_Product__c.fields.Business_Type__c.getSObjectField()
        ));
        }
    public String getComponent29OptionsJS() {
        return SkyEditor2.JSON.stringify(SkyEditor2.PicklistValueSelector.getEntries(
        Opp_Product__c.getSObjectType(),
        SObjectType.Opp_Product__c.fields.Subscription_Featured__c.getSObjectField()
        ));
        }
    public String getComponent42OptionsJS() {
        return SkyEditor2.JSON.stringify(SkyEditor2.PicklistValueSelector.getEntries(
        Opp_Product__c.getSObjectType(),
        SObjectType.Opp_Product__c.fields.Artwork__c.getSObjectField()
        ));
        }
    public String getComponent94OptionsJS() {
        return SkyEditor2.JSON.stringify(SkyEditor2.PicklistValueSelector.getEntries(
        Opp_Product__c.getSObjectType(),
        SObjectType.Opp_Product__c.fields.Dealer_Ratings_PL__c.getSObjectField()
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
    public PageReference Component113_doTransfer(){
        try{
            SkyEditor2.Extender.WizardControl trans = extender.doNext('Component113');
            if(trans != null && trans.control == SkyEditor2.Extender.TransferType.MANUAL){
                return jumpPageNumber(trans.pageTransfer);
            }
        }catch(SkyEditor2.ExtenderException e){ 
            e.setMessagesToPage();
            return null;
        }
        return doNext();
    }
    private static testMethod void test_Component113_doTransfer(){
        S12_Featured extension = new S12_Featured(new ApexPages.StandardController(new Opp_Product__c()));
        extension.Component113_doTransfer();
        extension.extender = new SkyEditor2.TestClasses.TestWizardControlExtender1();
        extension.Component113_doTransfer();
        extension.extender = new SkyEditor2.TestClasses.TestWizardControlExtender2();
        extension.Component113_doTransfer();
        System.assert(true);
        
    }
    public PageReference Component21_doTransfer(){
        try{
            SkyEditor2.Extender.WizardControl trans = extender.doBack('Component21');
            if(trans != null && trans.control == SkyEditor2.Extender.TransferType.MANUAL){
                return jumpPageNumber(trans.pageTransfer);
            }
        }catch(SkyEditor2.ExtenderException e){ 
            e.setMessagesToPage();
            return null;
        }
        return doBack();
    }
    private static testMethod void test_Component21_doTransfer(){
        S12_Featured extension = new S12_Featured(new ApexPages.StandardController(new Opp_Product__c()));
        extension.Component21_doTransfer();
        extension.extender = new SkyEditor2.TestClasses.TestWizardControlExtender1();
        extension.Component21_doTransfer();
        extension.extender = new SkyEditor2.TestClasses.TestWizardControlExtender2();
        extension.Component21_doTransfer();
        System.assert(true);
        
    }
    public PageReference Component24_doTransfer(){
        try{
            SkyEditor2.Extender.WizardControl trans = extender.doBack('Component24');
            if(trans != null && trans.control == SkyEditor2.Extender.TransferType.MANUAL){
                return jumpPageNumber(trans.pageTransfer);
            }
        }catch(SkyEditor2.ExtenderException e){ 
            e.setMessagesToPage();
            return null;
        }
        return doBack();
    }
    private static testMethod void test_Component24_doTransfer(){
        S12_Featured extension = new S12_Featured(new ApexPages.StandardController(new Opp_Product__c()));
        extension.Component24_doTransfer();
        extension.extender = new SkyEditor2.TestClasses.TestWizardControlExtender1();
        extension.Component24_doTransfer();
        extension.extender = new SkyEditor2.TestClasses.TestWizardControlExtender2();
        extension.Component24_doTransfer();
        System.assert(true);
        
    }
    with sharing class PageReferenceFactory implements SkyEditor2.PageReferenceFactory.Implementation {
        public PageReference newPageReference(String url) {
            return new PageReference(url);
        }
    }
}