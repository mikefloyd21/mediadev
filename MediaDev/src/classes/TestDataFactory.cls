@isTest public class TestDataFactory {
   private static final Id caseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('ATC Dealer Service').getRecordTypeId();
   private static final Id caseRecordTypeAcct = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Major Account').getRecordTypeId();
		
   public static List<Case> createTestCases(Integer numCases, String stat, String reason) {
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
                                            RecordTypeId = caseRecordTypeAcct);

        insert accAux;

        List<Case> caselist = new List<Case>();
		// Add test code to make sure we can close at least 50 at once without exceeding SOQL limits.
		// per Defect D-03791        
        for(Integer i=0;i<numCases;i++) {
	            Case c = new Case(Subject='TestCase' + i);
        		c.Description = 'Test Description';
        		c.AccountId = accAux.Id;
        		c.Priority = 'Low';
        		c.Origin = 'Phone';
        		c.Status = stat;
				c.reason = reason;            
        		c.RecordTypeId = caseRecordTypeId;
	            caselist.add(c);
	        }       

        insert caselist;
        return caselist;
   }
   public static List<Account> createTestAccounts(Integer numAccts) {

        List<Account> alist = new List<Account>();
		// Add test code to make sure we can close at least 50 at once without exceeding SOQL limits.
		// per Defect D-03791        
        for(Integer i=0;i < numAccts;i++) {
         Account accAux         = new Account(Name = 'TestAccount'+i,ShippingStreet= '1 Main St.', 
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
                                            RecordTypeId = caseRecordTypeAcct);
	            alist.add(accAux);
	        }       

        insert alist;
        return alist;
   }    
}