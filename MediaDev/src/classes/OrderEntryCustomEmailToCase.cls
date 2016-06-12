global class OrderEntryCustomEmailToCase implements Messaging.InboundEmailHandler 
{
    private String caseSubject = ''; 
    private String caseEmailSubject = '';
    private String caseEmailText = '';
    List<Account> acct;
    List<User> atcUser;
    
  global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email,
    Messaging.InboundEnvelope envelope) 
  {
    
    // The purpose of this class is to create an email service that will create order entry cases.
    // Order entry cases have a specific record type that must be set.
    // The account name will be passed in the subject line of the email.
    // The following fields will be passed into the subject line: SVOC number <space> ATC contact netID
    // Example subject line: 69338003 LKWEBB

    Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();

    Case orderEntryCase = new Case();
    // Max subject length is 255 and we want to add the Order Entry header to subject
    if (email.subject!=null)
    {
        if (email.subject.length() > 240)
            caseSubject = email.subject.abbreviate(240);
        else
            caseSubject = email.subject;
        //split the subject line by spaces up to look for netid or svoc id
        String partString = email.subject.replace('_',' '); //replace underscores with spaces to have a better chance at finding svoc id
        system.debug('partString:'+ partString);
        List<String> partsList = partString.split(' ',0);
        acct = [select Id, Name, SVOC_Id__c from Account where SVOC_Id__c in :partsList limit 1];
        if (!acct.isEmpty()) 
        {
            if (acct[0].SVOC_Id__c!=null)
            {
                orderEntryCase.AccountId = acct[0].Id;
                system.debug('====>found svoc:'+acct[0].Id);
            }
        } 
        system.debug('checking for netid:');
        atcUser =  [select Id, Net_ID__c from User where Net_ID__c in :partsList limit 1]; 
        if (!atcUser.isEmpty())
        {      
            if (atcUser[0].Net_ID__c != null)
            {
                 orderEntryCase.ATC_Contact__c = atcUser[0].Id;
                 System.debug('====> orderEntryCase.ATC_Contact__c:'+orderEntryCase.ATC_Contact__c);
            } 
        }  
                                
    }
    // Set case record type to Order Entry
    RecordType rt = [select Id, Name from RecordType where Name = 'ATG Order Entry' and SobjectType = 'Case' limit 1];
    orderEntryCase.RecordTypeId = rt.Id;
    orderEntryCase.priority = 'Low';
    orderEntryCase.subject = 'ORDER ENTRY: '+ caseSubject;
    if (email.plainTextBody != null)
    {
        if (email.plainTextBody.length()>32000)
            orderEntryCase.description = email.plainTextBody.abbreviate(32000);
        else
            orderEntryCase.description = email.plainTextBody;
    }

    orderEntryCase.origin = 'Fax';
    List <Group> queue = [select Id, Name from Group where Name = 'ESO Order Entry'and Type = 'Queue' limit 1];
    if (!queue.isEmpty())
        orderEntryCase.ownerId = queue[0].Id;
    orderEntryCase.Task_Type__c = 'Order Entry';   
    system.debug('====> owner:' + orderEntryCase.ownerId);
    insert orderEntryCase ;
    System.debug('====> Created case'+ orderEntryCase.Id );
    
    if (email.binaryAttachments != null && email.binaryAttachments.size() > 0) {
      for (integer i = 0 ; i < email.binaryAttachments.size() ; i++) {
        Attachment attachment = new Attachment();
        // attach to the newly created case record
        attachment.ParentId = orderEntryCase.Id;
        attachment.Name = email.binaryAttachments[i].filename;
        attachment.Body = email.binaryAttachments[i].body;
        system.debug('====>inserting attachment for case'+orderEntryCase.Id);
        insert attachment;
      }
    }
    
    EmailMessage[] newEmail = new EmailMessage[0];
    // check boundaries to match sfdc email
    if (email.subject!= null)   
    {
    
        if (email.subject.length()> EmailMessage.Subject.getDescribe().getLength())
            caseEmailSubject = caseSubject.abbreviate(EmailMessage.Subject.getDescribe().getLength());
        else
            caseEmailSubject = caseSubject;
    }
    else
        caseEmailSubject = null;
        
    // if body of email is html then convert to plain text by stripping tags    
        
    if (email.htmlBody != null)
    {
        caseEmailText = email.htmlBody.stripHtmlTags();
        if  (caseEmailText.length()> EmailMessage.TextBody.getDescribe().getLength())
            caseEmailText = caseEmailText.abbreviate(EmailMessage.TextBody.getDescribe().getLength());
    }
        
    if (email.plainTextBody!= null)   
    {
        if (email.plainTextBody.length()> EmailMessage.TextBody.getDescribe().getLength())
            caseEmailText = email.plainTextBody.abbreviate(EmailMessage.TextBody.getDescribe().getLength());
        else
            caseEmailText = email.plainTextBody;
    } 
    else
        caseEmailText = null;  
                        
    newEmail.add(new EmailMessage(FromAddress = email.fromAddress,
        FromName = email.fromName,
        ToAddress = email.toAddresses[0],
        Subject =  caseEmailSubject ,
        TextBody = caseEmailText,
        ParentId = orderEntryCase.Id));   // (newCase and newTask are the newly created case and task from earlier code)
 
    insert newEmail;

    return result;

  }

}