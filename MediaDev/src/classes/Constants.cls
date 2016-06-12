public without sharing class Constants {
    public static final String NONE = '--None--';
    public static final String MAKE = 'Make';
    public static final String EARLY_MODEL = 'Early Model';
    public static final String ALL_CAR = 'All Car';
    
    public static final String MEDIUM = 'Medium';
    public static final String LOW = 'Low';
    public static final String STRING_NEW = 'New';
    public static final String INTERNAL = 'Internal';
    public static final String NO = 'No';
    
    public static final Integer TIER_FIELD_SET_MAX_SIZE = 8;
    public static final Integer CAR_MAKE_FIELD_SET_MAX_SIZE = 4;
    public static final Integer DEFAULT_FIELD_SET_SIZE = 1;
    
    public static final String ORDER_STATUS_ACTIVATED = 'Activated';
    
    public static final String OPPORTUNITY_STAGE = 'Contract Submitted';

    public static final String STATE_FALSE = 'False';
    public static final String PRODUCT_SKU_ALL = 'All';
    public static final String CONTROLLING_FIELD_NONE = 'None';
    public static final String EXCEPTION_RULE = 'Exception';
    public static final String CONDITIONAL_RULE = 'Conditional Required';
    
    public static final String PACKAGE_CONFIG_RECORD_TYPE_PREMIUM_PACKAGE = 'Premium_Package';
    public static final String PACKAGE_CONFIG_RECORD_TYPE_GM_PACKAGE = 'GM_Package';
    public static final String PACKAGE_CONFIG_RECORD_TYPE_KBB_LEAD_DRIVER = 'KBB_Lead_Driver';
    
    public static final List<string> FEATURE_CONFIG_SUB_SECTION_SEQ = new List<string>{'alpha_fields','call_tracking_new_fields', 'call_tracking_used_fields',
        'chat_fields', 'dealer_ratings_fields', 'dealer_ratings_kbb_packages_fields', 'fastads_fields', 'kbb_call_tracking_new_fields', 'kbb_call_tracking_used_fields',
        'kbb_showcase_call_tracking_fields', 'kbb_showcase_fields', 'kbb_lead_driver_fields', 'leaderboard_new_fields', 'leaderboard_used_fields', 'oem_specials_fields',
        'sitelink_new_fields', 'sitelink_used_fields', 'skyscrapers_fields', 'social_connections_fields'};

    public static final Set<string> PRODUCT_CONFIG_REQUIRED_FIELD_EXCEPTION = new Set<string>{'Tier_Governor_Fields_Premium_Package__c', 'New_Car_Make_Fields_GM_Package__c',
                                                                'Used_Car_Make_GM_Package__c', 'Used_Car_Make_Quantity_GM_Package__c', 
                                                                'Front_Line_Pro_Model_Fields_GM_Package__c', 'KBB_Lead_Driver_Fields__c'};
                                                                    
    public static final Set<String> REGION_MAJOR_ACCOUNT = new Set<String>{'35', '43', '44'};                                          
}