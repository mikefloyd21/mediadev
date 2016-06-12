trigger ContractTrigger on Contract (before insert, after insert, before update, after update) {
   if(trigger.isBefore)
   {
      if(trigger.isInsert)
      {
         ContractHandlerController.onBeforeInsert(trigger.new);      
      }
      else if(trigger.isUpdate)
      {
         ContractHandlerController.onBeforeUpdate(trigger.new, trigger.oldMap);      
      }
   }
   else if(trigger.isAfter)
   {
      if(trigger.isInsert)
      {
         ContractHandlerController.onAfterInsert(trigger.new);      
      
      }
      else if(trigger.isUpdate)
      {
      
         ContractHandlerController.onAfterUpdate(trigger.new, trigger.oldMap);      
      }
   
   }            
}