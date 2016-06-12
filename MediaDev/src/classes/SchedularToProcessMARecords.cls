global class SchedularToProcessMARecords implements Schedulable{
 // Execute method
    global void execute(SchedulableContext SC) {
    Database.executeBatch(new BatchToProcessMARecords());
   }
 }