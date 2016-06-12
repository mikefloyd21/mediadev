public with sharing class dispatcherEventEditController {


   public dispatcherEventEditController(ApexPages.StandardController controller) {
        this.controller = controller;
    }
    
    public PageReference getRedir() {
 
        Event e = [Select id, Meeting_Status__c From Event Where Id = :ApexPages.currentPage().getParameters().get('id')];
 
        PageReference newPage;
 
        if (e.Meeting_Status__c == 'Completed') {
            newPage = Page.EventPageCompleted;
        } else {
            newPage = Page.EventPageEdit;
        }
 
        newPage.getParameters().put('id', e.id);
        return newPage.setRedirect(true);
 
    }
 
    private final ApexPages.StandardController controller;

}