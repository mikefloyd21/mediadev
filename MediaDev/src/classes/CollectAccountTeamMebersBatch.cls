global class CollectAccountTeamMebersBatch implements Database.Batchable<sObject>{
 
     global   DateTime jobStartDateTime; 
  global   DateTime lastRunDateTime;
    global  String Query;
   global CollectAccountTeamMebersBatch(){

   }

   global Database.QueryLocator start(Database.BatchableContext BC){
   
   jobStartDateTime =  System.now();
      //find the recent date from the custom setting into lastRunDateTime
     AccountTeamSyncSettings__c setting = AccountTeamSyncSettings__c.getOrgDefaults();
     
     //get the last time this job ran succesffully and use that datetime
     //if not use the current datetime
     if (setting == null) {
      lastRunDateTime=   jobStartDateTime;
     }
     else {
        if(setting.RecentChangesCollect__c != null){
      lastRunDateTime = setting.RecentChangesCollect__c;
        }
        else{
             lastRunDateTime=   jobStartDateTime;
        }
     }
     
     if(Query != null && Query.trim()!= '')
     {
         //this would be for test cases; use the suplied query;
     }
     else
     {
      Query = 'Select a.UserId, a.TeamMemberRole, a.LastModifiedDate, a.IsDeleted, a.Account.Id From AccountTeamMember a where a.LastModifiedDate >='+
       +lastRunDateTime.format('yyyy-MM-dd\'T\'hh:mm:ss\'Z\'') +
       ' and a.TeamMemberRole = '+
       '\'Advertising Consultant - ATC\'';
       }
   //create query
      return Database.getQueryLocator(Query);
   }

   global void execute(Database.BatchableContext BC, List<AccountTeamMember> scope){
   
      //query the AccountTeamMember objects by lastmodifieddate greater >= lastrunTime and if the role is of type "Advertising Consultant - ATC"
       List<AccountTeamMember_History__c> listToUpdate = new List<AccountTeamMember_History__c>();
       
     integer batchSize = 200;
       integer loopCount =0;
        for (AccountTeamMember  change : scope) {
              loopCount++;
               boolean isNew = true;
               
                    //update the record into AccountTeamMember_History__c 
                    //based on AccountId,UserId
                   for(AccountTeamMember_History__c historyRecord: [Select a.Id,a.Account__c,a.TeamMember__c,a.Role__c,a.IsDeleted__c,a.RecentChangeDate__c   from AccountTeamMember_History__c a where 
                   a.Account__c =: change.Account.Id  // applies to the same account                
                   AND a.TeamMember__r.id =: change.UserId   //same user
                   AND a.RecentChangeDate__c <=: change.LastModifiedDate //change is recent             
                   ]){
                     //change to the existing history object
                     //update the record
                     isNew = false;
                     historyRecord.Role__c = change.TeamMemberRole;
                     historyRecord.IsDeleted__c = change.IsDeleted;
                     historyRecord.RecentChangeDate__c = change.LastModifiedDate;
                     listToUpdate.add(historyRecord);
                    }
               
               if(isNew){
               //insert the record
               AccountTeamMember_History__c  newrec = new AccountTeamMember_History__c();
               newrec.Account__c = change.Account.Id;               
               newrec.TeamMember__c = change.UserId;   
               newrec.Role__c = change.TeamMemberRole;
               newrec.IsDeleted__c = change.IsDeleted;
               newrec.RecentChangeDate__c = change.LastModifiedDate;
               listToUpdate.add(newrec);               
               }
               
                     //update/insert if we reach batchsize
                if(loopCount  >= batchSize ){
                //save the lists
               upsert listToUpdate;
                
                //reset the 
                listToUpdate.clear();

                loopCount = 0;
                }
                
        }
        
      //Save the remaining or the records that did not get saved.
        
        //if the we never reached batch size store the remaining
        if(listToUpdate.Size() > 0){
        upsert listToUpdate;
        }
        
        //Now remove rows that got deleted
        //ClearDeletedMemberRoles();
    }
 
   global void finish(Database.BatchableContext BC){
   
      // Get the ID of the AsyncApexJob representing this batch job
   // from Database.BatchableContext.
   // Query the AsyncApexJob object to retrieve the current job's information.
   AsyncApexJob a = [SELECT Id, Status,ApexClass.Name, NumberOfErrors, JobItemsProcessed,
      TotalJobItems, CreatedBy.Email
      FROM AsyncApexJob WHERE Id =
      :BC.getJobId()];
      
      //if there are no errors
      //store the current setting the the last time job ram successfully.
      if(a.NumberOfErrors == 0){
       AccountTeamSyncSettings__c setting = AccountTeamSyncSettings__c.getOrgDefaults();
       
     
     if (setting == null) {
     setting  = new AccountTeamSyncSettings__c();
     System.debug('Initializing the AccountTeamSyncSettings__c');
     }
      System.debug('Exsiting setting.RecentChangesCollect__c:'+ setting.RecentChangesCollect__c);
     
     setting.RecentChangesCollect__c = jobStartDateTime;
     upsert setting;
     System.debug('Set RecentChangesCollect__c:'+ jobStartDateTime);
     }
     
       
   // Send an email to the Apex job's submitter notifying of job completion.
   Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
   String[] toAddresses = new String[] {a.CreatedBy.Email,'ramana.mosali@autotradergroup.com'};
   mail.setToAddresses(toAddresses);
   mail.setSubject(a.ApexClass.Name+ ' Batch: '  + a.Status);
   mail.setPlainTextBody
   ('The batch Apex job processed ' + a.TotalJobItems +
   ' batches with '+ a.NumberOfErrors + ' failures.');
   Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
   }
}