@isTest(SeeAllData=true)
public class TestEmailService{
    static testMethod void myTestMethod() {

       // Create a new email, envelope object and Attachment
       Messaging.InboundEmail email = new Messaging.InboundEmail();
       Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();

       email.subject = 'test';
       env.fromAddress = 'user@acme.com';
       email.fromAddress = 'user@acme.com';


       // call the class and test it with the data in the testMethod
       CreateLeadFromEmail emailServiceObj = new CreateLeadFromEmail();
       Test.startTest();
       Messaging.InboundEmailResult result = emailServiceObj.handleInboundEmail(email, env ); 
       Test.stopTest();
       system.debug('ran unit test on email service');
       System.assert (result.success, 'InboundEmailResult returned a failure message');
       Lead[] leadDb = [select ID,email from Lead where email=:email.fromAddress];
       System.assertEquals (1, leadDb.size(),'Lead was not inserted');


    }
 }