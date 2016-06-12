public class dispatcherTaskEditController {

    public dispatcherTaskEditController(ApexPages.StandardController controller) {
        this.controller = controller;
    }
    
    public PageReference getRedir() {
 
        Task t = [Select id, status From Task Where Id = :ApexPages.currentPage().getParameters().get('id')];
 
        PageReference newPage;
 
        if (t.status == 'Completed') {
            newPage = Page.TaskPageCompleted;
        } else {
            newPage = Page.TaskPageEdit;
        }
 
        newPage.getParameters().put('id', t.id);
        return newPage.setRedirect(true);
 
    }
 
    private final ApexPages.StandardController controller;

}