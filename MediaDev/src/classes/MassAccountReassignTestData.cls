public with sharing class MassAccountReassignTestData
{

    public String AccountNameStartsWith = 'TestAccountMassReassign';
    public String UserNameStartsWith = 'TestUserAccountMassReassign';
    public Map<String, Account>        mapAccList = new Map<String, Account>();
    public Map<String, User>        mapUserList = new Map<String, User>();
   
public Account GetAccount(Integer index){
    system.debug('Getting Account by Name:' + AccountNameStartsWith+string.valueOf(index));
    return mapAccList.get(AccountNameStartsWith+string.valueOf(index));
}

public User GetUser(Integer index){
    system.debug('Getting User by Name:' + UserNameStartsWith+string.valueOf(index));
    return mapUserList.get(UserNameStartsWith +string.valueOf(index));
}


public AccountTeamMember  CreateAccountTeamMember(Account a , User u, string role){
AccountTeamMember at = new AccountTeamMember();
at.AccountId = a.id;
at.UserId = u.id;
at.TeamMemberRole  = role;
return at;
}

private RecordType accountRecordType = null;
public RecordType GetaccountRecordType(){
//Get a valid RecordType
if(accountRecordType == null){
accountRecordType = [Select r.Id, r.Name from RecordType r where  r.SobjectType= 'Account' and r.Name = 'Dealer' Limit 1];
}
return accountRecordType;
}

public Task CreateTask(String userId, String parentId){
Task t = new Task();
t.ownerId = userId;
t.WhatId = parentId;
t.status = 'open';
return t;
}

public Opportunity CreateOpportunity(String userId, String accountId){
// Get a valid stage name 
OpportunityStage stage = [select MasterLabel from OpportunityStage where MasterLabel  = 'Prospecting' limit 1];
//Get a valid RecordType
RecordType RecordType = [Select r.Id, r.Name from RecordType r where  r.SobjectType= 'Opportunity' Limit 1];

Opportunity o = new Opportunity();
o.Name = 'TestOpp';
o.StageName    = stage.masterlabel;
o.AccountId = accountId;
o.RecordTypeId = RecordType.Id;
o.ownerId  = userId;
o.CloseDate    = Date.today();
return o;
}

   
   public void createUsers( Integer usersToCreate ){
Profile pfl = [select id from profile where name='Standard User'];
    List<User> auxInsertList = new List<User>();
        List<User> auxUpdateList = new List<User>();
        List<User> auxList = new List<User>();
    
    for( Integer i = 1; i <= usersToCreate; i++ ){
        String userName = UserNameStartsWith +i+'@test.com';
        
        List<User> existingUser =[Select Id, Username ,Name from User where Username =:userName ];
       
        User usrAux;
        if(existingUser.size() ==0){
         usrAux = new User();                
        usrAux.Username = userName ;
                usrAux.FirstName= UserNameStartsWith ;
        usrAux.LastName= String.valueOf(i);
        usrAux.IsActive= true;
        usrAux.Email = usrAux.Username;
        usrAux.Alias = i+usrAux.FirstName.SubString(0,1)+usrAux.LastName.SubString(0,1);
        usrAux.TimeZoneSidKey= 'America/Los_Angeles';
        usrAux.LocaleSidKey= 'en_US';
        usrAux.EmailEncodingKey ='UTF-8';
        
        usrAux.ProfileId = pfl.id;
        usrAux.LanguageLocaleKey ='en_US';
         }
         else
         {
          
             usrAux=existingUser[0];
             usrAux.IsActive= true;
         }


        
        

        if(usrAux.Id == null){
        auxInsertList.add( usrAux);
        }
        else{
        auxUpdateList.add( usrAux);
        }
    }
    
         try{
        if(auxInsertList.size()> 0){
            insert auxInsertList;
            auxList.addAll(auxInsertList);
            }
        if(auxUpdateList.size()> 0){
            Update auxUpdateList;
            auxList.addAll(auxUpdateList);
            } 
            
        }
        catch( Exception ex ){
        System.debug(LoggingLevel.ERROR, 'getTypeName:'+ex.getTypeName());
        System.debug(LoggingLevel.ERROR,'getCause:'+ex.getCause());
        System.debug(LoggingLevel.ERROR,'getLineNumber:'+ex.getLineNumber());
        System.debug(LoggingLevel.ERROR,'getMessage:'+ex.getMessage());
        System.debug(LoggingLevel.ERROR,'getStackTraceString:'+ex.getStackTraceString());


            System.assert( false ,ex.getMessage()+' '+ex.getStackTraceString()+'Pre deploy test failed, This may be because of custom validation rules in your Org. You can check ignore apex errors or temporarily deactivate your validation rules for Accounts and try again.');
        }
        for(User u: auxList){
           //system.debug('User Name:'+ u.Name);
             if(!mapUserList.containsKey(u.FirstName+u.LastName)){
             //system.debug('Adding User Name:'+ u.FirstName+u.LastName + ' Id:'+u.id);
             mapUserList.put(u.FirstName+u.LastName,u);
             }
             else{
                 throw new ATGException('Duplicate Users with Name:'+u.FirstName+u.LastName);
             }
             
             
        }
  
}

   public void createAccounts( Integer accountToCreate ){

    List<Account> auxList = new List<Account>();
    
    for( Integer i = 1; i <= accountToCreate; i++ ){
        Account accAux              = new Account();
        accAux.Name                 = AccountNameStartsWith+i;
        accAux.ShippingStreet       = '1 Main St.';
        accAux.ShippingState        = 'VA';
        accAux.ShippingPostalCode   = '12345';
        accAux.ShippingCountry      = 'USA';
        accAux.ShippingCity         = 'Anytown';
        accAux.Description          = 'This is a test account';
        accAux.BillingStreet        = '1 Main St.';
        accAux.BillingState         = 'VA';
        accAux.BillingPostalCode    = '12345';
        accAux.BillingCountry       = 'USA';
        accAux.BillingCity          = 'Anytown';
        accAux.AnnualRevenue        = 10000;
        accAux.ParentId             = null;
        accAux.Type = 'Customer';
        //accAux.RecordTypeId = '012E000000052TQIAY';//GetaccountRecordType().Id;
        
        auxList.add( accAux );
       
    }
    
         try{
            insert auxList;
           
        }
        catch( Exception ex ){
            System.assert( false ,'Pre deploy test failed, This may be because of custom validation rules in your Org. You can check ignore apex errors or temporarily deactivate your validation rules for Accounts and try again.');
        }
        
        //change the record type

          for(Account a: auxList){
           a.RecordTypeId = GetaccountRecordType().Id; //'012E000000052TQIAY'
           }
        
        update auxList;       
        
         for(Account a: auxList){
             //system.debug('Account Name:'+ a.Name);
             if(!mapAccList.containsKey(a.Name)){
             //system.debug('Adding Account Name:'+ a.Name + ' Id:'+a.id);
             mapAccList.put(a.Name,a);
             }
             else{
                 throw new ATGException('Duplicate Accounts with Name:'+a.Name);
             }
             
             
         }
  }

  }