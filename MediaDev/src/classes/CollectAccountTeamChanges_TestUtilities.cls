public with sharing class CollectAccountTeamChanges_TestUtilities{

//Lists
public List<User>           testUserList { get; set; }
public List<Account>        testAccList  { get; set; }

public List<String> Roles = new list<String> { 'Advertising Consultant - ATC','Business Manager'};


//Objects
public User         testUser { get; set; }
public Account      testAcc  { get; set; }



public AccountTeamMember  CreateAccountTeamMember(Account a , User u, string role){
AccountTeamMember at = new AccountTeamMember();
at.AccountId = a.id;
at.UserId = u.id;
at.TeamMemberRole  = role;
return at;
}

public AccountTeamMember_History__c  CreateAccountTeamMemberHistory(Account a , User u, string role){
AccountTeamMember_History__c ath = new AccountTeamMember_History__c();
ath.Account__c = a.id;
ath.TeamMember__c = u.id;
ath.Role__c  = role;
ath.RecentChangeDate__c = Date.today().addDays(-1);
ath.RecentSVOCSync__c = Date.today().addDays(-1);
ath.IsRecentSyncSucceed__c = true;
return ath;
}

public AccountTeamMember_History__c  CreateAccountTeamMemberHistory(Account a , User u, string role, Boolean isRecentSyncSucceed){
AccountTeamMember_History__c ath = new AccountTeamMember_History__c();
ath.Account__c = a.id;
ath.TeamMember__c = u.id;
ath.Role__c  = role;
ath.RecentChangeDate__c = Date.today().addDays(-1);
ath.RecentSVOCSync__c = Date.today().addDays(-1);
ath.IsRecentSyncSucceed__c = isRecentSyncSucceed;
return ath;
}


public void createUsers( Integer usersToCreate ){
Profile pfl = [select id from profile where name='Standard User'];
    List<User> auxList = new List<User>();
    
    for( Integer i = 1; i <= usersToCreate; i++ ){
        User usrAux = new User();
       
        usrAux.Username = 'testAccountTeamUser'+i+'@test.com';
        usrAux.FirstName= this.createRandomWord();
        usrAux.LastName= this.createRandomWord();
        usrAux.IsActive= true;
        usrAux.Email = usrAux.Username;
        usrAux.Alias = i+usrAux.FirstName.SubString(0,1)+usrAux.LastName.SubString(0,1);
        usrAux.TimeZoneSidKey= 'America/Los_Angeles';
        usrAux.LocaleSidKey= 'en_US';
        usrAux.EmailEncodingKey ='UTF-8';
        
        usrAux.ProfileId = pfl.id;
        usrAux.LanguageLocaleKey ='en_US';
        
        

        
        auxList.add( usrAux);
    }
    
         try{
            insert auxList;
        }
        catch( Exception ex ){
        System.debug(LoggingLevel.ERROR, 'getTypeName:'+ex.getTypeName());
        System.debug(LoggingLevel.ERROR,'getCause:'+ex.getCause());
        System.debug(LoggingLevel.ERROR,'getLineNumber:'+ex.getLineNumber());
        System.debug(LoggingLevel.ERROR,'getMessage:'+ex.getMessage());
        System.debug(LoggingLevel.ERROR,'getStackTraceString:'+ex.getStackTraceString());


            System.assert( false ,ex.getMessage()+' '+ex.getStackTraceString()+'Pre deploy test failed, This may be because of custom validation rules in your Org. You can check ignore apex errors or temporarily deactivate your validation rules for Accounts and try again.');
        }
        this.testUserList = new List<User>();
        this.testUserList.addAll( auxList );
  
}
/**
* Create Account's
* @params accountToCreate ( the total amount of account )
*/
public void createAccounts( Integer accountToCreate ){

    List<Account> auxList = new List<Account>();
    
    for( Integer i = 1; i <= accountToCreate; i++ ){
        Account accAux              = new Account();
        accAux.Name                 = this.createRandomWord();
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

        
        auxList.add( accAux );
    }
    
         try{
            insert auxList;
        }
        catch( Exception ex ){
            System.assert( false ,'Pre deploy test failed, This may be because of custom validation rules in your Org. You can check ignore apex errors or temporarily deactivate your validation rules for Accounts and try again.');
        }
        this.testAccList = new List<Account>();
        this.testAccList.addAll( auxList );
  
}

/**
* Random words are required for testing 
* as you will likely run into any word I can insert
* during a test class and produce false test results.
*/
public String createRandomWord(){
  String ret = 'word' + math.rint( math.random() * 100000 );
  
  return ret;
}

}