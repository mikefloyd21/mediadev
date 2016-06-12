trigger OrderTrigger on Order (before update, after update) {
     if(trigger.isAfter){
        if(trigger.isUpdate){
            OrderTriggerClass.afterUpdate(trigger.oldMap, trigger.newMap);
        } 
     }
}