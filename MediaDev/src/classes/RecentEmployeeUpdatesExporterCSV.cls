global class RecentEmployeeUpdatesExporterCSV implements System.Schedulable {

   
   
    public string toTestEmail{get; set;}
    
         global static List<String> scheduleMe15Min() {
         List<String> jobIds = new  List<String>();
         String jobId = '';
       jobId  = System.schedule('RecentEmployeeUpdatesExporterCSV0', '0 0 * * * ?', new RecentEmployeeUpdatesExporterCSV());
       jobIds.add(jobId);
        jobId  = System.schedule('RecentEmployeeUpdatesExporterCSV15', '0 15 * * * ?', new RecentEmployeeUpdatesExporterCSV());
          jobIds.add(jobId);
       jobId  =  System.schedule('RecentEmployeeUpdatesExporterCSV30', '0 30 * * * ?', new RecentEmployeeUpdatesExporterCSV());
         jobIds.add(jobId);
        jobId  = System.schedule('RecentEmployeeUpdatesExporterCSV45', '0 45 * * * ?', new RecentEmployeeUpdatesExporterCSV());  
          jobIds.add(jobId);
          
          return jobIds;
    }
    
    
global void execute(SchedulableContext sc) {
       DateTime jobStartDateTime; 
   DateTime lastRunDateTime;
jobStartDateTime =  System.now();

//get the custom settings

AccountTeamSyncSettings__c setting = AccountTeamSyncSettings__c.getOrgDefaults();
if (setting == null) {
      throw new ATGException('Could not find EmployeeAssignmentService__c Org CustomSetting');
     }
     else {
         system.debug('setting.AccountUpdateCCEmail__c:'+setting.AccountUpdateCCEmail__c);
          system.debug('setting.AccountUpdateToEmail__c:'+setting.AccountUpdateToEmail__c);
}
if(setting.AccountUpdateToEmail__c == null)
{
    throw new ATGException('Could not find the setting AccountUpdateToEmail__c  in AccountTeamSyncSettings__c ');
}

  //find the recent date from the custom setting into lastRunDateTime
     
     //get the last time this job ran succesffully and use that datetime
     //if not use the current datetime
     if (setting == null) {
      lastRunDateTime=   jobStartDateTime;
     }
     else {
        if(setting.RecentExportSent__c != null){
      lastRunDateTime = setting.RecentExportSent__c;
        }
        else{
             lastRunDateTime=   jobStartDateTime;
        }
     }
   

//List<AccountTeamMember_History__c> acclist = [Select  a.Account__r.Name,a.Role__c,a.TeamMember__r.Name,a.Account__r.SVOC_Id__c, a.TeamMember__r.FederationIdentifier From AccountTeamMember_History__c a where a.NeedToSync__c = true];

//List<AccountTeamMember> acclist = [Select a.User.FederationIdentifier, a.User.Name, a.UserId, a.TeamMemberRole, a.Account.SVOC_Id__c, a.Account.Name, a.AccountId From AccountTeamMember a
//where a.LastModifiedDate >: lastRunDateTime
//and a.TeamMemberRole = 'Advertising Consultant - ATC'];



string header = 'Account Name,Role Name,User Name,Owner ID,Worker ID,Role\n';
string finalstr = header ;
//for(AccountTeamMember_History__c a: acclist)
//{
//   string recordString = a.Account__r.Name+','+a.Role__c+','+a.TeamMember__r.Name+','+a.Account__r.SVOC_Id__c+ ',' + a.TeamMember__r.FederationIdentifier + ',' + 'PSR' + '\n';
//   finalstr = finalstr + recordString;
//}

//for(AccountTeamMember a: acclist)

//Add/modify code for Story B-16364 LG
List<String> validRoles = new  List<String>();
validRoles.add('Advertising Consultant - ATC');
validRoles.add('Inside Sales Consultant - ATC');
validRoles.add('Inside Account Manager - ATC');
validRoles.add('Performance Consultant');
validRoles.add('Mgr - Sales and Business Dev');
String colName;    

for(AccountTeamMember a: [Select a.User.FederationIdentifier, a.User.Name, a.UserId, a.TeamMemberRole, a.Account.SVOC_Id__c, a.Account.Name, a.AccountId From AccountTeamMember a
where a.LastModifiedDate >: lastRunDateTime
and a.TeamMemberRole in :validRoles])
{
   if (a.TeamMemberRole == 'Mgr - Sales and Business Dev')
       colName = 'MAE';
   else
       colName = 'PSR';
   string recordString = '"'+a.Account.Name+'","'+a.TeamMemberRole+'","'+a.User.Name+'","'+a.Account.SVOC_Id__c+ '","' + a.User.FederationIdentifier + '","' + colName + '"\n';
   system.debug('RECORDSTRING:'+recordString);
   finalstr = finalstr + recordString;
}





String[] toAddresses;
//this is test with different emails
//with invalid as well
if(toTestEmail != null)
{
toAddresses = toTestEmail.split(',');
}
else{
toAddresses = setting.AccountUpdateToEmail__c.split(',');
}

if(setting.AccountUpdateCCEmail__c == null)
{
    throw new ATGException('Could not find the setting AccountUpdateCCEmail__c in AccountTeamSyncSettings__c ');
}
String[] ccAddresses = setting.AccountUpdateCCEmail__c.split(',');

try{
Messaging.EmailFileAttachment csvAttc = new Messaging.EmailFileAttachment();
blob csvBlob = Blob.valueOf(finalstr);
string csvname= 'export.csv';
csvAttc.setFileName(csvname);
csvAttc.setBody(csvBlob);
Messaging.SingleEmailMessage email =new Messaging.SingleEmailMessage();

String subject = 'Recently Updated EmployeeAssignments Report CSV';
email.setSubject(subject);
email.setToAddresses( toAddresses );
email.setCcAddresses( ccAddresses );
email.setPlainTextBody('The Recently Updated EmployeeAssignments report is attached here.');
email.setFileAttachments(new Messaging.EmailFileAttachment[]{csvAttc});
Messaging.SendEmailResult [] results = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});

//update the accounts as synched
if (!results.get(0).isSuccess()) {
    //error
    System.StatusCode statusCode = results.get(0).getErrors()[0].getStatusCode();
    String errorMessage = results.get(0).getErrors()[0].getMessage();
    //Error
    //Update the records as synched.
    //for(AccountTeamMember_History__c a: acclist)
    //{
    //    a.IsRecentSyncSucceed__c = false;
    //    a.RecentSVOCSyncMessage__c = 'Failed: Error Sending Email Sent to: '+setting.AccountUpdateToEmail__c +' and cc: '+setting.AccountUpdateCCEmail__c +' ErrorCode: '+statusCode+' ErrorMessage: '+errorMessage;        
    //    a.RecentSVOCSync__c = datetime.now(); 
    //}
    
    //update acclist;
    
         setting.RecentExportSentMessage__c =  ' ErrorCode:'+statusCode + ';ErrorMessage:'+errorMessage;
         upsert setting;

}
else
{
    //Success
    //Update the records as synched.
    //for(AccountTeamMember_History__c a: acclist)
    //{
    //    a.IsRecentSyncSucceed__c = true;
    //    a.RecentSVOCSyncMessage__c = 'Success: Email Sent to: '+setting.AccountUpdateToEmail__c +' and cc: '+setting.AccountUpdateCCEmail__c;        
    //    a.RecentSVOCSync__c = datetime.now(); 
    //}
    
    //update acclist;
    
    setting.RecentExportSent__c = jobStartDateTime;
    setting.RecentExportSentMessage__c = 'Success';
    upsert setting;
}
}
catch (Exception ex)
{
    String getMessage= ex.getMessage();
    String getStackTraceString= ex.getStackTraceString();
     String getTypeName =  ex.getTypeName();
    //Error
    //Update the records as synched.
    //for(AccountTeamMember_History__c a: acclist)
    //{
    //    a.IsRecentSyncSucceed__c = false;
    //    a.RecentSVOCSyncMessage__c = 'Failed: Error Sending Email Sent to: '+setting.AccountUpdateToEmail__c +' and cc: '+setting.AccountUpdateCCEmail__c;
        //a.RecentSVOCSyncMessage__c = 'Failed: Error Sending Email Sent to: '+setting.AccountUpdateToEmail__c +' and cc: '+setting.AccountUpdateCCEmail__c +' Error Message: '+getMessage+' ;TypeName : '+getTypeName ;        
        //a.RecentSVOCSyncMessage__c = 'Error';
    //    a.RecentSVOCSync__c = datetime.now(); 
    //}
    
    //update acclist;
    
            setting.RecentExportSentMessage__c =  ' ErrorType:'+getTypeName + ';ErrorMessage:'+getMessage; 

         upsert setting;
}

  }
}