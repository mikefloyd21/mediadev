global class EmailToCaseWithAttachments implements Messaging.InboundEmailHandler 
{
    private String caseSubject = null; 
    private String caseEmailSubject = null;
    private String caseEmailText = null;
    private List<Account> acct;
    private List<User> atcUser;
    private List<String> originList= new List<String>();
    private Integer i;
    private String toaddr2 = '';
    private String ccaddr = '';
    
    //Story B-10403 
    // Added toaddr & ccaddr to make sure we have all to and cc addresses into salesforce email attached to case
    // removed multiple setting of system case routing to one call at bottom
    // add a break to each if statement so that when we find a match we exit the for loop
    // removed catch all to ds emails in loop so we ensure we are setting to a correct queue
            
  global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email,
    Messaging.InboundEnvelope envelope) 
  {
    
    // The purpose of this class is to create an email service that will allow attachments.
    // The assignment should be based on the cae origin based on the email to address
    // This design assume nothing about what can come in email subject or body

    Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
    // Set case record type to DMD if it is from DMD rework, otherwise set to Dealer Service
    RecordType rtDmD = [select Id, Name from RecordType where Name = 'ATC DMD' and SobjectType = 'Case' limit 1];
    RecordType rtOE = [select Id, Name from RecordType where Name = 'ATG Order Entry' and SobjectType = 'Case' limit 1];
    RecordType rtDS = [select Id, Name from RecordType where Name = 'ATC Dealer Service' and SobjectType = 'Case' limit 1];    
    Case newCase = new Case();
    newCase.RecordTypeId = rtDS.Id; //default case record type to dealer service
    //Determine case origin here
    // add to and cc addresses to a list to find origin, it could be in either
    system.debug('TO:'+email.toAddresses);
    system.debug('CC:'+email.ccAddresses);
    system.debug('htmlbody:'+email.htmlBody);
    system.debug('textbody:'+email.plainTextBody);
    system.debug('message:'+email);
    if (email.toAddresses != null)
    {      
        for (i = 0; i < email.toAddresses.size(); i++) { // add to  addresses to a list to find origin
            originList.add(email.toAddresses[i]); //adds to bottom of list
            toaddr2 += email.toAddresses[i]+';';
        }
    }
    if (email.ccAddresses != null)
    {
        for (i = 0; i < email.ccAddresses.size(); i++) { // add cc addresses to a list to find origin
            originList.add(email.ccAddresses[i]); //adds to bottom of list
            ccaddr += email.ccAddresses[i]+';';
        }
    }
    system.debug('originlist'+originList);
    for (string toAddr: originList)  
    {
        system.debug('TOADDR:'+toAddr);
        if (toAddr.contains('atcancellationescalation'))
        {
            newCase.origin = 'CC Cancellation Escalations';
            newCase.priority = 'High';
            break; //added to ensure we use the first instance of a match
        }
        else if (toAddr.contains('atcancellation'))
        {
            newCase.origin = 'CC Cancellations'; 
            break; //added to ensure we use the first instance of a match            
        }     
        else if (toAddr.contains('inventorytechsupport'))
        {
            newCase.origin = 'INV Tech Support';
            break; //added to ensure we use the first instance of a match            
        }
        else if (toAddr.contains('contractescalation'))
        {
            newCase.origin = 'DS Seniors Contract Escalations';
            break; //added to ensure we use the first instance of a match            
        }
        else if (toAddr.contains('dealersupportemails'))
        {
            newCase.origin = 'DS Emails';
            break; //added to ensure we use the first instance of a match
        }
        else if (toAddr.contains('dealbuildersupport')||toAddr.contains('dt-provisioning'))
        {
            newCase.origin = 'ESO Deal Builder Order Entry';
            break; //added to ensure we use the first instance of a match            
        }
        else if (toAddr.contains('megamajoraccountssupport'))
        {
            newCase.origin = 'SA Mega Major Accounts';
            break; //added to ensure we use the first instance of a match            
        }
        else if (toAddr.contains('at-majoraccountssupport'))
        {
            newCase.origin = 'SA Major Accounts';
            break; //added to ensure we use the first instance of a match            
        }         
        else if (toAddr.contains('kbbshowcasereworks'))
        {
            newCase.origin = 'KBB Showcase Reworks';
            break; //added to ensure we use the first instance of a match            
        }
        else if (toAddr.contains('timsalesorders'))
        {    
            newCase.origin = 'ESO TIM Order Entry';
            newCase.RecordTypeId = rtOE.Id;    //set case record type to ATG Order Entry
            break; //added to ensure we use the first instance of a match            
        }    
        else if (toAddr.contains('dmdmajoraccountseqs'))
        {
            newCase.origin = 'DMD Major Reworks';
            newCase.RecordTypeId = rtDmD.Id;    //set case record type to ATC DMD
            break; //added to ensure we use the first instance of a match            
        }
        else if (toAddr.contains('fastads.custops')||toAddr.contains('fastadscustomer'))
        {
            newCase.origin = 'SA Fast Ads';
            break; //added to ensure we use the first instance of a match            
        }
        else if (toAddr.contains('bhphsupportemails'))
        {
            newCase.origin = 'SA BHPH';
            break; //added to ensure we use the first instance of a match            
        }
        else if (toAddr.contains('hibernationrequest'))
        {
            newCase.origin = 'CC Hibernation Request';
            break; //added to ensure we use the first instance of a match            
        }    
        else if (toAddr.contains('accountrequest'))
        {
            newCase.origin = 'CDG Customer Create';
            break; //added to ensure we use the first instance of a match            
        }    
        else if (toAddr.contains('dataqualitygroup'))
        {
            newCase.origin = 'INV DQA';
            break; //added to ensure we use the first instance of a match            
        }
        else if (toAddr.contains('kbbsupport'))
        {
            newCase.origin = 'KBB Support';
            break; //added to ensure we use the first instance of a match            
        }
        else if (toAddr.contains('cccseniorqueue'))
        {
            newCase.origin = 'CC Seniors';
            break; //added to ensure we use the first instance of a match            
        }
        else if (toAddr.contains('dealergroupsupport'))
        {
            newCase.origin = 'SA Dealer Group';
            break; //added to ensure we use the first instance of a match
        }
        else if (toAddr.contains('coop'))
        {
            newCase.origin = 'Co-Op';
            break; //added to ensure we use the first instance of a match            
        }
        else if (toAddr.contains('dstroubleshooters'))
        {
            newCase.origin = 'SA Troubleshooters';
            break; //added to ensure we use the first instance of a match            
        }
        else if (toAddr.contains('corporateaffairs'))
        {
            newCase.origin = 'Corporate Affairs';
            break; //added to ensure we use the first instance of a match            
        }    
        else if (toAddr.contains('corereworks'))
        {
            newCase.origin = 'DMD Rework'; 
            newCase.RecordTypeId = rtDmD.Id;    //set case record type to dmd
            break; //added to ensure we use the first instance of a match            
        }
        else if (toAddr.contains('info')) //US Defect D-03668 
        {
            newCase.origin = 'DS Emails';
            break; //added to ensure we use the first instance of a match            
        }
        //removed catch all to ds emails because there can be more than one in list        
    }
    // since origin and system case routing are supposed to match just set it to origin here.
    newCase.System_Case_Routing__c = newCase.origin;
    if (email.subject != null)
    {

        caseSubject = email.subject; //should never be over 255.
        //split the subject line by spaces up to look for svoc id 
        String partString = email.subject.replace('_',' '); //replace underscores with spaces to have a better chance at finding svoc id
        system.debug('partString:'+ partString);
        List<String> partsList = partString.split(' ',0);
        acct = [select Id, Name, SVOC_Id__c from Account where SVOC_Id__c in :partsList limit 1];
        if (!acct.isEmpty()) 
        {
            if (acct[0].SVOC_Id__c != null)
            {
                newCase.AccountId = acct[0].Id;
                system.debug('====>found svoc:'+acct[0].Id);
            }
        } 
                                
    }

    newCase.subject =  caseSubject;
    
    if (String.isNotEmpty(email.plainTextBody))
    {
        if (email.plainTextBody.length()> EmailMessage.TextBody.getDescribe().getLength())
            newCase.description = email.plainTextBody.abbreviate(EmailMessage.TextBody.getDescribe().getLength());
        else
            newCase.description = email.plainTextBody;
        caseEmailText = newCase.description;
    }
    if (String.isNotEmpty(email.htmlBody))
    {
        caseEmailText = email.htmlBody.stripHtmlTags();
        if  (caseEmailText.length()> EmailMessage.TextBody.getDescribe().getLength())
            caseEmailText = caseEmailText.abbreviate(EmailMessage.TextBody.getDescribe().getLength());
        newCase.description = caseEmailText;
    } 

    system.debug('====> owner:' + newCase.ownerId);
    //set up so that case assignment rules run.
    Database.DMLOptions dmo = new Database.DMLOptions();
    dmo.assignmentRuleHeader.useDefaultRule = true;
    newCase.setOptions(dmo);    
    insert newCase ;
    System.debug('====> Created case'+ newCase.Id );
    
    if (email.binaryAttachments != null && email.binaryAttachments.size() > 0) {
      for (integer i = 0 ; i < email.binaryAttachments.size() ; i++) {
        Attachment attachment = new Attachment();
        // attach to the newly created case record
        attachment.ParentId = newCase.Id;
        attachment.Name = email.binaryAttachments[i].filename;
        attachment.Body = email.binaryAttachments[i].body;
        system.debug('====>inserting attachment for case'+newCase.Id);
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

        
    // if body of email is html then convert to plain text by stripping tags    
        
                        
    newEmail.add(new EmailMessage(FromAddress = email.fromAddress,
        FromName = email.fromName,
        ToAddress = toaddr2,
        Subject =  caseEmailSubject ,
        TextBody = caseEmailText,
        Incoming = true,        
        CcAddress = ccaddr,
        ParentId = newCase.Id));   // (newCase is the newly created case from earlier code)
 
    insert newEmail;
    System.debug('====> EMAILTOCASE:Created case with attachments'+ newCase);
    System.debug('====> EMAILTOCASE:Email attached'+ newEmail);

    return result;

  }

}