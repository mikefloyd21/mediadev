public with sharing class APPDFExtension {

    private final static String INDENT_RAW = '&nbsp;&nbsp;&nbsp;&nbsp;';

    /* Misc. fields used in apex code & not on vf page. */
    private final static List<String> fieldsToAdd = new List<String> { 
      'Trade_Show_Consultant_s__c',
      'Reports_Reviewed_Other_Text__c',
      'Requested_Info_Other_Text__c',
      'What_s_New_Other_Text__c',
      'Learn_How_Consumers_Really_Shop__c',
      'Front_End_Fundamentals_of_Top_Dealership__c',
      'How_Your_Dealership_is_Doing__c',
      'What_s_New_at_AutoTrader_Group__c'
    };
    
    private final static List<String> fieldsReportsReviewed = new List<String> { 
      'Used_Scorecard__c',
      'New_Scorecard__c',
      'Dealer_Site__c',
      'Dealer_360__c',
      'Trade_In_Marketplace__c',
      'Tune_Up_Report__c',
      'Local_Market_Sheets__c',
      'Other_Reports_Reviewed__c'
    };
    
    private final static List<String> fieldsRequestedInfo = new List<String> { 
      'KBB__c',
      'Haystak__c',
      'DealShield__c',
      'F_I_Express__c',
      'GO_Financial__c',
      'HomeNet__c',
      'Trade_In_Marketplace_RR__c',
      'Make_My_Deal__c',
      'Manheim__c',
      'NextGear_Capital__c',
      'Ready_Transport__c',
      'RMS_Automotive__c',
      'vAuto__c',
      'Vin_Solutions__c',
      'XTime__c',
      'Other_Requested_Info__c'
    };
    
    private final static List<String> fieldsFrontEnd = new List<String> {
      'Vehicle_Selection__c',
      'Acquisition_Process__c',
      'Transportation__c',
      'Reconditioning__c',
      'Photos__c',
      'Descriptions__c',
      'Pricing__c',
      'Customer_Handling__c'
    };

    private final static List<String> fieldsWhatsNew = new List<String> {
      'Listing_Logic__c',
      'SEM__c',
      'Other_What_s_New__c'      
    };

    private final Action_Plan__c actionPlan;
    private final ApexPages.StandardController stdController;
    private List<String> accessibleFields;
    private Map<String, String> fieldMap = new Map<String, String>();
    private String INDENT;
 
    
    // The extension constructor initializes the private member
    // variable actionPlan by using the getRecord method from the standard
    // controller.
    public APPDFExtension (ApexPages.StandardController stdController) {
      /* Used in several places, init once. It's "kinda" a static. */
      INDENT = INDENT_RAW.unescapeHtml4();
      
        this.stdController = stdController;
        fieldsToAdd.addAll(fieldsReportsReviewed);
        fieldsToAdd.addAll(fieldsRequestedInfo);
        fieldsToAdd.addAll(fieldsFrontEnd);
        fieldsToAdd.addAll(fieldsWhatsNew);
        if (!Test.isRunningTest()) {
            this.stdController.addFields(fieldsToAdd);
        }
        this.actionPlan = (Action_Plan__c)stdController.getRecord();
        
        discoverAccessibleFields(this.actionPlan);
        Boolean dsValue = (Boolean)this.actionPlan.get('Dealer_Site__c');
        Boolean turValue = (Boolean)this.actionPlan.get('Tune_Up_Report__c');
        
        buildFieldMap();
        
        System.debug(fieldMap.get('Dealer_Site__c'.toLowerCase()) + '=' + dsValue);
        System.debug(fieldMap.get('Tune_Up_Report__c'.toLowerCase()) + '=' + turValue);
        System.debug('fm ' + fieldMap);
    }
    
    
    /**
     * Get the list of Trade Show Consultants in a list to be displayed by an apex:repeat.
     */
    public List<String> getConsultantsForDisplay() {
      List<String> consultants = new List<String>();
        System.debug('Consultants text is ' + this.actionPlan.Trade_Show_Consultant_s__c);
        if (this.actionPlan.Trade_Show_Consultant_s__c != null) {
            consultants = this.actionPlan.Trade_Show_Consultant_s__c.split(';', 0);
        }
        
        return consultants;
    }
    
    /**
     *
     */
    public List<String> getReportsReviewedItems() {
        List<String> reportsReviewedItems = getBooleanFields(fieldsReportsReviewed);
    
        addOther(this.actionPlan.Other_Reports_Reviewed__c,
                 this.actionPlan.Reports_Reviewed_Other_Text__c,
                 1,
                 reportsReviewedItems);
   
        return reportsReviewedItems;
    } 
    
    /**
     *
     */
    public List<String> getRequestedInfoItems() {
        List<String> requestedInfoItems = getBooleanFields(fieldsRequestedInfo);
    
        addOther(this.actionPlan.Other_Requested_Info__c,
                 this.actionPlan.Requested_Info_Other_Text__c,
                 1,
                 requestedInfoItems);
   
        return requestedInfoItems;
    } 
    
   /* public List<String> getAreasOfFocus() {
      /* With the list of dashed items in the middle, this can't be so generic. */
      /*  List<String> areasOfFocusItems = new List<String>();
      
      Integer counter = 1;
      
      if (this.actionPlan.Learn_How_Consumers_Really_Shop__c) {
        String line = '' + counter + ') ' + getDescriptionFor('Learn_How_Consumers_Really_Shop__c');
        areasOfFocusItems.add(line);
        counter++;
      }
      if (this.actionPlan.Front_End_Fundamentals_of_Top_Dealership__c) {
        /* Field labels are 40 chars max, we're going custom. */
       /* String line = '' + counter + ') Front-End Fundamentals:';
        areasOfFocusItems.add(line);
        counter++;
        areasOfFocusItems.addAll(getSubFields(fieldsFrontEnd));
      }
      if (this.actionPlan.How_Your_Dealership_is_Doing__c) {
          String line = '' + counter + ') ' + getDescriptionFor('How_Your_Dealership_is_Doing__c');
          areasOfFocusItems.add(line);
          counter++;
      }
      if (this.actionPlan.What_s_New_at_AutoTrader_Group__c) {
          String line = '' + counter + ') ' + getDescriptionFor('What_s_New_at_AutoTrader_Group__c');
          areasOfFocusItems.add(line);
          counter++;
          areasOfFocusItems.addAll(getSubFields(fieldsWhatsNew));
      }
      
      addOther(this.actionPlan.Other_What_s_New__c,
               this.actionPlan.What_s_New_Other_Text__c,
               2,
               areasOfFocusItems);
   
      
      return areasOfFocusItems;
    } */
    
    private List<String> getBooleanFields(List<String> fieldNames) {
      List<String> booleanFields = new List<String>();
      
      Integer counter = 1;
      
      for (String fieldName : fieldNames) {
        Boolean value = (Boolean)this.actionPlan.get(fieldName);
        if (value != null && value) {
          String line = '' + counter + ') ' + getDescriptionFor(fieldName);
          booleanFields.add(line);
          counter++;
        }
      }
      return booleanFields;
    }
    
    private List<String> getSubFields(List<String> fieldNames) {
      List<String> aofFields = new List<String>();
      
      for (String fieldName : fieldNames) {
        Boolean value = (Boolean)this.actionPlan.get(fieldName);
        if (value) {
          String line = INDENT + '-' + getDescriptionFor(fieldName);
          aofFields.add(line);
        }
      }
      return aofFields;
    }
    
    private void addOther(Boolean bool, String text, Integer indents, List<String> lst) {
      if (bool && text != null && text.length() > 0) {
        String note = '';
        for (Integer i = 0; i < indents; i++) {
            note = note + INDENT;
        }
        note = note + '-' + text;
        lst.add(note);
      }
    }
    
    private String getDescriptionFor(String fieldName) {
      String description = fieldMap.get(fieldName.toLowerCase());
      if (description == null) {
        description = 'N/A';
      }
      
      return description;
    }
    
    private void discoverAccessibleFields(sObject newObj) {
        this.accessibleFields = new List<String>();
        Map<String, Schema.SobjectField> fields = 
            newObj.getSObjectType().getDescribe().fields.getMap();
        for (String s : fields.keySet()) {
            if ((s != 'Name') && (fields.get(s).getDescribe().isAccessible())) {
                this.accessibleFields.add(s);
            }
        }
    }
    
    private void buildFieldMap() {
        Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        Schema.SObjectType leadSchema = schemaMap.get('Action_Plan__c');
        Map<String, Schema.SObjectField> fieldMap = leadSchema.getDescribe().fields.getMap();
        for (String fieldName: fieldMap.keySet()) {  
            String mylabel;
              //It provides to get the object fields label.
             mylabel = fieldMap.get(fieldName).getDescribe().getLabel();
             this.fieldMap.put(fieldName, myLabel);
        }      
    }
    
}