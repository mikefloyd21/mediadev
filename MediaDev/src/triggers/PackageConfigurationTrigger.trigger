trigger PackageConfigurationTrigger on Package_Configuration__c (before insert, before update, 
                                                after insert, after update, 
                                                after delete) {
    if(Trigger.isAfter) {
        if(Trigger.isDelete){
            PackageConfigurationTriggerClass.findCoOpRecords(trigger.old);
        }    
        else{
            PackageConfigurationTriggerClass.findCoOpRecords(trigger.new);
        }
    }
}