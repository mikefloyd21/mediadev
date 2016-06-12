@isTest(SeeAllData=true)
public class TestEmailToCaseWithAttachments{
    private static final Id caseRecordTypeAcct = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Major Account').getRecordTypeId();

  static testMethod void TestinBoundEmailCancellationEscalation()
   {
      // create a new email and envelope object
      Messaging.InboundEmail email = new Messaging.InboundEmail() ;
      Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
         Account accAux         = new Account(Name = 'TestAccount',ShippingStreet= '1 Main St.', 
                                            ShippingState    = 'VA',
                                            ShippingPostalCode  = '12345',
                                            ShippingCountry    = 'USA',
                                            ShippingCity      = 'Anytown',
                                            Description      = 'This is a test account',
                                            BillingStreet    = '1 Main St.',
                                            BillingState      = 'VA',
                                            BillingPostalCode  = '12345',
                                            BillingCountry     = 'USA',
                                            BillingCity      = 'Anytown',
                                            AnnualRevenue    = 10000,
                                            ParentId        = null,
                                            RecordTypeId = caseRecordTypeAcct,
                                            SVOC_Id__c = '111111');

        insert accAux;       
        
       // setup the data for the email
       // testing cancellation escalation
      email.subject = 'Test 111111';
      email.fromAddress = 'someaddress@email.com';
      email.plainTextBody = 'Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff ';
      email.fromName = 'Test Name';
      email.toAddresses = new String[] {'Jon Smith <someaddress@email.com>'};
      email.ccAddresses = new String[] {'atcancellationescalation@email.com>'};

       
      // add an Binary attachment
      Messaging.InboundEmail.BinaryAttachment attachment = new Messaging.InboundEmail.BinaryAttachment();
      attachment.body = blob.valueOf('my attachment text');
      attachment.fileName = 'textfileone.txt';
      attachment.mimeTypeSubType = 'text/plain';
      email.binaryAttachments = new Messaging.inboundEmail.BinaryAttachment[] { attachment };
       
   
      // add an Text attachment

      Messaging.InboundEmail.TextAttachment attachmenttext = new Messaging.InboundEmail.TextAttachment();
      attachmenttext.body = 'my attachment text';
      attachmenttext.fileName = 'textfiletwo3.txt';
      attachmenttext.mimeTypeSubType = 'texttwo/plain';
      email.textAttachments =   new Messaging.inboundEmail.TextAttachment[] { attachmenttext };

      // call the email service class and test it with the data in the testMethod
      EmailToCaseWithAttachments testInbound=new EmailToCaseWithAttachments();
      testInbound.handleInboundEmail(email, env);
      
       // setup the data for the email error path, should create case with no account or contact.
      email.subject = '';
      email.fromAddress = 'someaddress@email.com';
      email.plainTextBody = 'Fax received (5p) from: Dealer Skyline Motorsports - Dlr ID:69338003 FAX ID:714 760 4462';
      email.fromName = 'Test Name';
      email.toAddresses = new String[] {'Jon Smith <someaddress@email.com>'};
      email.htmlBody= 'Fax received (5p) from: Dealer Skyline Motorsports - Dlr ID:69338003 FAX ID:714 760 4462';
      // call the email service class and test it with the data in the testMethod
      EmailToCaseWithAttachments testInbound2=new EmailToCaseWithAttachments ();
      //testInbound2.handleInboundEmail(email, env);
   }
  static testMethod void TestinBoundEmailCancellation()
   {
      // create a new email and envelope object
      Messaging.InboundEmail email = new Messaging.InboundEmail() ;
      Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
        
       // setup the data for the email
       // testing cancellation
      email.subject = 'Test';
      email.fromAddress = 'someaddress@email.com';
      email.plainTextBody = 'Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff ';
      email.fromName = 'Test Name';
      email.ccAddresses = new String[] {'Jon Smith <someaddress@email.com>'};
      email.toAddresses = new String[] {'atcancellation@email.com'};

       
      // add an Binary attachment
      Messaging.InboundEmail.BinaryAttachment attachment = new Messaging.InboundEmail.BinaryAttachment();
      attachment.body = blob.valueOf('my attachment text');
      attachment.fileName = 'textfileone.txt';
      attachment.mimeTypeSubType = 'text/plain';
      email.binaryAttachments = new Messaging.inboundEmail.BinaryAttachment[] { attachment };
       
   
      // add an Text attachment

      Messaging.InboundEmail.TextAttachment attachmenttext = new Messaging.InboundEmail.TextAttachment();
      attachmenttext.body = 'my attachment text';
      attachmenttext.fileName = 'textfiletwo3.txt';
      attachmenttext.mimeTypeSubType = 'texttwo/plain';
      email.textAttachments =   new Messaging.inboundEmail.TextAttachment[] { attachmenttext };

      // call the email service class and test it with the data in the testMethod
      EmailToCaseWithAttachments testInbound=new EmailToCaseWithAttachments();
      testInbound.handleInboundEmail(email, env);
      system.debug('EMAILTEST:atcancellation - tests valid addresses in to only result should be atcancellation');
      
       // setup the data for the email error path, should create case with no account or contact.
      email.subject = '';
      email.fromAddress = 'someaddress@email.com';
      email.plainTextBody = 'Fax received (5p) from: Dealer Skyline Motorsports - Dlr ID:69338003 FAX ID:714 760 4462';
      email.fromName = 'Test Name';
      email.toAddresses = new String[] {'Jon Smith <someaddress@email.com>'};
      email.htmlBody= 'Fax received (5p) from: Dealer Skyline Motorsports - Dlr ID:69338003 FAX ID:714 760 4462';
      // call the email service class and test it with the data in the testMethod
      EmailToCaseWithAttachments testInbound2=new EmailToCaseWithAttachments ();
      //testInbound2.handleInboundEmail(email, env);  
       
   }
  static testMethod void TestinBoundEmaildealbuildersupport()
   {
      // create a new email and envelope object
      Messaging.InboundEmail email = new Messaging.InboundEmail() ;
      Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
        
       // setup the data for the email
       // testing deal builder support
      email.subject = 'Test';
      email.fromAddress = 'someaddress@email.com';
      email.plainTextBody = 'Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff ';
      email.fromName = 'Test Name';
      email.ccAddresses = new String[] {'Jon Smith <someaddress@email.com>'};
      email.toAddresses = new String[] {'dealbuildersupport@email.com>'};

       
      // add an Binary attachment
      Messaging.InboundEmail.BinaryAttachment attachment = new Messaging.InboundEmail.BinaryAttachment();
      attachment.body = blob.valueOf('my attachment text');
      attachment.fileName = 'textfileone.txt';
      attachment.mimeTypeSubType = 'text/plain';
      email.binaryAttachments = new Messaging.inboundEmail.BinaryAttachment[] { attachment };
       
   
      // add an Text attachment

      Messaging.InboundEmail.TextAttachment attachmenttext = new Messaging.InboundEmail.TextAttachment();
      attachmenttext.body = 'my attachment text';
      attachmenttext.fileName = 'textfiletwo3.txt';
      attachmenttext.mimeTypeSubType = 'texttwo/plain';
      email.textAttachments =   new Messaging.inboundEmail.TextAttachment[] { attachmenttext };

      // call the email service class and test it with the data in the testMethod
      EmailToCaseWithAttachments testInbound=new EmailToCaseWithAttachments();
      testInbound.handleInboundEmail(email, env);
      system.debug('EMAILTEST:DealBuilderSupport - tests valid addresses in cc only result should be DealBuilderSupport');
      
      // setup the data for the email error path, should create case with no account or contact.
      email.subject = '';
      email.fromAddress = 'someaddress@email.com';
      email.plainTextBody = 'Fax received (5p) from: Dealer Skyline Motorsports - Dlr ID:69338003 FAX ID:714 760 4462';
      email.fromName = 'Test Name';
      email.toAddresses = new String[] {'Jon Smith <someaddress@email.com>'};
      email.htmlBody= 'Fax received (5p) from: Dealer Skyline Motorsports - Dlr ID:69338003 FAX ID:714 760 4462';
      
      // call the email service class and test it with the data in the testMethod
      EmailToCaseWithAttachments testInbound2=new EmailToCaseWithAttachments ();
      //testInbound2.handleInboundEmail(email, env); 
       
   }    
  static testMethod void TestinBoundEmailcorereworks()
   {
      // create a new email and envelope object
      Messaging.InboundEmail email = new Messaging.InboundEmail() ;
      Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
        
       // setup the data for the email
       // testing core reworks
      email.subject = 'Test';
      email.fromAddress = 'someaddress@email.com';
      email.plainTextBody = 'Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff ';
      email.fromName = 'Test Name';
      email.toAddresses = new String[] {'corereworks@email.com>'};
      email.ccAddresses = new String[] {'atcancellation@email.com'};
      email.htmlBody = '<html xmlns:v="urn:schemas-microsoft-com:vml" <body lang=EN-US link=blue vlink=purple><div class=WordSection1><p class=MsoNormal>ELECTRONIC QUICKSTART FORM <br>SUBMITTED_BY................................. Colleen Long (crlong) <br>DEALER_NAME.................................. Jaguar Land Rover Aston Martin Newport Beach <br>DEALER_ID.................................... 50580932 <br>SUBMITTER_CONTACT............................ 9493449816 <br>APPROVAL..................................... No <br>GENERAL_REQUEST.............................. Yes <br>AD_OR_PRODUCT_TYPE........................... Logotile <br>MAKES........................................ Jaguar, Land Rover, Aston Martin <br>COOP_MAKES................................... <br>CLICK_THRU_URL............................... http:// <br>DESCRIPTION.................................. Please replace the current logo tile with the attached. Thank you :- ) <o:p></o:p></p></div></body></html>';
      
      // add an Binary attachment
      Messaging.InboundEmail.BinaryAttachment attachment = new Messaging.InboundEmail.BinaryAttachment();
      attachment.body = blob.valueOf('my attachment text');
      attachment.fileName = 'textfileone.txt';
      attachment.mimeTypeSubType = 'text/plain';
      email.binaryAttachments = new Messaging.inboundEmail.BinaryAttachment[] { attachment };

      // call the email service class and test it with the data in the testMethod
      EmailToCaseWithAttachments testInbound=new EmailToCaseWithAttachments();
      testInbound.handleInboundEmail(email, env);
      system.debug('EMAILTEST:CoReworks - tests valid addresses in to and cc result should be coreworks');
       
   }     
  static testMethod void TestinBoundEmailmajoraccountsupport()
   {
      // create a new email and envelope object
      Messaging.InboundEmail email = new Messaging.InboundEmail() ;
      Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
        
       // setup the data for the email
       // testing at-major accounts support
      email.subject = 'Test';
      email.fromAddress = 'someaddress@email.com';
      email.plainTextBody = 'Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff ';
      email.fromName = 'Test Name';
      email.toAddresses = new String[] {'at-majoraccountssupport@email.com>'};
      
      // add an Binary attachment
      Messaging.InboundEmail.BinaryAttachment attachment = new Messaging.InboundEmail.BinaryAttachment();
      attachment.body = blob.valueOf('my attachment text');
      attachment.fileName = 'textfileone.txt';
      attachment.mimeTypeSubType = 'text/plain';
      email.binaryAttachments = new Messaging.inboundEmail.BinaryAttachment[] { attachment };

      // call the email service class and test it with the data in the testMethod
      EmailToCaseWithAttachments testInbound=new EmailToCaseWithAttachments();
      testInbound.handleInboundEmail(email, env);
      
   }       
  static testMethod void TestinBoundEmaildsemail()
   {
      // create a new email and envelope object
      Messaging.InboundEmail email = new Messaging.InboundEmail() ;
      Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
        
       // setup the data for the email
       // testing ds email
      email.subject = 'Test';
      email.fromAddress = 'someaddress@email.com';
      email.plainTextBody = 'Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff ';
      email.fromName = 'Test Name';
      email.toAddresses = new String[] {'dsemail@email.com>'};
      
      // add an Binary attachment
      Messaging.InboundEmail.BinaryAttachment attachment = new Messaging.InboundEmail.BinaryAttachment();
      attachment.body = blob.valueOf('my attachment text');
      attachment.fileName = 'textfileone.txt';
      attachment.mimeTypeSubType = 'text/plain';
      email.binaryAttachments = new Messaging.inboundEmail.BinaryAttachment[] { attachment };

      // call the email service class and test it with the data in the testMethod
      EmailToCaseWithAttachments testInbound=new EmailToCaseWithAttachments();
      testInbound.handleInboundEmail(email, env);
      
   }
  static testMethod void TestinBoundEmailcontractescalation()
   {
      // create a new email and envelope object
      Messaging.InboundEmail email = new Messaging.InboundEmail() ;
      Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
        
       // setup the data for the email
       // testing contract escalation
      email.subject = 'Test';
      email.fromAddress = 'someaddress@email.com';
      email.plainTextBody = 'Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff ';
      email.fromName = 'Test Name';
      email.ccAddresses = new String[] {'Jon Smith <someaddress@email.com>'};
      email.toAddresses = new String[] {'contractescalation@email.com>'};

       
      // add an Binary attachment
      Messaging.InboundEmail.BinaryAttachment attachment = new Messaging.InboundEmail.BinaryAttachment();
      attachment.body = blob.valueOf('my attachment text');
      attachment.fileName = 'textfileone.txt';
      attachment.mimeTypeSubType = 'text/plain';
      email.binaryAttachments = new Messaging.inboundEmail.BinaryAttachment[] { attachment };
       
   
      // add an Text attachment

      Messaging.InboundEmail.TextAttachment attachmenttext = new Messaging.InboundEmail.TextAttachment();
      attachmenttext.body = 'my attachment text';
      attachmenttext.fileName = 'textfiletwo3.txt';
      attachmenttext.mimeTypeSubType = 'texttwo/plain';
      email.textAttachments =   new Messaging.inboundEmail.TextAttachment[] { attachmenttext };

      // call the email service class and test it with the data in the testMethod
      EmailToCaseWithAttachments testInbound=new EmailToCaseWithAttachments();
      testInbound.handleInboundEmail(email, env);
      
       // setup the data for the email error path, should create case with no account or contact.
      email.subject = '';
      email.fromAddress = 'someaddress@email.com';
      email.plainTextBody = 'Fax received (5p) from: Dealer Skyline Motorsports - Dlr ID:69338003 FAX ID:714 760 4462';
      email.fromName = 'Test Name';
      email.toAddresses = new String[] {'Jon Smith <someaddress@email.com>'};
      email.htmlBody= 'Fax received (5p) from: Dealer Skyline Motorsports - Dlr ID:69338003 FAX ID:714 760 4462';
      
       // call the email service class and test it with the data in the testMethod
      EmailToCaseWithAttachments testInbound2=new EmailToCaseWithAttachments ();
      //testInbound2.handleInboundEmail(email, env);  
   }
  static testMethod void TestinBoundEmaildealersupportemails()
   {
      // create a new email and envelope object
      Messaging.InboundEmail email = new Messaging.InboundEmail() ;
      Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
        
       // setup the data for the email
       // testing dealer support emails
      email.subject = 'Test';
      email.fromAddress = 'someaddress@email.com';
      email.plainTextBody = 'Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff ';
      email.fromName = 'Test Name';
      email.ccAddresses = new String[] {'Jon Smith <someaddress@email.com>'};
      email.toAddresses = new String[] {'dealersupportemails@email.com>'};

       
      // add an Binary attachment
      Messaging.InboundEmail.BinaryAttachment attachment = new Messaging.InboundEmail.BinaryAttachment();
      attachment.body = blob.valueOf('my attachment text');
      attachment.fileName = 'textfileone.txt';
      attachment.mimeTypeSubType = 'text/plain';
      email.binaryAttachments = new Messaging.inboundEmail.BinaryAttachment[] { attachment };
       
   
      // add an Text attachment

      Messaging.InboundEmail.TextAttachment attachmenttext = new Messaging.InboundEmail.TextAttachment();
      attachmenttext.body = 'my attachment text';
      attachmenttext.fileName = 'textfiletwo3.txt';
      attachmenttext.mimeTypeSubType = 'texttwo/plain';
      email.textAttachments =   new Messaging.inboundEmail.TextAttachment[] { attachmenttext };

      // call the email service class and test it with the data in the testMethod
      EmailToCaseWithAttachments testInbound=new EmailToCaseWithAttachments();
      testInbound.handleInboundEmail(email, env);
      
       // setup the data for the email error path, should create case with no account or contact.
      email.subject = '';
      email.fromAddress = 'someaddress@email.com';
      email.plainTextBody = 'Fax received (5p) from: Dealer Skyline Motorsports - Dlr ID:69338003 FAX ID:714 760 4462';
      email.fromName = 'Test Name';
      email.toAddresses = new String[] {'Jon Smith <someaddress@email.com>'};
      email.htmlBody= 'Fax received (5p) from: Dealer Skyline Motorsports - Dlr ID:69338003 FAX ID:714 760 4462';
      
       // call the email service class and test it with the data in the testMethod
      EmailToCaseWithAttachments testInbound2=new EmailToCaseWithAttachments ();
      //testInbound2.handleInboundEmail(email, env);  
   }
  static testMethod void TestinBoundEmaildmdmajoraccountseqs()
   {
      // create a new email and envelope object
      Messaging.InboundEmail email = new Messaging.InboundEmail() ;
      Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
        
       // setup the data for the email
       // testing dmd major accounts eqs
      email.subject = 'Test';
      email.fromAddress = 'someaddress@email.com';
      email.plainTextBody = 'Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff ';
      email.fromName = 'Test Name';
      email.ccAddresses = new String[] {'Jon Smith <someaddress@email.com>'};
      email.toAddresses = new String[] {'dmdmajoraccountseqs@email.com>'};

       
      // add an Binary attachment
      Messaging.InboundEmail.BinaryAttachment attachment = new Messaging.InboundEmail.BinaryAttachment();
      attachment.body = blob.valueOf('my attachment text');
      attachment.fileName = 'textfileone.txt';
      attachment.mimeTypeSubType = 'text/plain';
      email.binaryAttachments = new Messaging.inboundEmail.BinaryAttachment[] { attachment };
       
   
      // add an Text attachment

      Messaging.InboundEmail.TextAttachment attachmenttext = new Messaging.InboundEmail.TextAttachment();
      attachmenttext.body = 'my attachment text';
      attachmenttext.fileName = 'textfiletwo3.txt';
      attachmenttext.mimeTypeSubType = 'texttwo/plain';
      email.textAttachments =   new Messaging.inboundEmail.TextAttachment[] { attachmenttext };

      // call the email service class and test it with the data in the testMethod
      EmailToCaseWithAttachments testInbound=new EmailToCaseWithAttachments();
      testInbound.handleInboundEmail(email, env);
      
       // setup the data for the email error path, should create case with no account or contact.
      email.subject = '';
      email.fromAddress = 'someaddress@email.com';
      email.plainTextBody = 'Fax received (5p) from: Dealer Skyline Motorsports - Dlr ID:69338003 FAX ID:714 760 4462';
      email.fromName = 'Test Name';
      email.toAddresses = new String[] {'Jon Smith <someaddress@email.com>'};
      email.htmlBody= 'Fax received (5p) from: Dealer Skyline Motorsports - Dlr ID:69338003 FAX ID:714 760 4462';
      
       // call the email service class and test it with the data in the testMethod
      EmailToCaseWithAttachments testInbound2=new EmailToCaseWithAttachments ();
      //testInbound2.handleInboundEmail(email, env);  
   }   
  static testMethod void TestinBoundEmailinventorytechsupport()
   {
      // create a new email and envelope object
      Messaging.InboundEmail email = new Messaging.InboundEmail() ;
      Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
        
       // setup the data for the email
       // testing inventory tech support
      email.subject = 'Test';
      email.fromAddress = 'someaddress@email.com';
      email.plainTextBody = 'Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff ';
      email.fromName = 'Test Name';
      email.ccAddresses = new String[] {'Jon Smith <someaddress@email.com>'};
      email.toAddresses = new String[] {'inventorytechsupport@email.com>'};

       
      // add an Binary attachment
      Messaging.InboundEmail.BinaryAttachment attachment = new Messaging.InboundEmail.BinaryAttachment();
      attachment.body = blob.valueOf('my attachment text');
      attachment.fileName = 'textfileone.txt';
      attachment.mimeTypeSubType = 'text/plain';
      email.binaryAttachments = new Messaging.inboundEmail.BinaryAttachment[] { attachment };
       
   
      // add an Text attachment

      Messaging.InboundEmail.TextAttachment attachmenttext = new Messaging.InboundEmail.TextAttachment();
      attachmenttext.body = 'my attachment text';
      attachmenttext.fileName = 'textfiletwo3.txt';
      attachmenttext.mimeTypeSubType = 'texttwo/plain';
      email.textAttachments =   new Messaging.inboundEmail.TextAttachment[] { attachmenttext };

      // call the email service class and test it with the data in the testMethod
      EmailToCaseWithAttachments testInbound=new EmailToCaseWithAttachments();
      testInbound.handleInboundEmail(email, env);
      
       // setup the data for the email error path, should create case with no account or contact.
      email.subject = '';
      email.fromAddress = 'someaddress@email.com';
      email.plainTextBody = 'Fax received (5p) from: Dealer Skyline Motorsports - Dlr ID:69338003 FAX ID:714 760 4462';
      email.fromName = 'Test Name';
      email.toAddresses = new String[] {'Jon Smith <someaddress@email.com>'};
      email.htmlBody= 'Fax received (5p) from: Dealer Skyline Motorsports - Dlr ID:69338003 FAX ID:714 760 4462';
      
       // call the email service class and test it with the data in the testMethod
      EmailToCaseWithAttachments testInbound2=new EmailToCaseWithAttachments ();
     // testInbound2.handleInboundEmail(email, env);  
   }
  static testMethod void TestinBoundEmailmegamajoraccountssupport()
   {
      // create a new email and envelope object
      Messaging.InboundEmail email = new Messaging.InboundEmail() ;
      Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
        
       // setup the data for the email
       // testing mega major accounts support
      email.subject = 'Test';
      email.fromAddress = 'someaddress@email.com';
      email.plainTextBody = 'Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff ';
      email.fromName = 'Test Name';
      email.ccAddresses = new String[] {'Jon Smith <someaddress@email.com>'};
      email.toAddresses = new String[] {'megamajoraccountssupport@email.com>'};

       
      // add an Binary attachment
      Messaging.InboundEmail.BinaryAttachment attachment = new Messaging.InboundEmail.BinaryAttachment();
      attachment.body = blob.valueOf('my attachment text');
      attachment.fileName = 'textfileone.txt';
      attachment.mimeTypeSubType = 'text/plain';
      email.binaryAttachments = new Messaging.inboundEmail.BinaryAttachment[] { attachment };
       
   
      // add an Text attachment

      Messaging.InboundEmail.TextAttachment attachmenttext = new Messaging.InboundEmail.TextAttachment();
      attachmenttext.body = 'my attachment text';
      attachmenttext.fileName = 'textfiletwo3.txt';
      attachmenttext.mimeTypeSubType = 'texttwo/plain';
      email.textAttachments =   new Messaging.inboundEmail.TextAttachment[] { attachmenttext };

      // call the email service class and test it with the data in the testMethod
      EmailToCaseWithAttachments testInbound=new EmailToCaseWithAttachments();
      testInbound.handleInboundEmail(email, env);
      
       // setup the data for the email error path, should create case with no account or contact.
      email.subject = '';
      email.fromAddress = 'someaddress@email.com';
      email.plainTextBody = 'Fax received (5p) from: Dealer Skyline Motorsports - Dlr ID:69338003 FAX ID:714 760 4462';
      email.fromName = 'Test Name';
      email.toAddresses = new String[] {'Jon Smith <someaddress@email.com>'};
      email.htmlBody= 'Fax received (5p) from: Dealer Skyline Motorsports - Dlr ID:69338003 FAX ID:714 760 4462';
      
       // call the email service class and test it with the data in the testMethod
      EmailToCaseWithAttachments testInbound2=new EmailToCaseWithAttachments ();
     // testInbound2.handleInboundEmail(email, env);  
   }
  static testMethod void TestinBoundEmailtimsalesorders()
   {
      // create a new email and envelope object
      Messaging.InboundEmail email = new Messaging.InboundEmail() ;
      Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
        
       // setup the data for the email
       // testing tim sales orders
      email.subject = 'Test';
      email.fromAddress = 'someaddress@email.com';
      email.plainTextBody = 'Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff ';
      email.fromName = 'Test Name';
      email.ccAddresses = new String[] {'Jon Smith <someaddress@email.com>'};
      email.toAddresses = new String[] {'timsalesorders@email.com>'};

       
      // add an Binary attachment
      Messaging.InboundEmail.BinaryAttachment attachment = new Messaging.InboundEmail.BinaryAttachment();
      attachment.body = blob.valueOf('my attachment text');
      attachment.fileName = 'textfileone.txt';
      attachment.mimeTypeSubType = 'text/plain';
      email.binaryAttachments = new Messaging.inboundEmail.BinaryAttachment[] { attachment };
       
   
      // add an Text attachment

      Messaging.InboundEmail.TextAttachment attachmenttext = new Messaging.InboundEmail.TextAttachment();
      attachmenttext.body = 'my attachment text';
      attachmenttext.fileName = 'textfiletwo3.txt';
      attachmenttext.mimeTypeSubType = 'texttwo/plain';
      email.textAttachments =   new Messaging.inboundEmail.TextAttachment[] { attachmenttext };

      // call the email service class and test it with the data in the testMethod
      EmailToCaseWithAttachments testInbound=new EmailToCaseWithAttachments();
      testInbound.handleInboundEmail(email, env);
      
       // setup the data for the email error path, should create case with no account or contact.
      email.subject = '';
      email.fromAddress = 'someaddress@email.com';
      email.plainTextBody = 'Fax received (5p) from: Dealer Skyline Motorsports - Dlr ID:69338003 FAX ID:714 760 4462';
      email.fromName = 'Test Name';
      email.toAddresses = new String[] {'Jon Smith <someaddress@email.com>'};
      email.htmlBody= 'Fax received (5p) from: Dealer Skyline Motorsports - Dlr ID:69338003 FAX ID:714 760 4462';
      
       // call the email service class and test it with the data in the testMethod
      EmailToCaseWithAttachments testInbound2=new EmailToCaseWithAttachments ();
      //testInbound2.handleInboundEmail(email, env);  
   }
  static testMethod void TestinBoundEmailkbbshowcasereworks()
   {
      // create a new email and envelope object
      Messaging.InboundEmail email = new Messaging.InboundEmail() ;
      Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
        
       // setup the data for the email
       // testing kbb showcase reworks
      email.subject = 'Test';
      email.fromAddress = 'someaddress@email.com';
      email.plainTextBody = 'Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff ';
      email.fromName = 'Test Name';
      email.ccAddresses = new String[] {'Jon Smith <someaddress@email.com>'};
      email.toAddresses = new String[] {'kbbshowcasereworks@email.com>'};

       
      // add an Binary attachment
      Messaging.InboundEmail.BinaryAttachment attachment = new Messaging.InboundEmail.BinaryAttachment();
      attachment.body = blob.valueOf('my attachment text');
      attachment.fileName = 'textfileone.txt';
      attachment.mimeTypeSubType = 'text/plain';
      email.binaryAttachments = new Messaging.inboundEmail.BinaryAttachment[] { attachment };
       
   
      // add an Text attachment

      Messaging.InboundEmail.TextAttachment attachmenttext = new Messaging.InboundEmail.TextAttachment();
      attachmenttext.body = 'my attachment text';
      attachmenttext.fileName = 'textfiletwo3.txt';
      attachmenttext.mimeTypeSubType = 'texttwo/plain';
      email.textAttachments =   new Messaging.inboundEmail.TextAttachment[] { attachmenttext };

      // call the email service class and test it with the data in the testMethod
      EmailToCaseWithAttachments testInbound=new EmailToCaseWithAttachments();
      testInbound.handleInboundEmail(email, env);
      
       // setup the data for the email error path, should create case with no account or contact.
      email.subject = '';
      email.fromAddress = 'someaddress@email.com';
      email.plainTextBody = 'Fax received (5p) from: Dealer Skyline Motorsports - Dlr ID:69338003 FAX ID:714 760 4462';
      email.fromName = 'Test Name';
      email.toAddresses = new String[] {'Jon Smith <someaddress@email.com>'};
      email.htmlBody= 'Fax received (5p) from: Dealer Skyline Motorsports - Dlr ID:69338003 FAX ID:714 760 4462';
      
       // call the email service class and test it with the data in the testMethod
      EmailToCaseWithAttachments testInbound2=new EmailToCaseWithAttachments ();
      //testInbound2.handleInboundEmail(email, env);  
   }
  static testMethod void TestinBoundEmailinfo() //Defect D-03668 original problem
   {
      // create a new email and envelope object
      Messaging.InboundEmail email = new Messaging.InboundEmail() ;
      Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
        
       // setup the data for the email
       // testing ds email
      email.subject = 'Test';
      email.fromAddress = 'someaddress@email.com';
      email.plainTextBody = 'Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff ';
      email.fromName = 'Test Name';
      email.toAddresses = new String[] {'info@autotrader.com'};
      
      // add an Binary attachment
      Messaging.InboundEmail.BinaryAttachment attachment = new Messaging.InboundEmail.BinaryAttachment();
      attachment.body = blob.valueOf('my attachment text');
      attachment.fileName = 'textfileone.txt';
      attachment.mimeTypeSubType = 'text/plain';
      email.binaryAttachments = new Messaging.inboundEmail.BinaryAttachment[] { attachment };

      // call the email service class and test it with the data in the testMethod
      EmailToCaseWithAttachments testInbound=new EmailToCaseWithAttachments();
      testInbound.handleInboundEmail(email, env);
      
   }   
  static testMethod void TestinBoundEmailCoop() //Defect D-03668 filling in missing unit tests
   {
      // create a new email and envelope object
      Messaging.InboundEmail email = new Messaging.InboundEmail() ;
      Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
        
       // setup the data for the email
       // testing ds email
      email.subject = 'Test';
      email.fromAddress = 'someaddress@email.com';
      email.plainTextBody = 'Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff ';
      email.fromName = 'Test Name';
      email.toAddresses = new String[] {'coop@autotrader.com'};
      
      // add an Binary attachment
      Messaging.InboundEmail.BinaryAttachment attachment = new Messaging.InboundEmail.BinaryAttachment();
      attachment.body = blob.valueOf('my attachment text');
      attachment.fileName = 'textfileone.txt';
      attachment.mimeTypeSubType = 'text/plain';
      email.binaryAttachments = new Messaging.inboundEmail.BinaryAttachment[] { attachment };

      // call the email service class and test it with the data in the testMethod
      EmailToCaseWithAttachments testInbound=new EmailToCaseWithAttachments();
      testInbound.handleInboundEmail(email, env);
      
   } 
  static testMethod void TestinBoundEmailKbbsupport() //Defect D-03668 filling in missing unit tests
   {
      // create a new email and envelope object
      Messaging.InboundEmail email = new Messaging.InboundEmail() ;
      Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
        
       // setup the data for the email
       // testing ds email
      email.subject = 'Test';
      email.fromAddress = 'someaddress@email.com';
      email.plainTextBody = 'Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff ';
      email.fromName = 'Test Name';
      email.toAddresses = new String[] {'kbbsupport@autotrader.com>'};
      
      // add an Binary attachment
      Messaging.InboundEmail.BinaryAttachment attachment = new Messaging.InboundEmail.BinaryAttachment();
      attachment.body = blob.valueOf('my attachment text');
      attachment.fileName = 'textfileone.txt';
      attachment.mimeTypeSubType = 'text/plain';
      email.binaryAttachments = new Messaging.inboundEmail.BinaryAttachment[] { attachment };

      // call the email service class and test it with the data in the testMethod
      EmailToCaseWithAttachments testInbound=new EmailToCaseWithAttachments();
      testInbound.handleInboundEmail(email, env);
      
   }
  static testMethod void TestinBoundEmailAccountRequest() //Defect D-03668 filling in missing unit tests
   {
      // create a new email and envelope object
      Messaging.InboundEmail email = new Messaging.InboundEmail() ;
      Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
        
       // setup the data for the email
       // testing ds email
      email.subject = 'Test';
      email.fromAddress = 'someaddress@email.com';
      email.plainTextBody = 'Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff ';
      email.fromName = 'Test Name';
      email.toAddresses = new String[] {'accountrequest@autotrader.com>'};
      
      // add an Binary attachment
      Messaging.InboundEmail.BinaryAttachment attachment = new Messaging.InboundEmail.BinaryAttachment();
      attachment.body = blob.valueOf('my attachment text');
      attachment.fileName = 'textfileone.txt';
      attachment.mimeTypeSubType = 'text/plain';
      email.binaryAttachments = new Messaging.inboundEmail.BinaryAttachment[] { attachment };

      // call the email service class and test it with the data in the testMethod
      EmailToCaseWithAttachments testInbound=new EmailToCaseWithAttachments();
      testInbound.handleInboundEmail(email, env);
      
   }  
  static testMethod void TestinBoundEmailFastcustops() //Defect D-03668 filling in missing unit tests
   {
      // create a new email and envelope object
      Messaging.InboundEmail email = new Messaging.InboundEmail() ;
      Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
        
       // setup the data for the email
       // testing ds email
      email.subject = 'Test';
      email.fromAddress = 'someaddress@email.com';
      email.plainTextBody = 'Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff ';
      email.fromName = 'Test Name';
      email.toAddresses = new String[] {'fastads.custops@autotrader.com'};
      
      // add an Binary attachment
      Messaging.InboundEmail.BinaryAttachment attachment = new Messaging.InboundEmail.BinaryAttachment();
      attachment.body = blob.valueOf('my attachment text');
      attachment.fileName = 'textfileone.txt';
      attachment.mimeTypeSubType = 'text/plain';
      email.binaryAttachments = new Messaging.inboundEmail.BinaryAttachment[] { attachment };

      // call the email service class and test it with the data in the testMethod
      EmailToCaseWithAttachments testInbound=new EmailToCaseWithAttachments();
      testInbound.handleInboundEmail(email, env);
      // test second address
      email.toAddresses = new String[] {'fastadscustomer@autotrader.com'};      
      EmailToCaseWithAttachments testInbound2=new EmailToCaseWithAttachments();
      testInbound2.handleInboundEmail(email, env);      
   }    
  static testMethod void TestinBoundEmailBhphsupport() //Defect D-03668 filling in missing unit tests
   {
      // create a new email and envelope object
      Messaging.InboundEmail email = new Messaging.InboundEmail() ;
      Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
        
       // setup the data for the email
       // testing ds email
      email.subject = 'Test';
      email.fromAddress = 'someaddress@email.com';
      email.plainTextBody = 'Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff ';
      email.fromName = 'Test Name';
      email.toAddresses = new String[] {'bhphsupportemails@autotrader.com'};
      
      // add an Binary attachment
      Messaging.InboundEmail.BinaryAttachment attachment = new Messaging.InboundEmail.BinaryAttachment();
      attachment.body = blob.valueOf('my attachment text');
      attachment.fileName = 'textfileone.txt';
      attachment.mimeTypeSubType = 'text/plain';
      email.binaryAttachments = new Messaging.inboundEmail.BinaryAttachment[] { attachment };

      // call the email service class and test it with the data in the testMethod
      EmailToCaseWithAttachments testInbound=new EmailToCaseWithAttachments();
      testInbound.handleInboundEmail(email, env);
      
   } 
  static testMethod void TestinBoundEmailHibernation() //Defect D-03668 filling in missing unit tests
   {
      // create a new email and envelope object
      Messaging.InboundEmail email = new Messaging.InboundEmail() ;
      Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
        
       // setup the data for the email
       // testing ds email
      email.subject = 'Test';
      email.fromAddress = 'someaddress@email.com';
      email.plainTextBody = 'Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff ';
      email.fromName = 'Test Name';
      email.toAddresses = new String[] {'hibernationrequest@autotrader.com'};
      
      // add an Binary attachment
      Messaging.InboundEmail.BinaryAttachment attachment = new Messaging.InboundEmail.BinaryAttachment();
      attachment.body = blob.valueOf('my attachment text');
      attachment.fileName = 'textfileone.txt';
      attachment.mimeTypeSubType = 'text/plain';
      email.binaryAttachments = new Messaging.inboundEmail.BinaryAttachment[] { attachment };

      // call the email service class and test it with the data in the testMethod
      EmailToCaseWithAttachments testInbound=new EmailToCaseWithAttachments();
      testInbound.handleInboundEmail(email, env);
      
   } 
  static testMethod void TestinBoundEmailDataqualitygroup() //Defect D-03668 filling in missing unit tests
   {
      // create a new email and envelope object
      Messaging.InboundEmail email = new Messaging.InboundEmail() ;
      Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
        
       // setup the data for the email
       // testing ds email
      email.subject = 'Test';
      email.fromAddress = 'someaddress@email.com';
      email.plainTextBody = 'Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff ';
      email.fromName = 'Test Name';
      email.toAddresses = new String[] {'dataqualitygroup@autotrader.com'};
      
      // add an Binary attachment
      Messaging.InboundEmail.BinaryAttachment attachment = new Messaging.InboundEmail.BinaryAttachment();
      attachment.body = blob.valueOf('my attachment text');
      attachment.fileName = 'textfileone.txt';
      attachment.mimeTypeSubType = 'text/plain';
      email.binaryAttachments = new Messaging.inboundEmail.BinaryAttachment[] { attachment };

      // call the email service class and test it with the data in the testMethod
      EmailToCaseWithAttachments testInbound=new EmailToCaseWithAttachments();
      testInbound.handleInboundEmail(email, env);
      
   }
  static testMethod void TestinBoundEmailDealerGroupSupport() //Defect D-03668 filling in missing unit tests
   {
      // create a new email and envelope object
      Messaging.InboundEmail email = new Messaging.InboundEmail() ;
      Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
        
       // setup the data for the email
       // testing ds email
      email.subject = 'Test';
      email.fromAddress = 'someaddress@email.com';
      email.plainTextBody = 'Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff ';
      email.fromName = 'Test Name';
      email.toAddresses = new String[] {'dealergroupsupport@autotrader.com'};
      
      // add an Binary attachment
      Messaging.InboundEmail.BinaryAttachment attachment = new Messaging.InboundEmail.BinaryAttachment();
      attachment.body = blob.valueOf('my attachment text');
      attachment.fileName = 'textfileone.txt';
      attachment.mimeTypeSubType = 'text/plain';
      email.binaryAttachments = new Messaging.inboundEmail.BinaryAttachment[] { attachment };

      // call the email service class and test it with the data in the testMethod
      EmailToCaseWithAttachments testInbound=new EmailToCaseWithAttachments();
      testInbound.handleInboundEmail(email, env);
      
   }  
  static testMethod void TestinBoundEmailCCSenior() //Defect D-03668 filling in missing unit tests
   {
      // create a new email and envelope object
      Messaging.InboundEmail email = new Messaging.InboundEmail() ;
      Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
        
       // setup the data for the email
       // testing ds email
      email.subject = 'Test';
      email.fromAddress = 'someaddress@email.com';
      email.plainTextBody = 'Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff ';
      email.fromName = 'Test Name';
      email.toAddresses = new String[] {'cccseniorqueue@autotrader.com'};
      
      // add an Binary attachment
      Messaging.InboundEmail.BinaryAttachment attachment = new Messaging.InboundEmail.BinaryAttachment();
      attachment.body = blob.valueOf('my attachment text');
      attachment.fileName = 'textfileone.txt';
      attachment.mimeTypeSubType = 'text/plain';
      email.binaryAttachments = new Messaging.inboundEmail.BinaryAttachment[] { attachment };

      // call the email service class and test it with the data in the testMethod
      EmailToCaseWithAttachments testInbound=new EmailToCaseWithAttachments();
      testInbound.handleInboundEmail(email, env);
      
   } 
  static testMethod void TestinBoundEmailDSTrouble() //Defect D-03668 filling in missing unit tests
   {
      // create a new email and envelope object
      Messaging.InboundEmail email = new Messaging.InboundEmail() ;
      Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
        
       // setup the data for the email
       // testing ds email
      email.subject = 'Test';
      email.fromAddress = 'someaddress@email.com';
      email.plainTextBody = 'Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff ';
      email.fromName = 'Test Name';
      email.toAddresses = new String[] {'dstroubleshooters@autotrader.com'};
      
      // add an Binary attachment
      Messaging.InboundEmail.BinaryAttachment attachment = new Messaging.InboundEmail.BinaryAttachment();
      attachment.body = blob.valueOf('my attachment text');
      attachment.fileName = 'textfileone.txt';
      attachment.mimeTypeSubType = 'text/plain';
      email.binaryAttachments = new Messaging.inboundEmail.BinaryAttachment[] { attachment };

      // call the email service class and test it with the data in the testMethod
      EmailToCaseWithAttachments testInbound=new EmailToCaseWithAttachments();
      testInbound.handleInboundEmail(email, env);
      
   } 
  static testMethod void TestinBoundEmailCorpAffairs() //Defect D-03668 filling in missing unit tests
   {
      // create a new email and envelope object
      Messaging.InboundEmail email = new Messaging.InboundEmail() ;
      Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
        
       // setup the data for the email
       // testing ds email
      email.subject = 'Test';
      email.fromAddress = 'someaddress@email.com';
      email.plainTextBody = 'Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff Testing stuff ';
      email.fromName = 'Test Name';
      email.toAddresses = new String[] {'corporateaffairs@autotrader.com'};
      
      // add an Binary attachment
      Messaging.InboundEmail.BinaryAttachment attachment = new Messaging.InboundEmail.BinaryAttachment();
      attachment.body = blob.valueOf('my attachment text');
      attachment.fileName = 'textfileone.txt';
      attachment.mimeTypeSubType = 'text/plain';
      email.binaryAttachments = new Messaging.inboundEmail.BinaryAttachment[] { attachment };

      // call the email service class and test it with the data in the testMethod
      EmailToCaseWithAttachments testInbound=new EmailToCaseWithAttachments();
      testInbound.handleInboundEmail(email, env);
      
   }    
}