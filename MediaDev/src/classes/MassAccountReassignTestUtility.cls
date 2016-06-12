public with sharing class MassAccountReassignTestUtility
{
  public String AccountNameStartsWith = 'TestAccountMassReassign';
  public List<Account> massReassignAccountList = new List<Account>();
  public String UserNameStartsWith = 'TestUserAccountMassReassign';
  public List<User> massReassignAccountUserList;
  public Integer dataSize = 200; 
  public List<AccountTeamMember> massReassignAccountTeamMemberList;
  public List<Task> massReassignAccountTaskList;
  public List<Opportunity> massReassignAccountOppList;
  public List<Task> massReassignAccountOppTaskList;
  
  MassAccountReassignTestData testData = new  MassAccountReassignTestData();
  
  public void CreateTestUsers(){
    testData.AccountNameStartsWith = AccountNameStartsWith;
    testData.UserNameStartsWith = UserNameStartsWith;
   if(!UserNameStartsWith.contains('Test'))
    {
      throw new ATGException('Not creating test users');
    }
     testData.createUsers(2);
  }
  
  public List<AccountTeamMember> massReassignAccountTeamMemList;
    public void CreateTestMassReassign(){
    
    
    massReassignAccountUserList= [Select id, Name from User where Name like :UserNameStartsWith+'%']; 
            if(massReassignAccountUserList.size() ==0){
         throw new ATGException('Create  test users');
        }
    
    
    if(!AccountNameStartsWith.contains('Test'))
    {
      throw new ATGException('Not creating test accounts');
    }
    

  
   testData.AccountNameStartsWith = AccountNameStartsWith;
    testData.UserNameStartsWith = UserNameStartsWith;
    //Setup data
    testData.createAccounts(dataSize);
    for(Account a :testData.mapAccList.values()){
        massReassignAccountList.add(a);
    }
   
    //setup teamMembers
    Integer count = 1;
    massReassignAccountTeamMemberList = new List<AccountTeamMember>();
    
    do {
         massReassignAccountTeamMemberList.add(testData.CreateAccountTeamMember(testData.GetAccount(count),massReassignAccountUserList.get(0),'Advertising Consultant- ATC'));
         count++;   
    } while (count <= dataSize );
    
    insert massReassignAccountTeamMemberList;
    
    //setup account tasks
    count = 1;
    massReassignAccountTaskList = new List<Task>();
    do {
        massReassignAccountTaskList.add(testData.CreateTask(massReassignAccountUserList.get(0).id,testData.GetAccount(count).id));
        count++;  
    } while (count <= dataSize);
    
    insert massReassignAccountTaskList;
    
    //setup account opps
    count =1;
    massReassignAccountOppList = new List<Opportunity>();
    do {
        massReassignAccountOppList.add(testData.CreateOpportunity(massReassignAccountUserList.get(0).id,testData.GetAccount(count).id));
        count++;
    } while (count <= dataSize);
    
    insert massReassignAccountOppList;
    
    //setup tasks for account opps
    count = 1;
    massReassignAccountOppTaskList = new List<Task>();
    for(Opportunity opp: massReassignAccountOppList){
    massReassignAccountOppTaskList.add(testData.CreateTask(massReassignAccountUserList.get(0).id,opp.id));
    }
    insert massReassignAccountOppTaskList;
    
    }
    
    public void GetTestMassReassignData(){
    
        // find all accounts that start with AccountNameStartsWith    
    if(!AccountNameStartsWith.contains('Test'))
    {
      throw new ATGException('Not selecting for test accounts');
    }
    if(!UserNameStartsWith.contains('Test'))
    {
      throw new ATGException('Not selecting for test users');
    }
     massReassignAccountList= [Select id, Name from Account where Name like :AccountNameStartsWith+'%'];  
    massReassignAccountUserList= [Select id, Name from User where Name like :UserNameStartsWith+'%'];  
    
     system.debug('MassReassignAccount Count:'+massReassignAccountList.size());
    system.debug('MassReassignAccount User Count:'+massReassignAccountUserList.size()); 
    
      for(Account a: massReassignAccountList){      
      system.debug('MassReassignAccount Name:'+ a.Name+' Id:'+a.id);
    }
          for(User u: massReassignAccountUserList){      
      system.debug('MassReassignAccount User Name:'+ u.Name+' Id:'+u.id);
    } 
    }
    
      public void DeleteTestMassReassignData(){
    
    //delete accounts 
    delete massReassignAccountList;
    //inactivate users
    //update massReassignAccountUserList;
    
  }
  
        public void InactivateTestMassReassignUserData(){
 for(User u: massReassignAccountUserList){      
          u.isActive  = false;
          }
    //inactivate users
    update massReassignAccountUserList;
    }
  
    
    
}