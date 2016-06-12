trigger EventUpdate on Event (after update) {
     Set<Id> whatIds = new Set<Id>{};
     Set<Id> ownerIds = new Set<Id>{};
     system.debug('in evennt update trigger');
     For(Event e : trigger.new)
      {
          system.debug(e.Type);
          ownerIds.add(e.OwnerId);
          User owner = [Select Id, Name from User where Id in :ownerIds LIMIT 1];
          system.debug(owner.name);
          if (e.Type == 'In Person Visit' && e.AccountId != null && e.Meeting_Status__c == 'Completed' )
          {

               whatIds.add(e.AccountId);
               For (Account a : [Select Id, Current_AC__c, Last_In_Person__c from Account where Id in :whatIDs])
               {
                   If (a.Current_AC__c == owner.Name && (a.Last_In_Person__c < system.TODAY() || a.Last_In_Person__c == null ) )
                   {
                       a.Last_In_Person__c = system.TODAY();
                       update a;
                   }

               }
                       
          }
      }

}