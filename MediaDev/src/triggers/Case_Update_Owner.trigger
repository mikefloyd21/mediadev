trigger Case_Update_Owner on Case (before insert, before update) {
  for(Case c : trigger.new)
  {
    if (c.ATC_Co_op__c == 'Yes' && c.ATC_Rework_Approval_Status__c == 'Rejected' && c.Status == 'QA Complete' )
    {
        system.debug('CreatedByOwner:'+ c.CreatedById);
        system.debug('Previous_Owner:'+ c.Previous_Owner__c);
        if (c.Previous_Owner__c != null)
            c.OwnerId = c.Previous_Owner__c;
        else
            c.OwnerId = c.CreatedById;
    }
    if (c.Status == 'Design Complete')
    {
        c.Previous_Owner__c = UserInfo.getUserId();
    }
  }
}