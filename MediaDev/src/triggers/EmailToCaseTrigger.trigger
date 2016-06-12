trigger EmailToCaseTrigger on EmailMessage (before insert) {
// B-20993 Requirements are to try and identify the account from email to case subject line
    List<Account> acct = new List<Account>();
    String partString;
    List<String> partsList;
    List<Case> casesToUpdate = new List<Case>();
    Case c1=new Case();
    for(EmailMessage em: trigger.new)
    {
    	system.debug('EMAIL MESSAGE TRIGGER Id is: '+ em.ParentId);
        //split the subject line by spaces up to look for svoc id 
        partString = em.subject.replace('_',' '); //replace underscores with spaces to have a better chance at finding svoc id
        system.debug('partString:'+ partString);
        partsList = partString.split(' ',0);
        acct = [select Id, Name, SVOC_Id__c from Account where SVOC_Id__c in :partsList limit 1];
        if (!acct.isEmpty()) 
        {
        	if (acct[0].SVOC_Id__c != null)
            {
            	c1.AccountId = acct[0].Id;
                c1.Id = em.ParentId;
                casesToUpdate.add(c1);
                system.debug('====>found svoc:'+acct[0].Id);
            }
        }         
	}
    if (!casesToUpdate.isEmpty())
    {
        update casesToUpdate;
    }   
    
}