@isTest
public class OppProdSE2ExtenderTests {
	static testMethod void testExtenderInit() {
		Account acct1 = createTestAccount('Unit Test Account 1');
		insert acct1;

		Opportunity opp1 = createTestOpp('Unit Test Opp 1', acct1.Id);
		insert opp1;

		Opp_Product__c oppProd1 = createTestOppProd(opp1.Id);
		insert oppProd1;

		PageReference testPr = new PageReference('/apex/TestPage');
		testPr.getParameters().put('id', oppProd1.Id);
		Test.setCurrentPage(testPr);
		ApexPages.StandardController stdController = new ApexPages.StandardController(oppProd1);
		TestExtension extension = new TestExtension(stdController);
		OppProdSE2Extender extender = extension.getExtender();

		// check basic loading assumptions
		System.assertNotEquals(null, extension.mainRecord);
		System.assertEquals(Opp_Product__c.sObjectType, extension.mainRecord.getSObjectType());

		// check to make sure the records loaded
		Opp_Product__c oppProdRec = (Opp_Product__c) extension.mainRecord;
		System.assertNotEquals(null,     oppProdRec.Opportunity__r);
		System.assertNotEquals(null,     oppProdRec.Opportunity__r.Account);
		System.assertEquals(oppProd1.Id, oppProdRec.Id);
		System.assertEquals(opp1.Id,     oppProdRec.Opportunity__c);
		System.assertEquals(acct1.Id,    oppProdRec.Opportunity__r.AccountId);

		// validate that the billing addresses copied over
		System.assertEquals(false,                oppProdRec.Opportunity__r.Custom_Billing_Address__c);
		System.assertNotEquals(null,              oppProdRec.Opportunity__r.Account.BillingStreet);
		System.assertEquals(acct1.BillingStreet,  oppProdRec.Opportunity__r.Account.BillingStreet);
		System.assertNotEquals(null,              oppProdRec.Opportunity__r.Billing_Street__c);
		System.assertEquals(acct1.BillingStreet,  oppProdRec.Opportunity__r.Billing_Street__c);

		// validate that the shipping addresses copied over
		System.assertEquals(false,                oppProdRec.Opportunity__r.Custom_Physical_Address__c);
		System.assertNotEquals(null,              oppProdRec.Opportunity__r.Account.ShippingStreet);
		System.assertEquals(acct1.ShippingStreet, oppProdRec.Opportunity__r.Account.ShippingStreet);
		System.assertNotEquals(null,              oppProdRec.Opportunity__r.Physical_Street__c);
		System.assertEquals(acct1.ShippingStreet, oppProdRec.Opportunity__r.Physical_Street__c);
	}

	static testMethod void testExtenderInitWithCustomAddress() {
		Account acct1 = createTestAccount('Unit Test Account 1');
		insert acct1;

		Opportunity opp1 = createTestOpp('Unit Test Opp 1', acct1.Id);
		opp1.Custom_Billing_Address__c = true;
		opp1.Billing_Street__c = '321 Another St. Unit B';
		opp1.Custom_Physical_Address__c = true;
		opp1.Physical_Street__c = '321 Another St. Unit P';
		insert opp1;

		Opp_Product__c oppProd1 = createTestOppProd(opp1.Id);
		insert oppProd1;

		PageReference testPr = new PageReference('/apex/TestPage');
		testPr.getParameters().put('id', oppProd1.Id);
		Test.setCurrentPage(testPr);
		ApexPages.StandardController stdController = new ApexPages.StandardController(oppProd1);
		TestExtension extension = new TestExtension(stdController);
		OppProdSE2Extender extender = extension.getExtender();

		// check basic loading assumptions
		System.assertNotEquals(null, extension.mainRecord);
		System.assertEquals(Opp_Product__c.sObjectType, extension.mainRecord.getSObjectType());

		// check to make sure the records loaded
		Opp_Product__c oppProdRec = (Opp_Product__c) extension.mainRecord;
		System.assertNotEquals(null,     oppProdRec.Opportunity__r);
		System.assertNotEquals(null,     oppProdRec.Opportunity__r.Account);
		System.assertEquals(oppProd1.Id, oppProdRec.Id);
		System.assertEquals(opp1.Id,     oppProdRec.Opportunity__c);
		System.assertEquals(acct1.Id,    oppProdRec.Opportunity__r.AccountId);

		// validate that the billing addresses copied over
		System.assertEquals(true,                    oppProdRec.Opportunity__r.Custom_Billing_Address__c);
		System.assertNotEquals(null,                 oppProdRec.Opportunity__r.Account.BillingStreet);
		System.assertEquals(acct1.BillingStreet,     oppProdRec.Opportunity__r.Account.BillingStreet);
		System.assertNotEquals(null,                 oppProdRec.Opportunity__r.Billing_Street__c);
		System.assertNotEquals(acct1.BillingStreet,  oppProdRec.Opportunity__r.Billing_Street__c);

		// validate that the shipping addresses copied over
		System.assertEquals(true,                    oppProdRec.Opportunity__r.Custom_Physical_Address__c);
		System.assertNotEquals(null,                 oppProdRec.Opportunity__r.Account.ShippingStreet);
		System.assertEquals(acct1.ShippingStreet,    oppProdRec.Opportunity__r.Account.ShippingStreet);
		System.assertNotEquals(null,                 oppProdRec.Opportunity__r.Physical_Street__c);
		System.assertNotEquals(acct1.ShippingStreet, oppProdRec.Opportunity__r.Physical_Street__c);
	}

	static testMethod void testExtenderPreSave() {
		Account acct1 = createTestAccount('Unit Test Account 1');
		insert acct1;

		Opportunity opp1 = createTestOpp('Unit Test Opp 1', acct1.Id);
		insert opp1;

		Opp_Product__c oppProd1 = createTestOppProd(opp1.Id);
		insert oppProd1;

		PageReference testPr = new PageReference('/apex/TestPage');
		testPr.getParameters().put('id', oppProd1.Id);
		Test.setCurrentPage(testPr);
		ApexPages.StandardController stdController = new ApexPages.StandardController(oppProd1);
		TestExtension extension = new TestExtension(stdController);
		OppProdSE2Extender extender = extension.getExtender();

		Opp_Product__c oppProdRec = (Opp_Product__c) extension.mainRecord;
		extender.useExistingBilling = false;
		extender.useExistingPhysical = false;
		oppProdRec.Opportunity__r.Billing_Street__c = '321 Another St. Unit B';
		oppProdRec.Opportunity__r.Physical_Street__c = '321 Another St. Unit P';

		extender.preSave();

		opp1 = loadOpportunity(opp1.Id);
		System.assertEquals(true, opp1.Custom_Billing_Address__c);
		System.assertEquals(true, opp1.Custom_Physical_Address__c);
		System.assertNotEquals(acct1.BillingStreet, opp1.Billing_Street__c);
		System.assertNotEquals(acct1.ShippingStreet, opp1.Physical_Street__c);
	}

	static testMethod void testExtenderPreSaveWithoutUseExistingChanges() {
		Account acct1 = createTestAccount('Unit Test Account 1');
		insert acct1;

		Opportunity opp1 = createTestOpp('Unit Test Opp 1', acct1.Id);
		insert opp1;

		Opp_Product__c oppProd1 = createTestOppProd(opp1.Id);
		insert oppProd1;

		PageReference testPr = new PageReference('/apex/TestPage');
		testPr.getParameters().put('id', oppProd1.Id);
		Test.setCurrentPage(testPr);
		ApexPages.StandardController stdController = new ApexPages.StandardController(oppProd1);
		TestExtension extension = new TestExtension(stdController);
		OppProdSE2Extender extender = extension.getExtender();

		Opp_Product__c oppProdRec = (Opp_Product__c) extension.mainRecord;
		oppProdRec.Opportunity__r.Billing_Street__c = '321 Another St. Unit B';
		oppProdRec.Opportunity__r.Physical_Street__c = '321 Another St. Unit P';

		extender.preSave();

		opp1 = loadOpportunity(opp1.Id);
		System.assertEquals(false, opp1.Custom_Billing_Address__c);
		System.assertEquals(false, opp1.Custom_Physical_Address__c);
		System.assertEquals(null, opp1.Billing_Street__c);
		System.assertEquals(null, opp1.Physical_Street__c);
	}

	public static void TestExtenderInstance(Type extenderType) {
		Account acct1 = createTestAccount('Unit Test Account 1');
		insert acct1;

		Opportunity opp1 = createTestOpp('Unit Test Opp 1', acct1.Id);
		insert opp1;

		Opp_Product__c oppProd1 = createTestOppProd(opp1.Id);
		insert oppProd1;

		PageReference testPr = new PageReference('/apex/TestPage');
		testPr.getParameters().put('id', oppProd1.Id);
		Test.setCurrentPage(testPr);
		ApexPages.StandardController stdController = new ApexPages.StandardController(oppProd1);

		TestExtension extension = new TestExtension(stdController, extenderType);
		System.assertNotEquals(null, extension);
		System.assertNotEquals(null, extension.getExtender());
	}

	static testMethod void testTestExtenderInstance() {
		OppProdSE2ExtenderTests.TestExtenderInstance(TestExtender.class);
	}

	private static Opportunity loadOpportunity(Id oppId) {
		return [SELECT Id, Custom_Billing_Address__c, Billing_Street__c, Custom_Physical_Address__c, Physical_Street__c FROM Opportunity WHERE Id = :oppId];
	}

	private static Account createTestAccount(String name) {
		return new Account(
			Name = name,
			RecordTypeId = AccountDealer.Id,
			BillingStreet = '123 Some St. Unit B',
			BillingCity = 'Anytown',
			BillingState = 'CA',
			BillingPostalCode = '90030',
			ShippingStreet = '123 Some St. Unit S',
			ShippingCity = 'Anytown',
			ShippingState = 'CA',
			ShippingPostalCode = '90030',
			SVOC_Id__c = '' + Math.mod(Crypto.getRandomInteger(), 10000)	// defeat new acct address update workflow
		);
	}

	private static Opportunity createTestOpp(String name, Id acctId) {
		return new Opportunity(
			Name = name,
			StageName = 'Prospecting',
			CloseDate = System.today(),
			AccountId = acctId
		);
	}

	private static Opp_Product__c createTestOppProd(Id oppId) {
		return new Opp_Product__c(
			Opportunity__c = oppId
		);
	}

	public static RecordType AccountDealer { get { return getRecordType('Account', '', 'Dealer'); } }
	
	private static Map<String, RecordType> rtNameMap;
	
	private static RecordType getRecordType(String obj, String nsPrefix, String devName) {
		String key = obj + '.' + (nsPrefix != null ? nsPrefix : '') + '.' + devName;

		if(rtNameMap == null) {
			loadRecordTypes();
		}

		return rtNameMap.get(key.toLowerCase());
	}

	private static void loadRecordTypes() {
		Set<String> objs = new Set<String> { 
			'Account'
		};
		rtNameMap = new Map<String, RecordType>();

		for(RecordType rt : [SELECT Id, sObjectType, Name, DeveloperName, NamespacePrefix FROM RecordType WHERE sObjectType IN :objs]) {
			String key = rt.sObjectType + '.' + (rt.NamespacePrefix != null ? rt.NamespacePrefix : '') + '.' + rt.DeveloperName;
			rtNameMap.put(key.toLowerCase(), rt);
		}
	}

	public class TestExtension extends SkyEditor2.SkyEditorPageBaseWithSharing {
		public TestExtension(ApexPages.StandardController stdController) {
			this(stdController, OppProdSE2Extender.class);
		}

		public TestExtension(ApexPages.StandardController stdController, Type extenderType) {
			super(stdController);

			mainSObjectType = Opp_Product__c.SObjectType;
			setPageReferenceFactory(new PageReferenceFactory());

			mainQuery = new SkyEditor2.Query('Opp_Product__c');
			mainQuery.addField('Name');
			mainQuery.addWhere('Id', mainRecord.Id, SkyEditor2.WhereOperator.Eq);
			mainQuery.limitRecords(1);

			mode = SkyEditor2.LayoutMode.LayoutFree;
			queryMap = new Map<String, SkyEditor2.Query>();

			extender = (OppProdSE2Extender) extenderType.newInstance();
			OppProdSE2Extender genericExtenter = getExtender();
			genericExtenter.construct((SkyEditor2.SkyEditorPageBaseWithSharing) this);
			init();
			extender.init();
		}

		public OppProdSE2Extender getExtender() {
			return (OppProdSE2Extender) extender;
		}
	}

	public class TestExtender extends OppProdSE2Extender {
		public TestExtender() {}

		public TestExtender(TestExtension extension) {
			super(extension);
		}
	}

	with sharing class PageReferenceFactory implements SkyEditor2.PageReferenceFactory.Implementation {
		public PageReference newPageReference(String url) {
			return new PageReference(url);
		}
	}
}