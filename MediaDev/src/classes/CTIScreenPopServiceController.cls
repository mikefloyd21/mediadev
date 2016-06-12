public class CTIScreenPopServiceController 
{
//Story B-10409: Visualforce page accepts the information that CTI provides on the querystring of the URL and 
// generates a page that searches for Contacts and Accounts.Display open cases, closed cases, email and tasks.
// The records & columns that display in the screen pop will be clickable into that record, similar to the way related lists work. 
// For example, a contact record match will have a column for the account, that will click into the associated account.
    
    public List<Account> accounts {get; private set;}
    public List<Contact> contacts {get; private set;}
    public List<Case> openCases {get; private set;}
    public List<Case> closedCases {get; private set;}
    public List<Task> acts {get; private set;}
    public String callerId {get; private set;}
    public String UUI2 {get; private set;}
    public String UUI {get; private set;}    
    public String URLText {get; private set;}
    Account newAcc;
    public String UUI2format {get; private set;}

    public CTIScreenPopServiceController() 
    {      
      try {
        callerId = ApexPages.currentPage().getParameters().get('ANI');
        UUI = ApexPages.currentPage().getParameters().get('UUI');
        URLText = ApexPages.currentPage().getUrl() ; 
        system.debug('CTI URL:'+URLText);
        system.debug('ANI:'+callerId);
        //split UUI into parts, 1st and 2nd parts are redundant, 3rd and 4th are IVR input
        List<String> parts = UUI.split('!');
        system.debug('parts'+parts+parts.size());
        if(parts.size()==4)
            UUI2= parts[3];
        else
            UUI2=null;
            
        // First find information using caller id (ANI)
        if (callerId.length() >= 10)
            callerId = '(' + callerId.substring(0, 3) + ') ' + callerId.substring(3, 6) + '-' + callerId.substring(6);
        system.debug('Caller ID'+callerId );        
        //initialize lists
        accounts = new list<Account>();
        contacts = new list<Contact>();
        openCases = new list<Case>();
        closedCases = new list<Case>();
        acts = new list<Task>();
        if (callerId != null)
        {
            List<List<SObject>> searchList = [FIND :callerId  IN PHONE FIELDS RETURNING Account(Id, Name,ShippingCity,ShippingState,ShippingPostalCode,Phone,SVOC_Id__c), Contact(Id, Name,AccountId,Account.Name,Phone,Email,MobilePhone,Title)];
            system.debug('SearchList:'+searchList[0] );
            system.debug('SearchList:'+searchList[1] );
            system.debug(UUI2);
            if (searchList[0].size()>0 || searchList[1].size()>0)
            {
                accounts = ((List<Account>)searchList[0]);
                Set<Account> myAcc = new Set<Account>();
                //create a set of account ids to compare later
                myAcc.addAll(accounts);

                contacts = ((List<Contact>) searchList[1]);
                for (Contact c:contacts)
                {
                    if (c.AccountId != null)
                    {
                        newAcc = [select Id, Name,ShippingCity,ShippingState,ShippingPostalCode,Phone,SVOC_Id__c from account where Id =: c.AccountId];
                        if (!myAcc.contains(newAcc))
                        {
                            myAcc.add(newAcc);
                            accounts.add(newAcc);                        
                        }
                    }
                }
                system.debug('accounts:'+accounts);
                for (Account a :accounts)
                {
                    closedCases = [select Id, AccountId, CaseNumber, Subject, ATC_Sub_Reason__c, Owner.Name, Status, CreatedDate,ClosedDate from Case where AccountId = : a.Id and Status ='Closed' ORDER BY ClosedDate DESC LIMIT 25 ];
                    openCases = [select Id, AccountId, CaseNumber, Subject, ATC_Sub_Reason__c, Owner.Name, Status, CreatedDate from Case where AccountId = : a.Id and Status != 'Closed'];
                    acts = [select Id, WhatId, Subject, Type, Owner.Name, Status, ActivityDate,Date_Completed__c from Task where WhatId = : a.Id ORDER BY Date_Completed__c DESC LIMIT 25];
                }
            }
            if (UUI2 != null && accounts.isEmpty())
            {
                // Now see if the number in UUI 2 is a phone number entered, if so then it may return some information.
                if (UUI2.length() >= 10)
                    UUI2format = '(' + UUI2.substring(0, 3) + ') ' + UUI2.substring(3, 6) + '-' + UUI2.substring(6);
                else
                    UUI2format =   UUI2;             

                List<List<SObject>> searchList2 = [FIND :UUI2format IN PHONE FIELDS RETURNING Account(Id, Name,ShippingCity,ShippingState,ShippingPostalCode,Phone,SVOC_Id__c), Contact(Id, Name,Account.Name,Phone,Email,MobilePhone,Title)];
                if (searchList2[0].size()>0 || searchList2[1].size()>0) 
                {
                    accounts = ((List<Account>)searchList2[0]);
                    contacts = ((List<Contact>) searchList2[1]);
                    Set<Account> myAcc2 = new Set<Account>();
                    //create a set of account ids to compare later
                    myAcc2.addAll(accounts);
                    for (Contact c:contacts)
                    {
                        if (c.AccountId != null)
                        {
                            newAcc = [select Id, Name,ShippingCity,ShippingState,ShippingPostalCode,Phone,SVOC_Id__c from account where Id =: c.AccountId];
                            if (!myAcc2.contains(newAcc))
                            {
                                myAcc2.add(newAcc);
                                accounts.add(newAcc);                        
                            }
                        }
                    }
                    for (Account a :accounts)
                    {
                        closedCases = [select Id, AccountId, CaseNumber, Subject, ATC_Sub_Reason__c, Owner.Name, Status, CreatedDate,ClosedDate from Case where AccountId = : a.Id and Status ='Closed' ORDER BY ClosedDate DESC LIMIT 25 ];
                        openCases = [select Id, AccountId, CaseNumber, Subject, ATC_Sub_Reason__c, Owner.Name, Status, CreatedDate from Case where AccountId = : a.Id and Status != 'Closed'];
                        acts = [select Id, WhatId, Subject, Type, Owner.Name, Status, ActivityDate,Date_Completed__c from Task where WhatId = : a.Id ORDER BY Date_Completed__c DESC LIMIT 25];
                    }                    
                }
                // Go here if number entered is an svoc id
                else
                {
                    accounts = [select Id, Name,ShippingCity,ShippingState,ShippingPostalCode,Phone,SVOC_Id__c from account where SVOC_Id__c =: UUI2 and SVOC_Id__c!=null];
                    for (Account a :accounts)
                    {
                        contacts = [select Id, Name,AccountId, Account.Name,Phone,Email,MobilePhone,Title from contact where AccountID =: a.Id];
                        closedCases = [select Id, AccountId, CaseNumber, Subject, ATC_Sub_Reason__c, Owner.Name, Status, CreatedDate,ClosedDate from Case where AccountId = : a.Id and Status ='Closed' ORDER BY ClosedDate DESC LIMIT 25 ];
                        openCases = [select Id, AccountId, CaseNumber, Subject, ATC_Sub_Reason__c, Owner.Name, Status, CreatedDate from Case where AccountId = : a.Id and Status != 'Closed'];
                        acts = [select Id, WhatId, Subject, Type, Owner.Name, Status, ActivityDate,Date_Completed__c from Task where WhatId = : a.Id ORDER BY Date_Completed__c DESC LIMIT 25];
                    }
                }
            }
        }
        else //callerID is null
        {
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'No Caller ID detected');
            ApexPages.addMessage(myMsg);
        }
      } catch(Exception e) {
            ApexPages.Message myMsg2 = new ApexPages.Message(ApexPages.Severity.ERROR,'Exeption: No call info available');
            ApexPages.addMessage(myMsg2);
            system.debug('Exeption:'+e);
      }
            
    }       
}