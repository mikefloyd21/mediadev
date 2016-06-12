trigger ProductConfigurationTrigger on Product_Configuration__c(before insert) {
    if (Trigger.isBefore) {
        if (Trigger.isInsert) {
            ProductConfigurationTriggerClass.beforeInsert(trigger.new);
        }
    }
}