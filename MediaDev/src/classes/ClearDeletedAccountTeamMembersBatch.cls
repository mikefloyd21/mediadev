global class ClearDeletedAccountTeamMembersBatch implements Database.Batchable<sObject>{
 
    global  String Query;
   global ClearDeletedAccountTeamMembersBatch(){

      Query = 'Select a.TeamMember__c, a.Role__c, a.RecentSVOCSync__c, a.RecentSVOCSyncMessage__c, a.RecentChangeDate__c, a.NeedToSync__c, a.Name, a.IsRecentSyncSucceed__c, a.Account__c From AccountTeamMember_History__c a';
   }

   global Database.QueryLocator start(Database.BatchableContext BC){
   
   //create query
      return Database.getQueryLocator(Query);
   }

   global void execute(Database.BatchableContext BC, List<AccountTeamMember_History__c> scope){
   
     integer batchSize = 100;
     integer loopCount =0;
      List<AccountTeamMember_History__c> deletedRecords = new List<AccountTeamMember_History__c>();
     for(AccountTeamMember_History__c historyRecord: scope){
     //foreach history record check if the user exists as a team member for that account no matter what role he might be in
     Boolean isExists = false;
     loopCount ++;    
      List<AccountTeamMember>  memberRole = [Select a.UserId, a.TeamMemberRole, a.LastModifiedDate, a.IsDeleted, a.Account.Id From AccountTeamMember a
        where a.Account.Id =: historyRecord.Account__c  AND a.UserId =: historyRecord.TeamMember__c];
        if (memberRole  != null && memberRole.size() > 0)
         {
            // Still exists
            isExists  = true;
        }
        
        if(!isExists){
        deletedRecords.add(historyRecord);
        }
        
        //delete the reocrds if reaches the batchLimit
        if(loopCount  >= batchSize ){
        delete deletedRecords;
        //reset
        loopCount =0;
        deletedRecords.Clear();
        }
     
     }
     
     //delete the remaining records
     if(deletedRecords.Size()>0){
     delete deletedRecords;
     }
     

    }
 
   global void finish(Database.BatchableContext BC){
   
      // Get the ID of the AsyncApexJob representing this batch job
   // from Database.BatchableContext.
   // Query the AsyncApexJob object to retrieve the current job's information.
   AsyncApexJob a = [SELECT Id, Status,ApexClass.Name, NumberOfErrors, JobItemsProcessed,
      TotalJobItems, CreatedBy.Email
      FROM AsyncApexJob WHERE Id =
      :BC.getJobId()];
      

     
       
   // Send an email to the Apex job's submitter notifying of job completion.
   Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
   String[] toAddresses = new String[] {a.CreatedBy.Email,'ramana.mosali@autotradergroup.com'};
   mail.setToAddresses(toAddresses);
   mail.setSubject(a.ApexClass.Name+ ' Batch: ' + a.Status);
   mail.setPlainTextBody
   ('The batch Apex job processed ' + a.TotalJobItems +
   ' batches with '+ a.NumberOfErrors + ' failures.');
   Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
   }
}