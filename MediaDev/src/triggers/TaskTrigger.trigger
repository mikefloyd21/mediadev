trigger TaskTrigger on Task (after insert, after update, before insert, 
before update) {
   if(trigger.isBefore)
   {
      if(trigger.isInsert)
      {
         TaskHandlerController.onBeforeInsert(trigger.new);      
      }
      else if(trigger.isUpdate)
      {
         TaskHandlerController.onBeforeUpdate(trigger.new, trigger.oldMap);      
      }
   }
   else if(trigger.isAfter)
   {
      if(trigger.isInsert)
      {
         TaskHandlerController.onAfterInsert(trigger.new);      
      
      }
      else if(trigger.isUpdate)
      {
      
         TaskHandlerController.onAfterUpdate(trigger.new, trigger.oldMap);      
      }
   
   }                

}