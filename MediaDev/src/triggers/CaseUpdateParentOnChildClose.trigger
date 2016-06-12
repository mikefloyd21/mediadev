trigger CaseUpdateParentOnChildClose on Case (before update, after update) {
Set<Id> parentCaseId = new Set<Id>();
  for(Case c : trigger.new)
  {
    system.debug('LYNN:parent case number:'+c.Parent.CaseNumber);
    system.debug('LYNN:case number'+c.CaseNumber);
      
    if (Trigger.isAfter && c.ParentId != null && c.Status == 'Closed')
    {           
        /* update parent status */
        Case parentCase = new Case();
        parentCase.Id = c.ParentId;
        
        parentCase.ATC_One_and_Done__c = 'No';      
        parentCaseId.add(c.ParentId);
        Case existingParent = [select Id,Priority, Status From Case  Where Id in :parentCaseId LIMIT 1];
        if (existingParent.Priority != 'High')
            parentCase.Priority = 'Medium';

        parentCase.Status = 'Work In Progress';          
            // if status is awaiting internal then workflow will change priority
            
        // Update Parent Case
        update parentCase;
        
    }
  }
}