trigger CaseUpdateParentCaseNew on Case (after insert) 
{
  for(Case c : trigger.new)
  {
    system.debug('LYNN:parent:'+c.Parent.CaseNumber);
    system.debug('LYNN:case number'+c.CaseNumber);

    if (c.ParentId != null)
    {
        /* update parent status */
        Case parentCase = new Case();
        parentCase.Id = c.ParentId;
        parentCase.Status = 'Awaiting Internal';
        parentCase.ATC_One_and_Done__c = 'No';
        parentCase.HasChildCases__c = true;
        system.debug('LYNN:added parent to update');
        // Update Parent Case
        update parentCase;

    }

                
  }
}