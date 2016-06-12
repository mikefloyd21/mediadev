/*** 
    Author Name:
    Purpose: 
    Date: 
    Class Name:
    Test Class Name:
    Change History: 
***/

public with sharing class UpdateNewDMRProductsGraphicsController {

    // Variable Declaration
    private final Case DMRcase;
    public string Page{get;set;}
    public list<WrapperContracts> WrapperContractList{get;set;}
    public list<WrapperContracts> SelectedWrapperList {get;set;}
    public list<WrapperContracts> SelectedWrapperList1 = new  list<WrapperContracts>();
    public boolean block1{get;set;}
    public boolean block2{get;set;}
    public Boolean SelectAll{get;set;}
    public Map<Id,Id> CCAMap = new Map<Id,Id>();
    public Account Acc;
    public Map<Id,Case> CaseMap ;
    public Map<string,Id> QueueMap = new Map<string,Id>();
    public Boolean Check;
    public Id UpdateDMRId;
    public boolean err;
    public string CaseNumber ;
    public ApexPages.StandardController controller {get; set;}    
    
    // Constructor
    public UpdateNewDMRProductsGraphicsController(ApexPages.StandardController controller) 
    {      
        if(!Test.isRunningTest())
        controller.addFields(new List<String> {'Ad_Type__c','Logo__c','Template__c','Make_1__c','Make_2__c','Make_3__c','Make_4__c','Status' });
        this.DMRcase = (Case)controller.getRecord();       
        SelectAll = false;
        err = false;
        SelectedWrapperList = new list<WrapperContracts>();
        WrapperContractList = new list<WrapperContracts>();      
       // CaseMap1 = new Map<String,List<Case>>();
        Check = false;
        page = ApexPages.CurrentPage().getParameters().get('page');
        CaseMap = new Map<Id,Case>();
        Acc = [select id,SVOC_Region__c from Account where id=: DMRcase.AccountID];         
        //Getting Record Types
        UpdateDMRId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('ATC DMR - Update').getRecordTypeId();
        //Getting Queue Ids and constructing Map   
        for(QueueSobject  que : [ Select Id, SobjectType, QueueId, Queue.Name from QueueSobject where SobjectType = 'Case' and (Queue.Name= 'DMD Rework' or Queue.Name = 'DMD Major Reworks' or Queue.Name = 'KBB Showcase Reworks')])
            QueueMap.put(que.Queue.Name,que.QueueId); 
        for(Case cas:  [select id,CaseNumber ,OwnerId,Owner.Name,Owner.UserRole.Name,Alpha_Header__c,Alpha_Liner__c,Alpha_Tile__c,Dealer_Image__c,Leaderboard__c,Logo_Tile__c,Overlay_Image__c,SCA_Tile__c,Skyscraper__c 
            ,Ad_Type__c,Logo__c,Template__c,Make_1__c,Make_2__c,Make_3__c,Make_4__c,Showcase__c from case where AccountId =: Acc.Id and Status != 'Closed' and RecordTypeId =: UpdateDMRId and Id !=: DMRCase.Id]){
                    CaseMap.put(cas.id,cas); 
                    if(cas.owner.name == 'DMD Rework' || cas.owner.name == 'DMD Major Reworks')
                        CaseNumber = cas.CaseNumber;
                    if(cas.Owner.UserRole != null && cas.Owner.UserRole.Name.contains('DMD'))
                        CaseNumber  = cas.CaseNumber ;                    
        }        
        for(Case_Contract_Association__c   cca : [select id,Contract__c,Case__c from Case_Contract_Association__c where Case__c =: DMRCase.Id]){
            CCAMap.put(cca.Contract__c,cca.Contract__c);
        }
        for( Contract con: [select id,ContractNumber,AccountId,Account.Name,RecordType.Name,Status,ATC_Contract_Status__c,ATC_Contract_Sys_ID__c,ATC_Package_Name__c,Make__c,DMA__c,Co_Op__c,StartDate from Contract where Id=: CCAMap.keyset() ]){
               SelectedWrapperList.add(new WrapperContracts(false,con));
        }
         if(page == 'contract'){
            AddContracts();
        }
        else{
             block1 = true;
             block2 = false;
        }        
    }
   
    public pagereference submit() {
        // If Update - make sure one of the checkboxes are checked
        //   Alpha_Header__c,Alpha_Liner__c,Alpha_Tile__c,Dealer_Image__c,Leaderboard__c,Logo_Tile__c,
        //   Overlay_Image__c,SCA_Tile__c,Skyscraper__c
        // Check that description is populated regardless of whether it is update or new    
        // When I select the button to submit the case and the DMR is on an account that is in a Major Accounts region(35,43,44)
        // Then The case owner is changed to the DMD Major Reworks queue And the case status is "New"
        // Acceptance Criteria 4:Given I have selected "Update Product Graphics" button on the case page and completed all required fields
        // When I select the Submit Button and there is already a DMR case not in a closed status on the account
        // Then I receive an error message that only one Update Product Graphics DMR can be open at once. and the case status, owner, or anything else is triggered.
        // Acceptance Criteria 5:Given I have selected "Update Product Graphics" button on the account page
        // and completed all required fields
        // When I select the Submit Button and the DMR is on an account that is not in a Major Accounts region(35,43,44)
        // Then The case is assigned to the DMD Rework queue and the case status is "New"
        // Acceptance Criteria 6:
        // Given I have selected "New Product Graphics" button on the account page and completed all required fields
        // When I select the button to submit the case Then The case status is updated to closed status and I am able to access it from the account from the related list
        
        // Check whether atleast one checkbox is selected or not
        err = false; 
        PageReference pageRef;
        check = false;
        if(DMRCAse.Alpha_Header__c == true || DMRCAse.Alpha_Liner__c == true || DMRCAse.Alpha_Tile__c == true || DMRCAse.Dealer_Image__c == true || DMRCAse.Leaderboard__c == true
                || DMRCAse.Logo_Tile__c == true || DMRCAse.Overlay_Image__c == true || DMRCAse.SCA_Tile__c == true || DMRCAse.Skyscraper__c == true)
               Check = true;                  
        // when click on submit buuton,conditions  for update DMR Record Type
        if( UpdateDMRId  != null && DMRCAse.RecordTypeId == UpdateDMRId ){
            if(SelectedWrapperList == null ||  SelectedWrapperList.size() == 0){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,' Please add atleast one contract'));
                pageRef = ApexPages.currentPage();            
                err = true;
             }
            if(check == false && page != 'contract'){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,' Please select atleast one Ad'));
                pageRef = ApexPages.currentPage();            
                err = true;
            }
            if(DMRCAse.Description == null || DMRCase.Description == ' '){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,' Please enter Description'));
                pageRef = ApexPages.currentPage();            
                err = true;
            }
            if(err == false && check == true && CaseMap.size() > 0 &&  CaseNumber != null && page != 'contract'){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'A DMR case is already in progress on the account. If you need to make updates/changes to the existing request, please update ('+casenumber+')'));
                pageRef = ApexPages.currentPage();            
                err = true;
            }
            
        } 
        // when click on submit button,if there are no error messages 
        if(err == false){
            //Insert Contract List
            list<Case_Contract_Association__c> CCAList = new list<Case_Contract_Association__c>();
            Case_Contract_Association__c case_cont;
            for(WrapperContracts swc : SelectedWrapperList1 ){
                case_cont = new Case_Contract_Association__c();
                case_cont.Case__c = DMRcase.Id;
                case_cont.Contract__c = swc.Contr.Id;
                CCAList.add(case_cont);
            }
            if(CCAList.size()>0)
                insert CCAList; 
            // for Update DMR Record Type, Based on Acceptance criteria case should assign to Queues
            if(page != 'contract' && DMRCAse.RecordTypeId == UpdateDMRId){
                if(Check == true){  
                    //Acceptance Criteria 6 - Update DMR - Assign cases to queues (Only ATC)
                    if(Acc.SVOC_Region__c != '43' && Acc.SVOC_Region__c != '44' && Acc.SVOC_Region__c != '35'){
                        if(QueueMap.ContainsKey('DMD Rework')){
                            DMRCAse.OwnerId = QueueMap.get('DMD Rework');
                            DMRCase.Status = 'New';
                        }  
                    }
                    else if(Acc.SVOC_Region__c == '43' || Acc.SVOC_Region__c == '44' || Acc.SVOC_Region__c == '35'){
                         if(QueueMap.ContainsKey('DMD Major Reworks')){
                             DMRCAse.OwnerId = QueueMap.get('DMD Major Reworks'); 
                             DMRCase.Status = 'New';
                        }  
                    }                 
                }               
            }           
            update  DMRcase;
            pageRef = new PageReference('javascript:window.close()'); 
        }
        return pageRef;
    }
    //wrapper class
    public class WrapperContracts{
        public boolean check{get;set;}
        public Contract Contr{get;set;}
        public WrapperContracts(Boolean che, Contract cont){
            check = che;
            Contr = cont;
        }
     }
     //when click on Add Contacts button in submit DMR page
     public void AddContracts(){   
         WrapperContractList.clear();     
         for( Contract con: [select id,ContractNumber,AccountId,Account.Name,RecordType.Name,Status,ATC_Contract_Status__c,ATC_Package_Name__c,Make__c,ATC_Contract_Sys_ID__c,DMA__c,Co_Op__c,StartDate from Contract where AccountId=: DMRCase.accountId and (ATC_Contract_Status__c = 'DELIVERED' OR ATC_Contract_Status__c = 'PENDING_CANCEL')]){
                if(!CCAMap.containskey(con.Id))
                    WrapperContractList.add(new WrapperContracts(false,con));
        }
        block1 = false;
        block2 = true;
     }     
     public void CancelContracts(){
         WrapperContractList.clear();
         block1 = true;
         block2 = false;
     } 
     //when click on Add button in submit DMR page
     public void AddContractsToPage(){
        
         if(WrapperContractList == null || WrapperContractList.size()==0){
             ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,' Please  select the contracts you want to add'));
         }else{
             SelectedWrapperList1 = new list<WrapperContracts>();
             for(WrapperContracts wc1: WrapperContractList){
                 if(wc1.check == true)
                     SelectedWrapperList1.add(wc1);
             }
             if(SelectedWrapperList1 == null ||  SelectedWrapperList1.size() == 0)
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,' Please select atleast one contract'));
            
            else{
                SelectedWrapperList.addAll(SelectedWrapperList1);
                if(page != 'contract'){
                block1 = true;
                block2 = false;
                }                
             }
         }
     }
     // when click on check box in header section to select all contracts
     public void SelectAll(){
          for(WrapperContracts wc1: WrapperContractList){
                 wc1.check = SelectAll;
          }
     }
     //when clcik on Save button in Add Contracts Page
     public pagereference SaveContracts(){
         AddContractsToPage();
         Pagereference pagref = Submit();
         return pagref ;
     }
     //when click on Cancel button, window will close
     public pagereference Cancel_SubmitDMR(){
         return new PageReference('javascript:window.close()');
     }
     public pagereference New_Submit_DMR(){
          if(DMRCase.Status != 'Closed')
              DMRCase.Status = 'Closed';
           update  DMRcase;
           return new PageReference('javascript:window.close()'); 
     }
     public void addContract(){
     }
}