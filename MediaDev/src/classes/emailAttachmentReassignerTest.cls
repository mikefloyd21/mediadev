public class emailAttachmentReassignerTest {
    private static final Id caseRecordTypeAcct = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Major Account').getRecordTypeId();
        static testmethod void attachmentTester() {
            Case c = new Case();
            insert c;

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

            	EmailMessage em = new EmailMessage();
            	em.parentId = c.id;
            	em.MessageDate = Date.today();
            	em.FromAddress = 'test@from.com';
            	em.ToAddress = 'test@to.com';
            	em.Subject = 'test subject 111111';
            	em.TextBody = 'heres a text body.';
            	insert em;
                    
        
            Attachment a = new Attachment();
            a.name = 'test attachment';
            a.body = blob.valueof('attachment body');
            a.parentid = em.id;
            insert a;   
            
            List<Attachment> attachments = [Select Id From Attachment Where parentId = :c.id];
            
            System.assert(attachments.size() == 1, 'Wrong number of attachments (( ' + attachments.size() );
        }   
    }