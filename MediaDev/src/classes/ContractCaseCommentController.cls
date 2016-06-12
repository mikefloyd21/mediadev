public class ContractCaseCommentController {

    public List<Case> mCaseComments {get;set;}
    // case field for contract is Contract__c
    // is this a case or a contract
    public ContractCaseCommentController(ApexPages.StandardController controller) 
    {

        Id currContractId = ApexPages.CurrentPage().getparameters().get('Id');
        List <Contract> currContract = [select Id,Order_Cases__c from Contract where Id =: currContractId LIMIT 1];
        // Made change for Story B-08350 because if >1 contract per order, not all contracts were showing order case comment.
        //mCaseComments = [Select Id, Contract__c, Owner.Name, Casenumber, CreatedDate, ClosedDate,Task_Type__c, (Select CommentBody From CaseComments) From Case where Contract__c =: currContractId  ];
        mCaseComments = [Select Id, Contract__c, Owner.Name, Casenumber, CreatedDate, ClosedDate,Task_Type__c,  (Select CommentBody From CaseComments) From Case where Contract__c =: currContractId OR Id =: currContract[0].Order_Cases__c ];
    }
}