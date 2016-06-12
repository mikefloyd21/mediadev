public class TermsConditionsEditController {

    public TermsConditionsEditController(ApexPages.StandardController controller) {
        this.controller = controller;
    }
    
    //Redirects edit button/link to prevent edit capability after T&C has been sent to EchoSign for signature
    public PageReference getRedir() {
 
        Terms_Conditions__c t = [Select id, agreement_status__c From Terms_Conditions__c Where Id = :ApexPages.currentPage().getParameters().get('id')];
 
        PageReference newPage;
 
        if (t.agreement_status__c == 'Out for Signature') {
            newPage = Page.TermsConditionsPageSigned;
        } else {
            newPage = Page.TermsConditionsPageEdit;
        }
 
        newPage.getParameters().put('id', t.id);
        return newPage.setRedirect(true);
 
    }
 
    private final ApexPages.StandardController controller;

}