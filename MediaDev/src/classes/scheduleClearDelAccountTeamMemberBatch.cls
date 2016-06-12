global  class scheduleClearDelAccountTeamMemberBatch  implements Schedulable{
    
    
     global static List<String> scheduleMe15Min() {
      List<String> jobIds = new List<String>();
       String jobId = System.schedule('ClearDeletedAccountTeamMemberBatchJob0', '0 0 * * * ?', new scheduleClearDelAccountTeamMemberBatch());
       jobIds.add(jobId);
       jobId = System.schedule('ClearDeletedAccountTeamMemberBatchJob15', '0 15 * * * ?', new scheduleClearDelAccountTeamMemberBatch());
              jobIds.add(jobId);
        jobId =  System.schedule('ClearDeletedAccountTeamMemberBatchJob30', '0 30 * * * ?', new scheduleClearDelAccountTeamMemberBatch());
               jobIds.add(jobId);
        jobId = System.schedule('ClearDeletedAccountTeamMemberBatchJob45', '0 45 * * * ?', new scheduleClearDelAccountTeamMemberBatch());  
               jobIds.add(jobId);
               return jobIds;
    }
    
public  ClearDeletedAccountTeamMembersBatch clearAccountTeamChanges;
 global void execute(SchedulableContext sc) {
if(clearAccountTeamChanges== null){
clearAccountTeamChanges= new ClearDeletedAccountTeamMembersBatch();
}

      database.executebatch(clearAccountTeamChanges);
   }
}