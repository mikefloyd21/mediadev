global with sharing class KBB_New_C extends SkyEditor2.SkyEditorPageBaseWithSharing {
    
    public Opp_Product__c record {get{return (Opp_Product__c)mainRecord;}}
    public with sharing class CanvasException extends Exception {}

    public String recordTypeRecordsJSON_Opp_Product_c {get; private set;}
    public String defaultRecordTypeId_Opp_Product_c {get; private set;}
    public String metadataJSON_Opp_Product_c {get; private set;}
    public String picklistValuesJSON_Opp_Product_c_Business_Type_c {get; private set;}
    public String picklistValuesJSON_Opp_Product_c_ATC_Packages_c {get; private set;}
    public String picklistValuesJSON_Opp_Product_c_Classified_Package_c {get; private set;}
    public String picklistValuesJSON_Opp_Product_c_Classified_Package_1_c {get; private set;}
    public String picklistValuesJSON_Opp_Product_c_Classified_Package_2_c {get; private set;}
    public String picklistValuesJSON_Opp_Product_c_Classified_Package_3_c {get; private set;}
    public String picklistValuesJSON_Opp_Product_c_iMR_Opt_In_c {get; private set;}
    public String picklistValuesJSON_Opp_Product_c_Dealer_Ratings_List_c {get; private set;}
    public Map<String,Map<String,Object>> appComponentProperty {get; set;}
    public KBB_New_CExtender getExtender() {return (KBB_New_CExtender)extender;}
    
    
    public KBB_New_C(ApexPages.StandardController controller) {
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
        tmpPropMap.put('Component__Top','113');
        tmpPropMap.put('Component__Left','0');
        appComponentProperty.put('Component1',tmpPropMap);


        SObjectField f;

        f = Opp_Product__c.fields.Business_Type__c;
        f = Opp_Product__c.fields.ATC_Packages__c;
        f = Opp_Product__c.fields.Inventory_Per_Make_1__c;
        f = Opp_Product__c.fields.Classified_Package__c;
        f = Opp_Product__c.fields.New_Car_Make_1__c;
        f = Opp_Product__c.fields.Monthly_Base_Rate_1__c;
        f = Opp_Product__c.fields.Inventory_Per_Make_2__c;
        f = Opp_Product__c.fields.Classified_Package_1__c;
        f = Opp_Product__c.fields.New_Car_Make_2__c;
        f = Opp_Product__c.fields.Monthly_Base_Rate_2__c;
        f = Opp_Product__c.fields.Inventory_Per_Make_3__c;
        f = Opp_Product__c.fields.Classified_Package_2__c;
        f = Opp_Product__c.fields.ATC_P_List__c;
        f = Opp_Product__c.fields.New_Car_Make_3__c;
        f = Opp_Product__c.fields.Monthly_Base_Rate_3__c;
        f = Opp_Product__c.fields.Classified_Package_3__c;
        f = Opp_Product__c.fields.Inventory_Per_Make_4__c;
        f = Opp_Product__c.fields.New_Car_Make_4__c;
        f = Opp_Product__c.fields.Monthly_Base_Rate_4__c;
        f = Opp_Product__c.fields.Total_New_Car_Lot_Size__c;
        f = Opp_Product__c.fields.Spotlights_Make__c;
        f = Opp_Product__c.fields.KBB_Standalone_Duration__c;
        f = Opp_Product__c.fields.KBB_Num_of_Spotlights__c;
        f = Opp_Product__c.fields.iMR_Opt_In__c;
        f = Opp_Product__c.fields.Delivery_Date__c;
        f = Opp_Product__c.fields.BAC_Code__c;
        f = Opp_Product__c.fields.Num_Spotlights__c;
        f = Opp_Product__c.fields.Dealer_Code__c;
        f = Opp_Product__c.fields.Inventory_Per_Make_5__c;
        f = Opp_Product__c.fields.Monthly_Base_Rate_5__c;
        f = Opp_Product__c.fields.Use_GM_CPO_Templates__c;
        f = Opp_Product__c.fields.Spotlight_Monthly_Rate__c;
        f = Opp_Product__c.fields.Inventory_Per_Make_6__c;
        f = Opp_Product__c.fields.Monthly_Base_Rate_6__c;
        f = Opp_Product__c.fields.Sent_EQS__c;
        f = Opp_Product__c.fields.Inventory_Per_Make_7__c;
        f = Opp_Product__c.fields.Monthly_Base_Rate_7__c;
        f = Opp_Product__c.fields.Sitelink__c;
        f = Opp_Product__c.fields.Inventory_Per_Make_8__c;
        f = Opp_Product__c.fields.Monthly_Base_Rate_8__c;
        f = Opp_Product__c.fields.Facebook__c;
        f = Opp_Product__c.fields.Facebook_Inventory__c;
        f = Opp_Product__c.fields.New_Re_Direct__c;
        f = Opp_Product__c.fields.Facebook_ID__c;
        f = Opp_Product__c.fields.Facebook_Page__c;
        f = Opp_Product__c.fields.Whisper__c;
        f = Opp_Product__c.fields.Call_Record__c;
        f = Opp_Product__c.fields.Dealer_Ratings__c;
        f = Opp_Product__c.fields.Twitter__c;
        f = Opp_Product__c.fields.Dealer_Ratings_List__c;
        f = Opp_Product__c.fields.DMA__c;
        f = Opp_Product__c.fields.Twitter_ID__c;
        f = Opp_Product__c.fields.Dealer_Ratings_Link__c;
        f = Opp_Product__c.fields.Total_Monthly_Rate__c;
        f = Opp_Product__c.fields.Chat__c;
        f = Opp_Product__c.fields.First_Name_Chat__c;
        f = Opp_Product__c.fields.Last_Name_Chat__c;
        f = Opp_Product__c.fields.Email_Chat__c;
        f = Opp_Product__c.fields.Phone_Chat__c;

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
            System.JSON.deserializeUntyped('{"CustomObject":{"recordTypes":[{"fullName":"KBB_New_GM_Classified","picklistValues":[{"picklist":"ATC_Packages__c","values":[{"fullName":"Dealer Subscribes to ATC Used Car Classifieds","default":false},{"fullName":"Dealer is canceling ALL ATC %28requires KBB Standalone%29","default":false},{"fullName":"Dealer is keeping ATC standalone packages* %28req%2E KBB Std alone%29","default":false}]},{"picklist":"Business_Type__c","values":[{"fullName":"AD","default":false},{"fullName":"DN","default":false},{"fullName":"NB","default":false},{"fullName":"UP","default":false}]},{"picklist":"Classified_Package_1__c","values":[{"fullName":"Connector","default":false},{"fullName":"Fusion","default":false}]},{"picklist":"Classified_Package_2__c","values":[{"fullName":"Connector","default":false},{"fullName":"Fusion","default":false}]},{"picklist":"Classified_Package_3__c","values":[{"fullName":"Connector","default":false},{"fullName":"Fusion","default":false}]},{"picklist":"Classified_Package__c","values":[{"fullName":"Connector","default":false},{"fullName":"Fusion","default":false}]},{"picklist":"Dealer_Ratings_List__c","values":[{"fullName":"DealerRater%2Ecom","default":false}]},{"picklist":"iMR_Opt_In__c","values":[{"fullName":"No","default":false},{"fullName":"Yes","default":false}]}]},{"fullName":"KBB_Used_GM_Classifieds","picklistValues":[{"picklist":"ATC_Packages__c","values":[{"fullName":"Dealer Subscribes to ATC Used Car Classifieds","default":false},{"fullName":"Dealer is canceling ALL ATC %28requires KBB Standalone%29","default":false},{"fullName":"Dealer is keeping ATC standalone packages* %28req%2E KBB Std alone%29","default":false}]},{"picklist":"Business_Type__c","values":[{"fullName":"AD","default":false},{"fullName":"DN","default":false},{"fullName":"NB","default":false},{"fullName":"UP","default":false}]},{"picklist":"Classified_Package_1__c","values":[{"fullName":"Connector","default":false},{"fullName":"Fusion","default":false}]},{"picklist":"Classified_Package_2__c","values":[{"fullName":"Connector","default":false},{"fullName":"Fusion","default":false}]},{"picklist":"Classified_Package_3__c","values":[{"fullName":"Connector","default":false},{"fullName":"Fusion","default":false}]},{"picklist":"Classified_Package__c","values":[{"fullName":"Connector","default":false},{"fullName":"Fusion","default":false}]},{"picklist":"Dealer_Ratings_List__c","values":[{"fullName":"DealerRater%2Ecom","default":false}]},{"picklist":"iMR_Opt_In__c","values":[{"fullName":"No","default":false},{"fullName":"Yes","default":false}]}]},{"fullName":"S12_Featured","picklistValues":[{"picklist":"ATC_Packages__c","values":[{"fullName":"Dealer Subscribes to ATC Used Car Classifieds","default":false},{"fullName":"Dealer is canceling ALL ATC %28requires KBB Standalone%29","default":false},{"fullName":"Dealer is keeping ATC standalone packages* %28req%2E KBB Std alone%29","default":false}]},{"picklist":"Business_Type__c","values":[{"fullName":"AD","default":false},{"fullName":"DN","default":false},{"fullName":"NB","default":false},{"fullName":"UP","default":false}]},{"picklist":"Classified_Package_1__c","values":[{"fullName":"Connector","default":false},{"fullName":"Fusion","default":false}]},{"picklist":"Classified_Package_2__c","values":[{"fullName":"Connector","default":false},{"fullName":"Fusion","default":false}]},{"picklist":"Classified_Package_3__c","values":[{"fullName":"Connector","default":false},{"fullName":"Fusion","default":false}]},{"picklist":"Classified_Package__c","values":[{"fullName":"Connector","default":false},{"fullName":"Fusion","default":false}]},{"picklist":"Dealer_Ratings_List__c","values":[{"fullName":"DealerRater%2Ecom","default":false}]},{"picklist":"iMR_Opt_In__c","values":[{"fullName":"No","default":false},{"fullName":"Yes","default":false}]}]},{"fullName":"S12_GM_Alpha","picklistValues":[{"picklist":"ATC_Packages__c","values":[{"fullName":"Dealer Subscribes to ATC Used Car Classifieds","default":false},{"fullName":"Dealer is canceling ALL ATC %28requires KBB Standalone%29","default":false},{"fullName":"Dealer is keeping ATC standalone packages* %28req%2E KBB Std alone%29","default":false}]},{"picklist":"Business_Type__c","values":[{"fullName":"AD","default":false},{"fullName":"DN","default":false},{"fullName":"NB","default":false},{"fullName":"UP","default":false}]},{"picklist":"Classified_Package_1__c","values":[{"fullName":"Connector","default":false},{"fullName":"Fusion","default":false}]},{"picklist":"Classified_Package_2__c","values":[{"fullName":"Connector","default":false},{"fullName":"Fusion","default":false}]},{"picklist":"Classified_Package_3__c","values":[{"fullName":"Connector","default":false},{"fullName":"Fusion","default":false}]},{"picklist":"Classified_Package__c","values":[{"fullName":"Connector","default":false},{"fullName":"Fusion","default":false}]},{"picklist":"Dealer_Ratings_List__c","values":[{"fullName":"DealerRater%2Ecom","default":false}]},{"picklist":"iMR_Opt_In__c","values":[{"fullName":"No","default":false},{"fullName":"Yes","default":false}]}]},{"fullName":"S12_GM_Alpha_Open","picklistValues":[{"picklist":"ATC_Packages__c","values":[{"fullName":"Dealer Subscribes to ATC Used Car Classifieds","default":false},{"fullName":"Dealer is canceling ALL ATC %28requires KBB Standalone%29","default":false},{"fullName":"Dealer is keeping ATC standalone packages* %28req%2E KBB Std alone%29","default":false}]},{"picklist":"Business_Type__c","values":[{"fullName":"AD","default":false},{"fullName":"DN","default":false},{"fullName":"NB","default":false},{"fullName":"UP","default":false}]},{"picklist":"Classified_Package_1__c","values":[{"fullName":"Connector","default":false},{"fullName":"Fusion","default":false}]},{"picklist":"Classified_Package_2__c","values":[{"fullName":"Connector","default":false},{"fullName":"Fusion","default":false}]},{"picklist":"Classified_Package_3__c","values":[{"fullName":"Connector","default":false},{"fullName":"Fusion","default":false}]},{"picklist":"Classified_Package__c","values":[{"fullName":"Connector","default":false},{"fullName":"Fusion","default":false}]},{"picklist":"Dealer_Ratings_List__c","values":[{"fullName":"DealerRater%2Ecom","default":false}]},{"picklist":"iMR_Opt_In__c","values":[{"fullName":"No","default":false},{"fullName":"Yes","default":false}]}]},{"fullName":"S12_KBB_GM_Showcase","picklistValues":[{"picklist":"ATC_Packages__c","values":[{"fullName":"Dealer Subscribes to ATC Used Car Classifieds","default":false},{"fullName":"Dealer is canceling ALL ATC %28requires KBB Standalone%29","default":false},{"fullName":"Dealer is keeping ATC standalone packages* %28req%2E KBB Std alone%29","default":false}]},{"picklist":"Business_Type__c","values":[{"fullName":"AD","default":false},{"fullName":"DN","default":false},{"fullName":"NB","default":false},{"fullName":"UP","default":false}]},{"picklist":"Classified_Package_1__c","values":[{"fullName":"Connector","default":false},{"fullName":"Fusion","default":false}]},{"picklist":"Classified_Package_2__c","values":[{"fullName":"Connector","default":false},{"fullName":"Fusion","default":false}]},{"picklist":"Classified_Package_3__c","values":[{"fullName":"Connector","default":false},{"fullName":"Fusion","default":false}]},{"picklist":"Classified_Package__c","values":[{"fullName":"Connector","default":false},{"fullName":"Fusion","default":false}]},{"picklist":"Dealer_Ratings_List__c","values":[{"fullName":"DealerRater%2Ecom","default":false}]},{"picklist":"iMR_Opt_In__c","values":[{"fullName":"No","default":false},{"fullName":"Yes","default":false}]}]},{"fullName":"S12_KBB_Highlights","picklistValues":[{"picklist":"ATC_Packages__c","values":[{"fullName":"Dealer Subscribes to ATC Used Car Classifieds","default":false},{"fullName":"Dealer is canceling ALL ATC %28requires KBB Standalone%29","default":false},{"fullName":"Dealer is keeping ATC standalone packages* %28req%2E KBB Std alone%29","default":false}]},{"picklist":"Business_Type__c","values":[{"fullName":"AD","default":false},{"fullName":"DN","default":false},{"fullName":"NB","default":false},{"fullName":"UP","default":false}]},{"picklist":"Classified_Package_1__c","values":[{"fullName":"Connector","default":false},{"fullName":"Fusion","default":false}]},{"picklist":"Classified_Package_2__c","values":[{"fullName":"Connector","default":false},{"fullName":"Fusion","default":false}]},{"picklist":"Classified_Package_3__c","values":[{"fullName":"Connector","default":false},{"fullName":"Fusion","default":false}]},{"picklist":"Classified_Package__c","values":[{"fullName":"Connector","default":false},{"fullName":"Fusion","default":false}]},{"picklist":"Dealer_Ratings_List__c","values":[{"fullName":"DealerRater%2Ecom","default":false}]},{"picklist":"iMR_Opt_In__c","values":[{"fullName":"No","default":false},{"fullName":"Yes","default":false}]}]},{"fullName":"S12_KBB_Showcase","picklistValues":[{"picklist":"ATC_Packages__c","values":[{"fullName":"Dealer Subscribes to ATC Used Car Classifieds","default":false},{"fullName":"Dealer is canceling ALL ATC %28requires KBB Standalone%29","default":false},{"fullName":"Dealer is keeping ATC standalone packages* %28req%2E KBB Std alone%29","default":false}]},{"picklist":"Business_Type__c","values":[{"fullName":"AD","default":false},{"fullName":"DN","default":false},{"fullName":"NB","default":false},{"fullName":"UP","default":false}]},{"picklist":"Classified_Package_1__c","values":[{"fullName":"Connector","default":false},{"fullName":"Fusion","default":false}]},{"picklist":"Classified_Package_2__c","values":[{"fullName":"Connector","default":false},{"fullName":"Fusion","default":false}]},{"picklist":"Classified_Package_3__c","values":[{"fullName":"Connector","default":false},{"fullName":"Fusion","default":false}]},{"picklist":"Classified_Package__c","values":[{"fullName":"Connector","default":false},{"fullName":"Fusion","default":false}]},{"picklist":"Dealer_Ratings_List__c","values":[{"fullName":"DealerRater%2Ecom","default":false}]},{"picklist":"iMR_Opt_In__c","values":[{"fullName":"No","default":false},{"fullName":"Yes","default":false}]}]},{"fullName":"S12_KBB_Used","picklistValues":[{"picklist":"ATC_Packages__c","values":[{"fullName":"Dealer Subscribes to ATC Used Car Classifieds","default":false},{"fullName":"Dealer is canceling ALL ATC %28requires KBB Standalone%29","default":false},{"fullName":"Dealer is keeping ATC standalone packages* %28req%2E KBB Std alone%29","default":false}]},{"picklist":"Business_Type__c","values":[{"fullName":"AD","default":false},{"fullName":"DN","default":false},{"fullName":"NB","default":false},{"fullName":"UP","default":false}]},{"picklist":"Classified_Package_1__c","values":[{"fullName":"Connector","default":false},{"fullName":"Fusion","default":false}]},{"picklist":"Classified_Package_2__c","values":[{"fullName":"Connector","default":false},{"fullName":"Fusion","default":false}]},{"picklist":"Classified_Package_3__c","values":[{"fullName":"Connector","default":false},{"fullName":"Fusion","default":false}]},{"picklist":"Classified_Package__c","values":[{"fullName":"Connector","default":false},{"fullName":"Fusion","default":false}]},{"picklist":"Dealer_Ratings_List__c","values":[{"fullName":"DealerRater%2Ecom","default":false}]},{"picklist":"iMR_Opt_In__c","values":[{"fullName":"No","default":false},{"fullName":"Yes","default":false}]}]},{"fullName":"S12_Premium","picklistValues":[{"picklist":"ATC_Packages__c","values":[{"fullName":"Dealer Subscribes to ATC Used Car Classifieds","default":false},{"fullName":"Dealer is canceling ALL ATC %28requires KBB Standalone%29","default":false},{"fullName":"Dealer is keeping ATC standalone packages* %28req%2E KBB Std alone%29","default":false}]},{"picklist":"Business_Type__c","values":[{"fullName":"AD","default":false},{"fullName":"DN","default":false},{"fullName":"NB","default":false},{"fullName":"UP","default":false}]},{"picklist":"Classified_Package_1__c","values":[{"fullName":"Connector","default":false},{"fullName":"Fusion","default":false}]},{"picklist":"Classified_Package_2__c","values":[{"fullName":"Connector","default":false},{"fullName":"Fusion","default":false}]},{"picklist":"Classified_Package_3__c","values":[{"fullName":"Connector","default":false},{"fullName":"Fusion","default":false}]},{"picklist":"Classified_Package__c","values":[{"fullName":"Connector","default":false},{"fullName":"Fusion","default":false}]},{"picklist":"Dealer_Ratings_List__c","values":[{"fullName":"DealerRater%2Ecom","default":false}]},{"picklist":"iMR_Opt_In__c","values":[{"fullName":"No","default":false},{"fullName":"Yes","default":false}]}]},{"fullName":"S12_Premium_Core","picklistValues":[{"picklist":"ATC_Packages__c","values":[{"fullName":"Dealer Subscribes to ATC Used Car Classifieds","default":false},{"fullName":"Dealer is canceling ALL ATC %28requires KBB Standalone%29","default":false},{"fullName":"Dealer is keeping ATC standalone packages* %28req%2E KBB Std alone%29","default":false}]},{"picklist":"Business_Type__c","values":[{"fullName":"AD","default":false},{"fullName":"DN","default":false},{"fullName":"NB","default":false},{"fullName":"UP","default":false}]},{"picklist":"Classified_Package_1__c","values":[{"fullName":"Connector","default":false},{"fullName":"Fusion","default":false}]},{"picklist":"Classified_Package_2__c","values":[{"fullName":"Connector","default":false},{"fullName":"Fusion","default":false}]},{"picklist":"Classified_Package_3__c","values":[{"fullName":"Connector","default":false},{"fullName":"Fusion","default":false}]},{"picklist":"Classified_Package__c","values":[{"fullName":"Connector","default":false},{"fullName":"Fusion","default":false}]},{"picklist":"Dealer_Ratings_List__c","values":[{"fullName":"DealerRater%2Ecom","default":false}]},{"picklist":"iMR_Opt_In__c","values":[{"fullName":"No","default":false},{"fullName":"Yes","default":false}]}]},{"fullName":"S12_Skyscrapers","picklistValues":[{"picklist":"ATC_Packages__c","values":[{"fullName":"Dealer Subscribes to ATC Used Car Classifieds","default":false},{"fullName":"Dealer is canceling ALL ATC %28requires KBB Standalone%29","default":false},{"fullName":"Dealer is keeping ATC standalone packages* %28req%2E KBB Std alone%29","default":false}]},{"picklist":"Business_Type__c","values":[{"fullName":"AD","default":false},{"fullName":"DN","default":false},{"fullName":"NB","default":false},{"fullName":"UP","default":false}]},{"picklist":"Classified_Package_1__c","values":[{"fullName":"Connector","default":false},{"fullName":"Fusion","default":false}]},{"picklist":"Classified_Package_2__c","values":[{"fullName":"Connector","default":false},{"fullName":"Fusion","default":false}]},{"picklist":"Classified_Package_3__c","values":[{"fullName":"Connector","default":false},{"fullName":"Fusion","default":false}]},{"picklist":"Classified_Package__c","values":[{"fullName":"Connector","default":false},{"fullName":"Fusion","default":false}]},{"picklist":"Dealer_Ratings_List__c","values":[{"fullName":"DealerRater%2Ecom","default":false}]},{"picklist":"iMR_Opt_In__c","values":[{"fullName":"No","default":false},{"fullName":"Yes","default":false}]}]},{"fullName":"S12_Spotlights","picklistValues":[{"picklist":"ATC_Packages__c","values":[{"fullName":"Dealer Subscribes to ATC Used Car Classifieds","default":false},{"fullName":"Dealer is canceling ALL ATC %28requires KBB Standalone%29","default":false},{"fullName":"Dealer is keeping ATC standalone packages* %28req%2E KBB Std alone%29","default":false}]},{"picklist":"Business_Type__c","values":[{"fullName":"AD","default":false},{"fullName":"DN","default":false},{"fullName":"NB","default":false},{"fullName":"UP","default":false}]},{"picklist":"Classified_Package_1__c","values":[{"fullName":"Connector","default":false},{"fullName":"Fusion","default":false}]},{"picklist":"Classified_Package_2__c","values":[{"fullName":"Connector","default":false},{"fullName":"Fusion","default":false}]},{"picklist":"Classified_Package_3__c","values":[{"fullName":"Connector","default":false},{"fullName":"Fusion","default":false}]},{"picklist":"Classified_Package__c","values":[{"fullName":"Connector","default":false},{"fullName":"Fusion","default":false}]},{"picklist":"Dealer_Ratings_List__c","values":[{"fullName":"DealerRater%2Ecom","default":false}]},{"picklist":"iMR_Opt_In__c","values":[{"fullName":"No","default":false},{"fullName":"Yes","default":false}]}]},{"fullName":"S14_GM_Certified_New","picklistValues":[{"picklist":"ATC_Packages__c","values":[{"fullName":"Dealer Subscribes to ATC Used Car Classifieds","default":false},{"fullName":"Dealer is canceling ALL ATC %28requires KBB Standalone%29","default":false},{"fullName":"Dealer is keeping ATC standalone packages* %28req%2E KBB Std alone%29","default":false}]},{"picklist":"Business_Type__c","values":[{"fullName":"AD","default":false},{"fullName":"DN","default":false},{"fullName":"NB","default":false},{"fullName":"UP","default":false}]},{"picklist":"Classified_Package_1__c","values":[{"fullName":"Connector","default":false},{"fullName":"Fusion","default":false}]},{"picklist":"Classified_Package_2__c","values":[{"fullName":"Connector","default":false},{"fullName":"Fusion","default":false}]},{"picklist":"Classified_Package_3__c","values":[{"fullName":"Connector","default":false},{"fullName":"Fusion","default":false}]},{"picklist":"Classified_Package__c","values":[{"fullName":"Connector","default":false},{"fullName":"Fusion","default":false}]},{"picklist":"Dealer_Ratings_List__c","values":[{"fullName":"DealerRater%2Ecom","default":false}]},{"picklist":"iMR_Opt_In__c","values":[{"fullName":"No","default":false},{"fullName":"Yes","default":false}]}]},{"fullName":"S14_New","picklistValues":[{"picklist":"ATC_Packages__c","values":[{"fullName":"Dealer Subscribes to ATC Used Car Classifieds","default":false},{"fullName":"Dealer is canceling ALL ATC %28requires KBB Standalone%29","default":false},{"fullName":"Dealer is keeping ATC standalone packages* %28req%2E KBB Std alone%29","default":false}]},{"picklist":"Business_Type__c","values":[{"fullName":"AD","default":false},{"fullName":"DN","default":false},{"fullName":"NB","default":false},{"fullName":"UP","default":false}]},{"picklist":"Classified_Package_1__c","values":[{"fullName":"Connector","default":false},{"fullName":"Fusion","default":false}]},{"picklist":"Classified_Package_2__c","values":[{"fullName":"Connector","default":false},{"fullName":"Fusion","default":false}]},{"picklist":"Classified_Package_3__c","values":[{"fullName":"Connector","default":false},{"fullName":"Fusion","default":false}]},{"picklist":"Classified_Package__c","values":[{"fullName":"Connector","default":false},{"fullName":"Fusion","default":false}]},{"picklist":"Dealer_Ratings_List__c","values":[{"fullName":"DealerRater%2Ecom","default":false}]},{"picklist":"iMR_Opt_In__c","values":[{"fullName":"No","default":false},{"fullName":"Yes","default":false}]}]}]}}'),
            recordTypeFullNames(availableRecordTypes_Opp_Product_c)
        ));
        picklistValuesJSON_Opp_Product_c_Business_Type_c = System.JSON.serialize(Opp_Product__c.SObjectType.Business_Type__c.getDescribe().getPicklistValues());
        picklistValuesJSON_Opp_Product_c_ATC_Packages_c = System.JSON.serialize(Opp_Product__c.SObjectType.ATC_Packages__c.getDescribe().getPicklistValues());
        picklistValuesJSON_Opp_Product_c_Classified_Package_c = System.JSON.serialize(Opp_Product__c.SObjectType.Classified_Package__c.getDescribe().getPicklistValues());
        picklistValuesJSON_Opp_Product_c_Classified_Package_1_c = System.JSON.serialize(Opp_Product__c.SObjectType.Classified_Package_1__c.getDescribe().getPicklistValues());
        picklistValuesJSON_Opp_Product_c_Classified_Package_2_c = System.JSON.serialize(Opp_Product__c.SObjectType.Classified_Package_2__c.getDescribe().getPicklistValues());
        picklistValuesJSON_Opp_Product_c_Classified_Package_3_c = System.JSON.serialize(Opp_Product__c.SObjectType.Classified_Package_3__c.getDescribe().getPicklistValues());
        picklistValuesJSON_Opp_Product_c_iMR_Opt_In_c = System.JSON.serialize(Opp_Product__c.SObjectType.iMR_Opt_In__c.getDescribe().getPicklistValues());
        picklistValuesJSON_Opp_Product_c_Dealer_Ratings_List_c = System.JSON.serialize(Opp_Product__c.SObjectType.Dealer_Ratings_List__c.getDescribe().getPicklistValues());
        try {
            mainSObjectType = Opp_Product__c.SObjectType;
            setPageReferenceFactory(new PageReferenceFactory());
            
            mainQuery = new SkyEditor2.Query('Opp_Product__c');
            mainQuery.addField('Business_Type__c');
            mainQuery.addField('ATC_Packages__c');
            mainQuery.addField('Inventory_Per_Make_1__c');
            mainQuery.addField('Classified_Package__c');
            mainQuery.addField('New_Car_Make_1__c');
            mainQuery.addField('Monthly_Base_Rate_1__c');
            mainQuery.addField('Inventory_Per_Make_2__c');
            mainQuery.addField('Classified_Package_1__c');
            mainQuery.addField('New_Car_Make_2__c');
            mainQuery.addField('Monthly_Base_Rate_2__c');
            mainQuery.addField('Inventory_Per_Make_3__c');
            mainQuery.addField('Classified_Package_2__c');
            mainQuery.addField('ATC_P_List__c');
            mainQuery.addField('New_Car_Make_3__c');
            mainQuery.addField('Monthly_Base_Rate_3__c');
            mainQuery.addField('Classified_Package_3__c');
            mainQuery.addField('Inventory_Per_Make_4__c');
            mainQuery.addField('New_Car_Make_4__c');
            mainQuery.addField('Monthly_Base_Rate_4__c');
            mainQuery.addField('Total_New_Car_Lot_Size__c');
            mainQuery.addField('Spotlights_Make__c');
            mainQuery.addField('KBB_Standalone_Duration__c');
            mainQuery.addField('KBB_Num_of_Spotlights__c');
            mainQuery.addField('iMR_Opt_In__c');
            mainQuery.addField('Delivery_Date__c');
            mainQuery.addField('BAC_Code__c');
            mainQuery.addField('Num_Spotlights__c');
            mainQuery.addField('Dealer_Code__c');
            mainQuery.addField('Inventory_Per_Make_5__c');
            mainQuery.addField('Monthly_Base_Rate_5__c');
            mainQuery.addField('Use_GM_CPO_Templates__c');
            mainQuery.addField('Spotlight_Monthly_Rate__c');
            mainQuery.addField('Inventory_Per_Make_6__c');
            mainQuery.addField('Monthly_Base_Rate_6__c');
            mainQuery.addField('Sent_EQS__c');
            mainQuery.addField('Inventory_Per_Make_7__c');
            mainQuery.addField('Monthly_Base_Rate_7__c');
            mainQuery.addField('Sitelink__c');
            mainQuery.addField('Inventory_Per_Make_8__c');
            mainQuery.addField('Monthly_Base_Rate_8__c');
            mainQuery.addField('Facebook__c');
            mainQuery.addField('Facebook_Inventory__c');
            mainQuery.addField('New_Re_Direct__c');
            mainQuery.addField('Facebook_ID__c');
            mainQuery.addField('Facebook_Page__c');
            mainQuery.addField('Whisper__c');
            mainQuery.addField('Call_Record__c');
            mainQuery.addField('Dealer_Ratings__c');
            mainQuery.addField('Twitter__c');
            mainQuery.addField('Dealer_Ratings_List__c');
            mainQuery.addField('DMA__c');
            mainQuery.addField('Twitter_ID__c');
            mainQuery.addField('Dealer_Ratings_Link__c');
            mainQuery.addField('Total_Monthly_Rate__c');
            mainQuery.addField('Chat__c');
            mainQuery.addField('First_Name_Chat__c');
            mainQuery.addField('Last_Name_Chat__c');
            mainQuery.addField('Email_Chat__c');
            mainQuery.addField('Phone_Chat__c');
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
            extender = new KBB_New_CExtender(this);
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
    
    private static testMethod void testPageMethods() {        KBB_New_C extension = new KBB_New_C(new ApexPages.StandardController(new Opp_Product__c()));
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
        extension.getComponent12OptionsJS();
        extension.getComponent48OptionsJS();
        extension.getComponent72OptionsJS();
        extension.getComponent73OptionsJS();
        extension.getComponent74OptionsJS();
        extension.getComponent75OptionsJS();
        extension.getComponent38OptionsJS();
        extension.getComponent42OptionsJS();
        extension.getExtender();
    }
    public String getComponent12OptionsJS() {
        return SkyEditor2.JSON.stringify(SkyEditor2.PicklistValueSelector.getEntries(
        Opp_Product__c.getSObjectType(),
        SObjectType.Opp_Product__c.fields.Business_Type__c.getSObjectField()
        ));
        }
    public String getComponent48OptionsJS() {
        return SkyEditor2.JSON.stringify(SkyEditor2.PicklistValueSelector.getEntries(
        Opp_Product__c.getSObjectType(),
        SObjectType.Opp_Product__c.fields.ATC_Packages__c.getSObjectField()
        ));
        }
    public String getComponent72OptionsJS() {
        return SkyEditor2.JSON.stringify(SkyEditor2.PicklistValueSelector.getEntries(
        Opp_Product__c.getSObjectType(),
        SObjectType.Opp_Product__c.fields.Classified_Package__c.getSObjectField()
        ));
        }
    public String getComponent73OptionsJS() {
        return SkyEditor2.JSON.stringify(SkyEditor2.PicklistValueSelector.getEntries(
        Opp_Product__c.getSObjectType(),
        SObjectType.Opp_Product__c.fields.Classified_Package_1__c.getSObjectField()
        ));
        }
    public String getComponent74OptionsJS() {
        return SkyEditor2.JSON.stringify(SkyEditor2.PicklistValueSelector.getEntries(
        Opp_Product__c.getSObjectType(),
        SObjectType.Opp_Product__c.fields.Classified_Package_2__c.getSObjectField()
        ));
        }
    public String getComponent75OptionsJS() {
        return SkyEditor2.JSON.stringify(SkyEditor2.PicklistValueSelector.getEntries(
        Opp_Product__c.getSObjectType(),
        SObjectType.Opp_Product__c.fields.Classified_Package_3__c.getSObjectField()
        ));
        }
    public String getComponent38OptionsJS() {
        return SkyEditor2.JSON.stringify(SkyEditor2.PicklistValueSelector.getEntries(
        Opp_Product__c.getSObjectType(),
        SObjectType.Opp_Product__c.fields.iMR_Opt_In__c.getSObjectField()
        ));
        }
    public String getComponent42OptionsJS() {
        return SkyEditor2.JSON.stringify(SkyEditor2.PicklistValueSelector.getEntries(
        Opp_Product__c.getSObjectType(),
        SObjectType.Opp_Product__c.fields.Dealer_Ratings_List__c.getSObjectField()
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