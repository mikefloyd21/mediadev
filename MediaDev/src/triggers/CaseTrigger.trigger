trigger CaseTrigger on Case (before insert, before update, after insert, after update) {
   if(trigger.isBefore)
   {
      if(trigger.isInsert)
      {
         CaseHandlerController.onBeforeInsert(trigger.new);
      } else if(trigger.isUpdate)
      {
         CaseHandlerController.onBeforeUpdate(trigger.new, trigger.oldMap);
      }
   } 
   else if(trigger.isAfter)
   {
      if(trigger.isInsert)
      {
         CaseHandlerController.onAfterInsert(trigger.new);
      } 
      else if(trigger.isUpdate)
      {
         CaseHandlerController.onAfterUpdate(trigger.new, trigger.oldMap);
      }
   }
}