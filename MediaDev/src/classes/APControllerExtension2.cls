public with sharing class APControllerExtension2 {

    private final static List<String> fieldsToAdd = new List<String> { 
        'Name', 'LastModifiedDate', 'Trade_Show_Consultant_s__c'
    };
    
    private final static String REDIRECT_URL = '/apex/ActionPlanCreate2?Id=';
    private final static String RECORD_TYPE_NAME = 'NADA';
    
    private final Action_Plan__c actionPlan;
    private final ApexPages.StandardController stdController;
    private PageReference editRef = null;
    
    public Boolean Name2Editable {get;set;}
            
    public List<SelectOption> LeftSelectList {get;set;}
    public List<SelectOption> RightSelectList {get;set;}
 
    public List<String> LeftSelectedValues {get;set;}
    public List<String> RightSelectedValues {get;set;}
 
    /*
     * The extension constructor initializes the private member
     * variable actionPlan by using the getRecord method from the standard
     * controller.
     */
    public APControllerExtension2(ApexPages.StandardController stdController) {
        
        Name2Editable = true; /* Assume no record found, switch if it's found. */
        this.stdController = stdController;
        if (!Test.isRunningTest()) {
            this.stdController.addFields(fieldsToAdd);
        }
        this.actionPlan = (Action_Plan__c)stdController.getRecord();
        
        System.debug(' Constructor Id is ' + this.actionPlan.Id);
        System.debug(' Constructor Name is ' + this.actionPlan.Name);
        
        String id = System.currentPageReference().getParameters().get('Id');
        String svocId = System.currentPageReference().getParameters().get('svocId');
        String accountId = System.currentPageReference().getParameters().get('accountId');
        String leadId = System.currentPageReference().getParameters().get('leadId');
        String nameId = System.currentPageReference().getParameters().get('name');
        /* Massage name to have AP- in front of it, if necessary. */
        if (isValid(nameId)) {
            nameId = nameId.toUpperCase();
            if (!nameId.startsWith('AP-')) {
                nameId = 'AP-' + nameId;
            }
        }
        
        Schema.DescribeFieldResult dfr = Action_Plan__c.Trade_Show_Name__c.getDescribe();
        String mdDefaultValue = ((String)dfr.getDefaultValueFormula()).replace('"', '');
        System.debug(' default trade show name in instance is ' + this.actionPlan.Trade_Show_Name__c);
        System.debug(' default trade show name in md is ' + mdDefaultValue);
        
        /* If we were passed in an Id, it's an edit, we go with that. */ 
        if (!isValid(id)) {
            /* 
             * If we have a dealer id, try to see if there's already a record. 
             * If so, use it. If not, fill in some data in new record from
             * Account.
             */
            if (isValid(svocId) || isValid(accountId) || isValid(nameId)) {
                System.debug('svocId is ' + svocId + ', account id is ' + accountId);
                
                /* values used for searches. Will be filled in with defaults if search unsuccessful. */
                List<Account> accounts = null;
                List<AccountTeamMember> acctTeamMembers = null;
                List<Action_Plan__c> currentActionPlans = null;
                String dealerName = '';
                String dealerAC = 'No AC Assigned';
                
                /*
                 * If name is passed in, then we assume that we know the Action Plan we want to 
                 * retrieve directly. If svocId or accountId is passed in then we need to get it
                 * indirectly from getting the account associated with that Id.
                 */
                if (isValid(nameId)) {
                    currentActionPlans = 
                        [select a.Id 
                         from Action_Plan__c a 
                         where a.Name = :nameId];
                } else {
                    if (isValid(svocId)) {
                        accounts = [select Id, Name from Account where SVOC_Id__c = :svocId];
                    } else {
                        accounts = [select Id, Name from Account where Id = :accountId];
                    }
                    
                    if (accounts.size() > 0) {
                        /* 
                         * Figure out current AC, hopefully from account team member.
                         * If no account team member, used current AC in account. 
                         */
                        String acctId = accounts[0].Id;
                        acctTeamMembers = [select UserId from AccountTeamMember where TeamMemberRole = 'Advertising Consultant - ATC' and AccountId = :acctId];
                        System.debug('Acct Team Members');
                        System.debug(acctTeamMembers);
                        if (acctTeamMembers.size() > 0) {
                            System.debug(' Account team member id is ' + acctTeamMembers[0].UserId);
                            // // String acctTeamMemberId = acctTeamMembers[0].UserId;
                            this.actionPlan.OwnerId = acctTeamMembers[0].UserId;
                            List<User> acUsers = [select Name from User where Id = :acctTeamMembers[0].UserId];
                            if (acUsers.size() > 0) {
                                System.debug('We had an account team member, name is ' + acUsers[0].Name);
                                dealerAC = acUsers[0].Name;
                            }
                            
                        } else {
                            System.debug('No account team member, using \'No AC Assigned\'');
                        }
                        Name2Editable = false; /* Even if new AP, we have the name from the account. */
                        // User stuff
                        dealerName = accounts[0].Name;
                        currentActionPlans = 
                            [select a.Id 
                             from Action_Plan__c a 
                             where a.Action_Plan_Name2__c = :dealerName and a.Discussion_Date__c = TODAY];
                    }
                }

                if (currentActionPlans != null && currentActionPlans.size() > 0) { /* We have a hit. */
                    /*
                     * Making the page reference non-null, combined with the redirect action on the VF page
                     * will make this redirect to the already existing record for this dealer today.
                     */
                    System.debug(' we had a hit for dealer ' + accountId + ', ' + currentActionPlans[0].Id);
                    editRef = new PageReference(REDIRECT_URL + currentActionPlans[0].Id);
                    editRef.setRedirect(true);
                } else { /* It's a new one for today, just fill in info from account. */
                    System.debug('no hits for dealer ' + accountId );
                    this.actionPlan.Action_Plan_Name2__c = dealerName;
                    this.actionPlan.ATC_Consultant__c = dealerAC;
                    this.actionPlan.Trade_Show_Name__c = mdDefaultValue;
                    if (accounts.size() > 0) {
                        this.actionPlan.Account__c = accounts[0].Id;
                    } 
                }
            } else if (isValid(leadId)) {
                System.debug('lead id is ' + leadId);
                List<Lead> leads = null;
                String leadName = 'N/A';
                String leadAC = 'N/A';
                
                leads = [select Id, Company, OwnerId from Lead where Id = :leadId];
                if (leads.size() > 0) {
                    /* Get lead owner to use name as ATC Consultant. */
                    List<User> users = null;
                    users = [select Id, Name from User where Id = :leads[0].OwnerId];
                    if (users.size() > 0) {
                        Name2Editable = false;
                        leadName = leads[0].Company;
                        leadAC = users[0].Name;
                    }
                }
            
                Action_Plan__c[] currentActionPlans = 
                    [select a.Id 
                     from Action_Plan__c a 
                     where a.Action_Plan_Name2__c = :leadName and a.Discussion_Date__c = TODAY];

                if (currentActionPlans.size() > 0) { /* We have a hit. */
                    /*
                     * Making the page reference non-null, combined with the redirect action on the VF page
                     * will make this redirect to the already existing record for this dealer today.
                     */
                    System.debug(' we had a hit for lead ' + leadId + ', ' + currentActionPlans[0].Id);
                    editRef = new PageReference('/apex/ActionPlanCreate2?Id=' + currentActionPlans[0].Id);
                    editRef.setRedirect(true);
                } else { /* It's a new one for today, just fill in info from account. */
                    System.debug('no hits for dealer ' + accountId );
                    this.actionPlan.Action_Plan_Name2__c = leadName;
                    /* Get people sometime. */
                    this.actionPlan.ATC_Consultant__c = leadAC;
                    this.actionPlan.Trade_Show_Name__c = mdDefaultValue;
                }
                
            }
        } else {
            Name2Editable = false;
        }
        
        LeftSelectList = new List<SelectOption>();
        RightSelectList = new List<SelectOption>();
        
        if (this.actionPlan.Discussion_Date__c == null) {
            this.actionPlan.Discussion_Date__c = Date.today();
        }
        
        Show_Consultant__c[] showConsultants = [SELECT Name from Show_Consultant__c ORDER BY Name];  
        
        for (Show_Consultant__c showConsultant : showConsultants) {
            LeftSelectList.add(new SelectOption(showConsultant.Name, showConsultant.Name));
        }
        
        /* Check to see if there are any consultants currently set up; if so, put them on the right. */
        System.debug('Raw consultants are ' + this.actionPlan.Trade_Show_Consultant_s__c);
        if (this.actionPlan.Trade_Show_Consultant_s__c != null && this.actionPlan.Trade_Show_Consultant_s__c.length() > 0) {
            System.debug('There are consultants');
            LeftSelectedValues = this.actionPlan.Trade_Show_Consultant_s__c.split(';');
            System.debug('They are ' + LeftSelectedValues);
            MoveRight();
        }
        System.debug('Constructor LMD is ' + this.actionPlan.LastModifiedDate);
    }
    
    public void MoveRight() {
        System.debug('In MoveRight');
        if (LeftSelectedValues != null && LeftSelectedValues.size() > 0) {
            
            List<String> matchers = LeftSelectedValues.clone();
            
            // Clear RightSelectedValues
            RightSelectedValues = new List<string>();
            
            
            for (integer i = 0; i < matchers.size(); i++) {
                String transferS = removeMatchingString(LeftSelectedValues, matchers[i]);
                if (transferS != null) {
                    RightSelectedValues.add(transferS);
                }
                
                SelectOption transferSO = removeMatchingSelectOption(LeftSelectList, matchers[i]);
                if (transferSO != null) {
                    RightSelectList.add(transferSO);
                }
 
            }
        }
    }
 
    public void MoveLeft() {
        System.debug('In MoveLeft');
        if (RightSelectedValues != null && RightSelectedValues.size() > 0) {
            
            List<String> matchers = RightSelectedValues.clone();
            
            //Clear LeftSelectedValues
            LeftSelectedValues = new List<string>();

            for (integer i = 0; i < matchers.size(); i++) {
                String transferS = removeMatchingString(RightSelectedValues, matchers[i]);
                if (transferS != null) {
                    LeftSelectedValues.add(transferS);
                }
                
                SelectOption transferSO = removeMatchingSelectOption(RightSelectList, matchers[i]);
                if (transferSO != null) {
                    LeftSelectList.add(transferSO);
                }
 
            }
        }
    }
    

    private String removeMatchingString(List<String> strings, String value) {
        String returnValue = null;
        for (integer i = 0; i < strings.size(); i++) {
            if (strings[i].equals(value)) {
                System.debug('String Got a match on ' + strings[i]);
                returnValue = strings.remove(i);
                break;
            }
        }
        return returnValue;
    }

    private SelectOption removeMatchingSelectOption(List<SelectOption> options, String value) {
        SelectOption returnValue = null;
        for (integer i = 0; i < options.size(); i++) {
            if (options[i].getValue().equals(value)) {
                System.debug('SelectOption Got a match on ' + options[i]);
                returnValue = options.remove(i);
                break;
            }
        }
        return returnValue;
    }

    /*
     * This is an action on the corresponding VF page, that will be run after the constructor.
     * The constructor may put a value in the Page Reference when the user requests a dealer that
     * already has a record for this day.
     */
    public PageReference redirect() {
        return this.editRef;
    }
    
    private Boolean isValid(String str) {
        return (str != null && str.length() > 0);
    }
    
    /*
     * Overriding save so that we read the trade show consultants out of the custom
     * pick list and format them for storage.
     */
    public PageReference save() {
        
        /* Don't let someone move on if they haven't added any consultants. */
        /* USING 'grab from Show Consultants object' method. */
        // if (RightSelectList == null || RightSelectList.size() == 0) {
        //  ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'You must add at least one consultant.'));
        //  return null;
        //}
        // 
        // List<String> consultants = new List<String>();
        // 
        // /* Consultants in right select get added to Trade Show Consultants. */
        // for (SelectOption so : RightSelectList) {
        //     consultants.add(so.getValue());
        // }
        // consultants.sort();
        // String text = String.join(consultants, ';');
        // this.actionPlan.Trade_Show_Consultant_s__c = text;
         
        /* Don't let someone move on if they haven't added any consultants. */
        /* Using 'hard coded picklist' method. */
        if (this.actionPlan.Trade_Show_Consultant_s__c == null || 
            this.actionPlan.Trade_Show_Consultant_s__c.length() == 0) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'You must add at least one consultant.'));
            return null;
        }
        
        
        /* 
         * Apex check to make sure that if "Front End Fundamentals" is unchecked, then
         * the sub-choices are unchecked as well.
         */
        if (this.actionPlan.Front_End_Fundamentals_of_Top_Dealership__c == false) {
            System.debug('Setting Fron End check boxes to false.');
            this.actionPlan.Vehicle_Selection__c = false;
            this.actionPlan.Photos__c = false;
            this.actionPlan.Acquisition_Process__c = false;
            this.actionPlan.Descriptions__c = false;
            this.actionPlan.Transportation__c = false;
            this.actionPlan.Pricing__c = false;
            this.actionPlan.Reconditioning__c = false;
            this.actionPlan.Customer_Handling__c = false;
        }
        
        /* 
         * Apex check to make sure that if "What's New" is unchecked, then
         * the sub-choices are unchecked as well.
         */
        if (this.actionPlan.What_s_New_at_AutoTrader_Group__c == false) {
            System.debug('Setting What\'s New check boxes to false.');
            this.actionPlan.Listing_Logic__c = false;
            this.actionPlan.SEM__c = false;
            this.actionPlan.Real_Time_Analytics__c = false;
            this.actionPlan.KBB_CPO__c = false;
        }
        
        /*
         * Set the correct record type for the Action Plan. Use this one regardless of 
         * user's record type.
         */
        List<RecordType> recordTypes = [select Id, Name from RecordType where Name = :RECORD_TYPE_NAME and SobjectType = 'Action_Plan__c'];
        if (recordTypes.size() > 0) {
            System.debug('We got a record type, ' + recordTypes[0].Id);
            this.actionPlan.RecordTypeId = recordTypes[0].Id;
        } else {
            System.debug('No record types for ' + RECORD_TYPE_NAME);
        }
         
        System.debug(' This  Action Plan is ' + this.actionPlan);
        
        PageReference detailPage = stdController.save();
        System.debug(' Id from controller is' + stdController.getId());
        
        Action_Plan__c savedActionPlan = (Action_Plan__c)stdController.getRecord();
        
        
        System.debug(' Saved Action Plan is ' + savedActionPlan);
        System.debug(' Saved Id is ' + savedActionPlan.Id);
        System.debug(' Saved Name is ' + savedActionPlan.Name);

        PageReference saveRedirect = new PageReference(REDIRECT_URL + savedActionPlan.Id);
        saveRedirect.setRedirect(true);
        
        return saveRedirect;
    }
    
}