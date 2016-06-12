public with sharing class MassCloseCasesController {


    private Boolean showPageMessages = false;
    //private String statusValue = '--None--';
    private List<Id> caseIds;
    private Case initCase = new Case(Status = 'Closed');
    private CaseComment initCaseComment = new CaseComment();
    private String retURL;
    private final List<Case> cases;
    private ApexPages.StandardSetController pController;

    public MassCloseCasesController(ApexPages.StandardSetController pController) {
        this.showPageMessages = false;
        this.pController = pController;
        this.cases = (List<Case>)pController.getSelected();
        System.debug('***cases : ' + this.cases);
        retURL = ApexPages.currentPage().getParameters().get(retURL);    
    }

    public PageReference save() {
    
        try {
            List<Case> selectedCases = (List<Case>) pController.getSelected();
            system.debug('*** selected cases : ' + selectedCases );

            if (this.cases != null && !this.cases.isEmpty()) {
                
                List<Case> casesToUpdate = new List<Case>();
                List<CaseComment> caseCommentsToInsert = new List<CaseComment>();
                
                for (Case caseList : this.cases) {
                    
                    Case updateCase = this.initCase.clone();
                    updateCase.Id = caseList.Id;
                    casesToUpdate.add(updateCase);
                    
                    CaseComment insertCaseComment = this.initCaseComment.clone();
                    insertCaseComment.ParentId = caseList.Id;
                    caseCommentsToInsert.add(insertCaseComment);
                    system.debug('***** updateCase ' + updateCase + 'insertCaseComment ' +insertCaseComment );
                }
                
                if (!casesToUpdate.isEmpty()) {
                    update casesToUpdate;
                    system.debug('**** casesToUpdate' + casesToUpdate);
                }
                
                if (!caseCommentsToInsert.isEmpty()) {
                    insert caseCommentsToInsert;
                    system.debug('**** caseCommentsToInsert' + caseCommentsToInsert);
                }
                
                ApexPages.Message successMsg = new ApexPages.Message(ApexPages.Severity.INFO, 'Save Successful!');
                ApexPages.addMessage(successMsg);
                this.showPageMessages = true;
                system.debug('**** successMsg ' + successMsg );
                return new Pagereference('/500');            
            } else {
                
                ApexPages.Message errorMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'No Cases selected. Please return to the grid and select Cases to continue.');
                ApexPages.addMessage(errorMsg);
                this.showPageMessages = true;
                return null;
            }
            
        } catch (DMLException ex) {
            String errorMessage = 'Error on selected case, please go to case detail page to fix errors.';
            for (Integer i = 0; i < ex.getNumDml(); i++) {
               Case errorcase= [select id, casenumber from Case where id = : ex.getDmlId(i)];
               errorMessage = errorMessage + ' Errored Case ID:'+ errorcase.casenumber +'\n';
               system.debug('LYNN:' + errorMessage );
            }
            system.debug('LYNN:' + errorMessage );
            ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR,errorMessage));
            //this.showPageMessages = true;
            return null;
        }
        catch (Exception e){
           system.debug(e.getMessage());
        }
        
        return new Pagereference('/500'); 
    
    }

    public PageReference doCancel(){
        this.showPageMessages = false;
        return new Pagereference('/500'); 
    }

    public Boolean getShowPageMessages() {
        return showPageMessages;
    }

    public Case getInitCase() {
        return this.initCase;
    }
    
    public CaseComment getInitCaseComment() {
        return this.initCaseComment;
    }
    
    public void setInitCase(Case pValue) {
        this.initCase = pValue;
    }
    
    public void setInitCaseComment(CaseComment pValue) {
        this.initCaseComment = pValue;
    }
    }