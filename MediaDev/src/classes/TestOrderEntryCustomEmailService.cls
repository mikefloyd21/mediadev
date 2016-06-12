@isTest(SeeAllData=true)
public class TestOrderEntryCustomEmailService{
  static testMethod void TestinBoundEmail()
   {
      // create a new email and envelope object
      Messaging.InboundEmail email = new Messaging.InboundEmail() ;
      Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
        
       // setup the data for the email
      email.subject = 'LMGRANDE_1111111';
      email.fromAddress = 'someaddress@email.com';
      email.plainTextBody = 'Fax received (5p) from: Dealer Skyline Motorsports - Dlr ID:69338003 FAX ID:714 760 4462';
      email.fromName = 'Test Name';
      email.toAddresses = new String[] {'Jon Smith <someaddress@email.com>'};
      email.htmlBody= 'Fax received (5p) from: Dealer Skyline Motorsports - Dlr ID:69338003 FAX ID:714 760 4462';

       
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
      OrderEntryCustomEmailToCase testInbound=new OrderEntryCustomEmailToCase ();
      testInbound.handleInboundEmail(email, env);
      
       // setup the data for the email error path, should create case with no account or contact.
      email.subject = '';
      email.fromAddress = 'someaddress@email.com';
      email.plainTextBody = 'Fax received (5p) from: Dealer Skyline Motorsports - Dlr ID:69338003 FAX ID:714 760 4462';
      email.fromName = 'Test Name';
      email.toAddresses = new String[] {'Jon Smith <someaddress@email.com>'};
      
      // call the email service class and test it with the data in the testMethod
      OrderEntryCustomEmailToCase testInbound2=new OrderEntryCustomEmailToCase ();
      //testInbound2.handleInboundEmail(email, env);
      // testing boundaries
      
      String sample = 'abcde12345'; //10-digit string. 
      String bodySample = ''; 
      for (Integer cutoff = 0; cutoff <= 3300; cutoff++) 
      { 
        bodySample = bodySample + sample; 
      }
      String subjectSample = ''; 
      for (Integer cutoff = 0; cutoff <= 310; cutoff++) 
      { 
        subjectSample = subjectSample + sample; 
      }      
      // setup the data for the email path with subject > 50 characters, should create case with no account or contact.
      email.subject = subjectSample;
      email.fromAddress = 'someaddress@email.com';
      email.plainTextBody = bodySample;
      email.fromName = 'Test Name';
      email.toAddresses = new String[] {'Jon Smith <someaddress@email.com>'};
      email.htmlBody= '<html><body>'+bodySample+'</body></html>';
      // call the email service class and test it with the data in the testMethod
      OrderEntryCustomEmailToCase testInbound3=new OrderEntryCustomEmailToCase ();
      //testInbound3.handleInboundEmail(email, env);

      // setup the data for the email path with no fields  create case with no account or contact.
      email.subject = null;
      email.fromAddress = 'someaddress@email.com';
      email.plainTextBody = null;
      email.fromName = 'Test Name';
      email.toAddresses = new String[] {'Jon Smith <someaddress@email.com>'};
      email.htmlBody= null;
      // call the email service class and test it with the data in the testMethod
      OrderEntryCustomEmailToCase testInbound4=new OrderEntryCustomEmailToCase ();
      //testInbound4.handleInboundEmail(email, env);

     
   }
 }