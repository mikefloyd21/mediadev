public class MassAccountTeamReassignController {

public Integer TotalExistingRows{get; set;}
public Integer RowsLimit{get; set;}

public Boolean ReassignActivites{get; set;}

public Boolean ReassignOpportunities{get; set;}

public String  getLimitExceededMessage(){
if(TotalExistingRows > RowsLimit){
return SearchAccountResults.size() + ' rows displayed out of ' + TotalExistingRows + ' total number of rows';
}
else{
return 'Total rows: ' + TotalExistingRows;
}
}

List<MassAccountTeamReassignRec> searchAccountResults = new List<MassAccountTeamReassignRec>();
List<MassAccountTeamReassignRec> selectedAccounts = new List<MassAccountTeamReassignRec>();
    public  MassAccountTeamReassignController(){
        existingTeamMember =  new AccountTeamMember();
        replacementTeamMember = new AccountTeamMember();
        remainingAccountsSelected = 0;
        ReassignActivites = true;
        ReassignOpportunities = true;
        CancelDoneLabel = 'Cancel';
        RowsSucceeded =0;
        RowsFailed =0;
        TotalExistingRows = 0;
        RowsLimit = 200;
        
    }
    public PageReference Refresh(){
            PageReference pageRef = step1();
            pageRef.setRedirect(true); 
            return pageRef;
    }
        Integer remainingAccountsSelected;
        public Integer getRemainingAccountsSelected()
        {return remainingAccountsSelected;}
        public void setRemainingAccountsSelected(Integer val){
            remainingAccountsSelected= val; 
        }
    
    
   public PageReference cancel() {
   
        return  Refresh();        
    }
    
    public String getUnprocessedMessage(){
        String reassignStatusMsg = '';
     Integer unProcessedcount = RemainingAccountsSelected; 
        if(unProcessedcount == selectedAccounts.size()){
            reassignStatusMsg ='';
        }
        else{
            reassignStatusMsg ='Remaining '+unProcessedcount+' items of '+selectedAccounts.size() +' accounts selected. Succeeded: '+RowsSucceeded+' Failed: '+RowsFailed;
        }
        system.debug('checking progress..:'+reassignStatusMsg );
        return reassignStatusMsg ;
    }
    
    public Integer getUnprocessedCount(){
    Integer unProcessedcount = 0;
    if(selectedAccounts != null && selectedAccounts.size() > 0){
    for(MassAccountTeamReassignRec rec: selectedAccounts){
            if(rec.ReassignResult.trim() == ''){
            unProcessedcount++;
             }             
    }
    }
      return unProcessedcount;
    }

        public String CancelDoneLabel{
        get;
        set{
            
            CancelDoneLabel= value; 
        }
    }   
    

   public PageReference validateStep2(){
       if(selectedAccounts == null || selectedAccounts.size()==0){
           return Refresh();
       }
       return null;
   }
   public List<MassAccountTeamReassignRec> getSearchAccountResults() {
    
        return searchAccountResults;
    }  
    
    public void setSearchAccountResults(List<MassAccountTeamReassignRec> searchlist ){
    
        searchAccountResults = searchlist;
    }  
        public Boolean ShowSearchResults
    {
        get 
        {
            if(searchAccountResults.size() > 0) {return true;}
            else {return false;}
        }
        set ;
    }
    
            public Boolean ShowMessages
    {
        get 
        {
            if(messages !=null && messages.trim()!= '') {return true;}
            else {return false;}
        }
        set ;
    }
              public Boolean ShowResultMessages
    {
        get 
        {
            if(resultmessages !=null && resultmessages.trim()!= '') {return true;}
            else {return false;}
        }
        set ;
    }
      
    
 public List<MassAccountTeamReassignRec> getSelectedAccounts() {
    
        return selectedAccounts ;
    }  
    public Boolean ShowSelectedAccounts
    {
        get 
        {
            if(selectedAccounts .size() > 0) {return true;}
            else {return false;}
        }
        set ;
    }

    private AccountTeamMember existingTeamMember;    
    
    public Boolean getIsSearchUserRoleSelected(){
        if(accountTeamRole == null || accountTeamRole.trim() == ''){
            return false;
        }
        else{
            return true;
        }
    }
    public AccountTeamMember getExistingTeamMember() {
    
        system.debug('getting existingTeamMember:' + existingTeamMember);
        return existingTeamMember;
    }
    
    public void setExistingTeamMember(AccountTeamMember acctTeam) {                  
        existingTeamMember = acctTeam;  
                system.debug('setting existingTeamMember:' + existingTeamMember);
      
    }  
    
    private AccountTeamMember replacementTeamMember = null;    
    public AccountTeamMember getReplacementTeamMember() {
     system.debug('getting replacementTeamMember:' + replacementTeamMember);
        return replacementTeamMember;
    }
    
    public void setReplacementTeamMember(AccountTeamMember acctTeam) {                  
        replacementTeamMember = acctTeam;       
       system.debug('setting replacementTeamMember :' + replacementTeamMember );
    }  
 
    
public List<SelectOption> getaccountTeamSearchRoleList() {
 List<SelectOption> options = new List<SelectOption>(); 
 options.add(new SelectOption('' ,'Select One')); 
  options.addAll(getExistingaccountTeamRoleList());
 return options ;
}

public List<SelectOption> getaccountTeamReplaceRoleList() {
 List<SelectOption> options = new List<SelectOption>(); 
   List<String> roles = new List<String>{
    'Use Role of Replaced Team Member',
    'Advertising Consultant - ATC',
    'Advertising Consultant - ATC Rover',
    'Co-op Specialist - ATC',
    'Implementation Consultant - TIM',
    'Inside Account Manager - ATC',
    'Inside Sales Consultant - ATC',
    'Mgr - Sales and Business Dev',
    'Performance Consultant',
    'Product Specialist - ATC',
    'Product Specialist - TIM',
    'Service Advisors (SA)',
    'Service Consultant (SC)'
    };  
    for(String role : roles){
        options.add(new SelectOption(role ,role )); 
        }
 return options ;
}

    
    public List<SelectOption> getExistingaccountTeamRoleList() {
    List<SelectOption> options = new List<SelectOption>();      

  Schema.DescribeFieldResult fieldResult =
 AccountTeamMember.TeamMemberRole.getDescribe();
   List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        
   for( Schema.PicklistEntry f : ple)
   {
      options.add(new SelectOption(f.getLabel(), f.getValue()));
   }           

        return options;
    }
    
    public MassAccountTeamReassignRec ReAssign(MassAccountTeamReassignRec rec){
        system.debug('ReAssign Start');
        Savepoint runSavepoint = Database.setSavepoint();
        try
        {
           User existingUser  = [Select Id, Name from User where Id=: getExistingTeamMember().UserId];
           User replacingUser = [Select Id, Name from User where Id=: getReplacementTeamMember().UserId];
           
           // TODO:: Remove this for deployment.
           /* Integer waitLoop = 5000000;
            while(waitLoop > 0){
            waitLoop--; 
            }*/
           
            rec.isSuccess =  AccountReassigment.Reassign(rec, existingUser  ,rec.TeamMemberRole , replacingUser,replaceAccountTeamRole,ReassignActivites, ReassignOpportunities);
             //TODO: Remove this for deployment.
             /*Integer i = (Integer)math.rint( math.random() * 100 );
             if(math.mod(i, 2) ==0) {rec.isSuccess = false;}*/
             rec.isProcessed  = true;
           if(rec.isSuccess){RowsSucceeded++;}else {RowsFailed++; }
        }
        catch(Exception ex)
        { 
          Database.RollBack(runSavepoint);        
          rec.ReassignResult =   rec.ReassignResult + '<br/>' + ex.getMessage();
          rec.ReassignResult =   rec.ReassignResult + '<br/>' + ex.getStackTraceString();
          System.Debug('rec.ReassignResult:'+rec.ReassignResult );
        }
        system.debug('ReAssign End');
        return rec;
    }
    
    public PageReference ReAssignNextRecord(){
        system.debug('ReAssignNextRecord Start');
        //get the First MassAccountTeamReassignRec 
        if(selectedAccounts!= null && selectedAccounts.size()> 0){
        MassAccountTeamReassignRec acctTeamReassignRec = selectedAccounts.Remove(0);   
        acctTeamReassignRec  = ReAssign(acctTeamReassignRec); 
        selectedAccounts.add(acctTeamReassignRec);
        Integer count = getRemainingAccountsSelected();
        count--;
        setRemainingAccountsSelected(count);        
        
        if(getRemainingAccountsSelected() == 0){
            DateTime dt = DateTime.now();
            String formattedDt = dt.format('MM-dd-yyyy hh:mm:ss');
            resultmessages =  resultmessages +  '\r\n'+  '\r\n'+ 'Proccess Complete, check results for more details.';   
            resultmessages =  resultmessages +  '\r\n'+ '    EndTime: '+ formattedDt; 
            resultmessages =  resultmessages +  '\r\n'+ '    Success:'+RowsSucceeded+' Failed:'+RowsFailed;
            
            CancelDoneLabel = 'Done';
        }
        }
        
        system.debug('ReAssignNextRecord End');
        return null;            
    }
    
   public PageReference ReassignAccountsSelected()
   {
       system.debug('ReassignAccountsSelected Start');
       messages  = '';
       
          if(getExistingTeamMember() == null || getExistingTeamMember().UserId == null){
            messages =  messages + ' * Existing TeamMember is required'+  '\r\n'+  '\r\n';         
            system.debug(messages );
            //return null;
          }
          //else{
          //system.debug('getExistingTeamMemberId is :'+ getExistingTeamMember().UserId);
          //}
       
          if(getreplacementTeamMember() == null || getreplacementTeamMember().UserId == null){
            messages =  messages + ' * Replacement TeamMember is required'+  '\r\n'+  '\r\n';
            system.debug(messages );
            //return null;
          }
          //else{
          //system.debug('getReplacementTeamMemberId is :'+ getReplacementTeamMember().UserId);
          //}
          
         //If both new and old user are same and even the roles are not changing
         //do not proceed.
         if(
           (getExistingTeamMember() != null 
           && getReplacementTeamMember() != null
           && getExistingTeamMember().UserId == getReplacementTeamMember().UserId) 
           && (
               (replaceAccountTeamRole.trim() == 'Use Role of Replaced Team Member') 
               || accountTeamRole.trim() ==  replaceAccountTeamRole.trim()  
              )
           ){
           messages =  messages + ' * Existing TeamMember, Replacement TeamMember and Role are same; Nothing to Reassign.'+  '\r\n'+  '\r\n';
            system.debug(messages);
           }
          
       system.debug('messages:' + messages);   
       if(messages.trim() == ''){
          //process 
          //first time
          if(getRemainingAccountsSelected()==0){  
            resultmessages ='';
            DateTime dt = DateTime.now();
            String formattedDt = dt.format('MM-dd-yyyy hh:mm:ss');
            resultmessages =  resultmessages +  '\r\n'+ '\r\n'+ 'Proccess Started, processing '+ selectedAccounts.size()+' accounts.';   
            resultmessages =  resultmessages +  '\r\n'+'    StartTime: '+ formattedDt; 
            setRemainingAccountsSelected(selectedAccounts.size());
          //set the progress indicator          
         SetProgressIndicator(); 
          
          }
          return ReAssignNextRecord(); 
       }
       else
       {
          setRemainingAccountsSelected(0);       
       }
      system.debug('ReassignAccountsSelected End');
      return null;
   }
   
   public void SetProgressIndicator(){
       for(MassAccountTeamReassignRec rec : selectedAccounts){
               
                   rec.ReassignResult = '<img src="/resource/1401918022000/loading16X16" height="15">'; 
                  
       }    
   }
   public PageReference SearchForAccountsToSelect()
   {
   
    RowsLimit =200;
    if(System.Label.MassAccountTeamReassignLimit != null && System.Label.MassAccountTeamReassignLimit !=''){
    try{
    RowsLimit = Integer.valueOf(System.Label.MassAccountTeamReassignLimit);
    }
    catch(Exception ex){
        system.debug( 'System.Label.MassAccountTeamReassignLimit is not an integer');
    }
    }
    
    searchAccountResults.clear();
         messages  = '';
     
          if(getExistingTeamMember() == null || getExistingTeamMember().UserId == null){
            messages =  messages + ' * Account TeamMember is required'+  '\r\n'+  '\r\n';         
            system.debug('Account TeamMember is null');
            //return null;
          }
          //else{
          //  system.debug('getExistingTeamMemberId is :'+ getExistingTeamMember().UserId);
          //}
            
        if(messages.trim() != ''){
         return null;
        }
    

       String firstName = '%' + teamMemberFirstName + '%';
       String lastName = '%' + teamMemberLastName + '%';
       if(accountTeamRole == null){ accountTeamRole = '';}
       String role = '%' + accountTeamRole.trim() + '%';
       

       List<aggregateResult> accountTeamMembersAggregate =  [SELECT count(Id) Total, userId FROM AccountTeamMember 
       WHERE UserId =:getExistingTeamMember().UserId
       AND TeamMemberRole like: role Group by userId];
       if(accountTeamMembersAggregate != null && accountTeamMembersAggregate.size()> 0){
       try{
       TotalExistingRows = Integer.valueOf(accountTeamMembersAggregate[0].get('Total'));       
       }
       catch(Exception ex){TotalExistingRows=0;}
       }
       else {
       TotalExistingRows =0;
       }

        
       List<AccountTeamMember> accountTeamMemberList = [SELECT Account.Name
       ,Account.ATC_Status__c
       //,Account.Region__c
       ,Account.SVOC_Region__c
       ,Account.SVOC_Id__c
       ,Account.ATC_Spend__c
       //,Account.District__c
       ,Account.SVOC_District__c
       ,Account.BillingState
       ,AccountId
       ,UserId
       ,User.Name
       ,User.FirstName
       ,User.LastName
       ,TeamMemberRole 
       FROM AccountTeamMember 
       where 
       //User.FirstName like:firstName AND User.LastName like:lastName 
       UserId =:getExistingTeamMember().UserId
       AND TeamMemberRole like: role LIMIT :RowsLimit ];
       
       if(accountTeamMemberList.size() ==0 ){
           system.debug('0 records found');
            messages =  messages + ' Search found 0 records.'+  '\r\n'+  '\r\n';           
          return null;
       }
      
       for(AccountTeamMember acctTeam: accountTeamMemberList){
           MassAccountTeamReassignRec rec = new MassAccountTeamReassignRec(acctTeam);
           searchAccountResults.add(rec);
       }
        system.debug(searchAccountResults.size()+' records loaded');      
       return null;
   }
   public PageReference step1() {
        return Page.MassAccountTeamReassignStep1;        
    }
    public PageReference step2() {
    
    selectedAccounts.clear();
    if(searchAccountResults.size() == 0){
           ApexPages.Message error= new ApexPages.Message(ApexPages.Severity.Error, 'Please search Accounts to Reassign');
           ApexPages.addMessage(error);
          return null;
    }
        for(MassAccountTeamReassignRec rec : searchAccountResults ){
            if(rec.isSelected){
            selectedAccounts.add(rec);
            }
        }
        
            if(selectedAccounts.size() == 0){
           ApexPages.Message error= new ApexPages.Message(ApexPages.Severity.Error, 'Please select Accounts to Reassign');
           ApexPages.addMessage(error);
          return null;
          }
          
        return Page.MassAccountTeamReassignStep2;
    }
    

    public String teamMemberLastName {
        get;
        set{
            teamMemberLastName = value; 
        }
    }
    public String teamMemberFirstName {
        get;
        set{
            
            teamMemberFirstName = value; 
        }
    }    
       
    public String accountTeamRole {
        get;
        set{
            
            accountTeamRole = value; 
        }
    }  
        public String replaceAccountTeamRole {
        get;
        set{
            replaceAccountTeamRole = value; 
        }
    }
    
    public String messages{
        get;
        set{
            
            messages = value; 
        }
    }  
      
    public String resultmessages {
        get;
        set{
            
            resultmessages = value; 
        }
    }   
    
        public Integer RowsSucceeded {
        get;
        set{
            
            RowsSucceeded = value; 
        }
        }
        public Integer RowsFailed {
        get;
        set{
            
            RowsFailed = value; 
        }
    }
    
    /**
    * Wrapper class
    */
    public class MassAccountTeamReassignRec {
        public String AccountLink {get; set;}
        public String AccountId {get; set;}
        public String AccountName {get; set;}
        public String ATCStatus {get; set;}
        public String Region {get; set;}
        public String SVOCId {get; set;}
        public Decimal ATCSpend {get; set;}
        public String District {get; set;}
        public String BillingState {get; set;}
        public String UserLink {get; set;}
        public String UserId {get; set;}
        public String UserName {get; set;}
        public String NewUserLink {get; set;}
        public String NewUserId {get; set;}
        public String NewUserName {get; set;}
        public String NewTeamMemberRole {get; set;}
        public String TeamMemberRole {get; set;}
        public Boolean isSelected {get; set;}
        public String ReassignResult {get; set;}
        public Boolean isSuccess {get; set;}
        public Boolean isProcessed{get; set;}
        public MassAccountTeamReassignRec(AccountTeamMember acctTeam) {
           this.AccountName = acctTeam.Account.Name;
           this.ATCStatus= acctTeam.Account.ATC_Status__c;
           //this.Region= acctTeam.Account.Region__c;
           this.Region = acctTeam.Account.SVOC_Region__c;
           this.SVOCId= acctTeam.Account.SVOC_Id__c;
           this.ATCSpend= acctTeam.Account.ATC_Spend__c;
           //this.District= acctTeam.Account.District__c;
           this.District= acctTeam.Account.SVOC_District__c;
           this.BillingState= acctTeam.Account.BillingState;
           this.TeamMemberRole = acctTeam.TeamMemberRole;
           this.UserId = acctTeam.UserId;
           this.UserName = acctTeam.User.Name;
           this.UserLink= (new ApexPages.StandardController(acctTeam.User)).view().getUrl();
           this.AccountId = acctTeam.AccountId;
           this.AccountLink= (new ApexPages.StandardController(acctTeam.Account)).view().getUrl();
           this.isSelected = false; 
           this.isSuccess = false;
           this.ReAssignResult  = '';
           this.isProcessed = false;
    }
    } 
    
}