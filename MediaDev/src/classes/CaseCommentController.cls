public class CaseCommentController {
    public List<Case> mCaseComments {get;set;}
    public List<Contract> mContracts {get;set;}
    List<Case> tempCase;
    // case field for contract is Contract__c
    // is this a case or a contract
    // B-08350: For order entry cases find all comments on contracts and cases related to order,
    // otherwise find only cases related to same contract
    public CaseCommentController(ApexPages.StandardController controller) 
    {

        Id currCaseId = ApexPages.CurrentPage().getparameters().get('Id');
        // select contracts related to this case
        // then get all case comments from those contracts
        // B-08350 - use order id only for oreder entry cases
    	RecordType rt = [select Id, Name from RecordType where Name = 'ATG Order Entry' and SobjectType = 'Case'];    
        List <Case> esoInfo = [select Id, ATC_Order_Sys_ID__c, Contract__c, RecordTypeId from Case where Id =: currCaseId LIMIT 1];
        if (!esoInfo.isEmpty()) //we have the case info needed
        {
            if (esoInfo[0].ATC_Order_Sys_ID__c != null && esoInfo[0].RecordTypeId == rt.Id)
            {
        		mContracts = [Select Id, ATC_Order_Sys_ID__c, ContractNumber, Owner.Name, CreatedDate, ATC_Contract_Info__c from Contract where ATC_Order_Sys_ID__c =: esoInfo[0].ATC_Order_Sys_ID__c];

                system.debug('contracts:'+mContracts);
        		mCaseComments = [Select Id, Contract__c, Owner.Name, Casenumber, CreatedDate, ClosedDate,Task_Type__c,  (Select CommentBody From CaseComments) From Case where Contract__c in: mContracts  ];

            }
            else if(esoInfo[0].Contract__c != null)
            {
        		mContracts = [Select Id, ATC_Order_Sys_ID__c, ContractNumber, Order_Cases__c, Owner.Name, CreatedDate, ATC_Contract_Info__c from Contract where Id =: esoInfo[0].Contract__c];
                system.debug('contracts:'+esoInfo[0].Contract__c);
        		mCaseComments = [Select Id, Contract__c, Owner.Name, Casenumber, CreatedDate, ClosedDate,Task_Type__c,  (Select CommentBody From CaseComments) From Case where Contract__c in: mContracts OR Id =: mContracts[0].Order_Cases__c ];
            }

        }
    }
}