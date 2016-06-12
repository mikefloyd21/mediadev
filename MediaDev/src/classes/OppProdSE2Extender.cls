public with sharing virtual class OppProdSE2Extender extends SkyEditor2.Extender {
	public Boolean useExistingBilling { get; set; }
	public Boolean useExistingPhysical { get; set; }

	private SkyEditor2.SkyEditorPageBaseWithSharing extension;
	
	public OppProdSE2Extender() {}
	
	public OppProdSE2Extender(SkyEditor2.SkyEditorPageBaseWithSharing extension) {
		construct(extension);
	}

	public void construct(SkyEditor2.SkyEditorPageBaseWithSharing extension) {
		this.extension = extension;
		
		if(extension != null) {
			SkyEditor2.Query mainQuery = this.extension.mainQuery;

			if(mainQuery != null) {
				mainQuery.addFieldAsOutput('Opportunity__c');
				mainQuery.addFieldAsOutput('Opportunity__r.AccountId');
				mainQuery.addFieldAsOutput('Opportunity__r.Account.Name');
				mainQuery.addFieldAsOutput('Opportunity__r.Account.SVOC_Id__c');
				mainQuery.addFieldAsOutput('Opportunity__r.Account.Dealer_Nameplates__c');
				mainQuery.addField('Bill_To_ID__c');
				mainQuery.addField('Invoice_Name__c');

				mainQuery.addFieldAsOutput('Opportunity__r.Account.BillingStreet');
				mainQuery.addFieldAsOutput('Opportunity__r.Account.BillingCity');
				mainQuery.addFieldAsOutput('Opportunity__r.Account.BillingState');
				mainQuery.addFieldAsOutput('Opportunity__r.Account.BillingPostalCode');

				mainQuery.addField('Opportunity__r.Custom_Billing_Address__c');
				mainQuery.addField('Opportunity__r.Billing_Street__c');
				mainQuery.addField('Opportunity__r.Billing_City__c');
				mainQuery.addField('Opportunity__r.Billing_State__c');
				mainQuery.addField('Opportunity__r.Billing_Zip_Postal_Code__c');

				mainQuery.addFieldAsOutput('Opportunity__r.Account.ShippingStreet');
				mainQuery.addFieldAsOutput('Opportunity__r.Account.ShippingCity');
				mainQuery.addFieldAsOutput('Opportunity__r.Account.ShippingState');
				mainQuery.addFieldAsOutput('Opportunity__r.Account.ShippingPostalCode');

				mainQuery.addField('Opportunity__r.Custom_Physical_Address__c');
				mainQuery.addField('Opportunity__r.Physical_Street__c');
				mainQuery.addField('Opportunity__r.Physical_City__c');
				mainQuery.addField('Opportunity__r.Physical_State__c');
				mainQuery.addField('Opportunity__r.Physical_Zip_Postal_Code__c');

				mainQuery.addField('Opportunity__r.Phone__c');
				mainQuery.addField('Opportunity__r.Fax__c');
				mainQuery.addField('Opportunity__r.Contact_Email__c');
				mainQuery.addField('Opportunity__r.Contact_Name__c');
				mainQuery.addField('Opportunity__r.Contact_Title__c');
				mainQuery.addFieldAsOutput('Used_Car_Inventory_Source__c');
			}
		}
	}

	public override virtual void init() {
		if(isOppProductExtension()) {
			Opp_Product__c record = (Opp_Product__c) extension.mainRecord;

			if(record.Opportunity__r != null) {
				useExistingBilling = !record.Opportunity__r.Custom_Billing_Address__c;
				useExistingPhysical = !record.Opportunity__r.Custom_Physical_Address__c;

				resetAddressFields(record);
			}
		}
	}

	private Boolean isOppProductExtension() {
		return extension != null && extension.mainRecord != null && extension.mainRecord.getSObjectType() == Opp_Product__c.sObjectType;
	}

	private void resetAddressFields(Opp_Product__c record) {
		if(record.Opportunity__r != null) {
			if(useExistingBilling) {
				record.Opportunity__r.Billing_Street__c = record.Opportunity__r.Account.BillingStreet;
				record.Opportunity__r.Billing_City__c = record.Opportunity__r.Account.BillingCity;
				record.Opportunity__r.Billing_State__c = record.Opportunity__r.Account.BillingState;
				record.Opportunity__r.Billing_Zip_Postal_Code__c = record.Opportunity__r.Account.BillingPostalCode;
			}
			
			if(useExistingPhysical) {
				record.Opportunity__r.Physical_Street__c = record.Opportunity__r.Account.ShippingStreet;
				record.Opportunity__r.Physical_City__c = record.Opportunity__r.Account.ShippingCity;
				record.Opportunity__r.Physical_State__c = record.Opportunity__r.Account.ShippingState;
				record.Opportunity__r.Physical_Zip_Postal_Code__c = record.Opportunity__r.Account.ShippingPostalCode;
			}
		}
	}

	public override SkyEditor2.Extender.WizardControl doNext(String id) {
		if(isOppProductExtension()) {
			Opp_Product__c record = (Opp_Product__c) extension.mainRecord;
			resetAddressFields(record);
		}

		return null;
	}

	public override virtual void preSave() {
		String successUrl = doSaveLogic();
		
		if(String.isNotBlank(successUrl)) {
			extension.editTransitionControl = successUrl;
		}
	}

	private String doSaveLogic() {
		String successUrl;

		if(extension != null && extension.mainRecord != null && extension.mainRecord.getSObjectType() == Opp_Product__c.sObjectType) {
			Opp_Product__c record = (Opp_Product__c) extension.mainRecord;
			Boolean updateOpp = record.Opportunity__r != null;
		
			if(updateOpp) {
				// reflip the custom fields before saving
				record.Opportunity__r.Custom_Billing_Address__c = !useExistingBilling;
				record.Opportunity__r.Custom_Physical_Address__c = !useExistingPhysical;
				String billingStreet = record.Opportunity__r.Billing_Street__c;
				String billingCity = record.Opportunity__r.Billing_City__c;
				String billingState = record.Opportunity__r.Billing_State__c;
				String billingZip = record.Opportunity__r.Billing_Zip_Postal_Code__c;
				String physicalStreet = record.Opportunity__r.Physical_Street__c;
				String physicalCity = record.Opportunity__r.Physical_City__c;
				String physicalState = record.Opportunity__r.Physical_State__c;
				String physicalZip = record.Opportunity__r.Physical_Zip_Postal_Code__c;

				if(useExistingBilling) {
					record.Opportunity__r.Billing_Street__c = null;
					record.Opportunity__r.Billing_City__c = null;
					record.Opportunity__r.Billing_State__c = null;
					record.Opportunity__r.Billing_Zip_Postal_Code__c = null;
				}
				
				if(useExistingPhysical) {
					record.Opportunity__r.Physical_Street__c = null;
					record.Opportunity__r.Physical_City__c = null;
					record.Opportunity__r.Physical_State__c = null;
					record.Opportunity__r.Physical_Zip_Postal_Code__c = null;
				}

				update record.Opportunity__r;
				successUrl = '/' + record.Opportunity__c;
			}
		}

		return successUrl;
	}

	// public override virtual void afterSave() {}
	
	/*
	private void addInfo(String msg) {
		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, msg));
	}

	private void addError(String msg) {
		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, msg));
	}
	*/
}