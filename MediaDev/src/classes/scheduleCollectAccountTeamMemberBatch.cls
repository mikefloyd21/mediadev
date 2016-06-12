global  class scheduleCollectAccountTeamMemberBatch  implements Schedulable{
    
    
     global static List<String> scheduleMe15Min() {
      List<String> jobIds = new List<String>();
       String jobId = System.schedule('CollectAccountTeamMemberBatchJob0', '0 0 * * * ?', new scheduleCollectAccountTeamMemberBatch());
       jobIds.add(jobId);
       jobId = System.schedule('CollectAccountTeamMemberBatchJob15', '0 15 * * * ?', new scheduleCollectAccountTeamMemberBatch());
              jobIds.add(jobId);
        jobId =  System.schedule('CollectAccountTeamMemberBatchJob30', '0 30 * * * ?', new scheduleCollectAccountTeamMemberBatch());
               jobIds.add(jobId);
        jobId = System.schedule('CollectAccountTeamMemberBatchJob45', '0 45 * * * ?', new scheduleCollectAccountTeamMemberBatch());  
               jobIds.add(jobId);
               return jobIds;
    }
    
public  CollectAccountTeamMebersBatch  collectAccountTeamChanges;
 global void execute(SchedulableContext sc) {
if(collectAccountTeamChanges == null){
collectAccountTeamChanges = new CollectAccountTeamMebersBatch();
}

      database.executebatch(collectAccountTeamChanges);
   }
}