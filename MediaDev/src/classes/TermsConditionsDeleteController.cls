public class TermsConditionsDeleteController {

    public TermsConditionsDeleteController(ApexPages.StandardController controller) {
        this.controller = controller;
    }
    
    //Redirects Delete button/link to custom visual force page to prevent deletion after a T&C has been created
    public PageReference getRedir() {
 
        Terms_Conditions__c t = [Select id, agreement_status__c From Terms_Conditions__c Where Id = :ApexPages.currentPage().getParameters().get('id')];
 
        PageReference newPage;
        newPage = Page.TermsConditionsPageSigned;
        newPage.getParameters().put('id', t.id);
        return newPage.setRedirect(true);
 
    }
 
    private final ApexPages.StandardController controller;

}