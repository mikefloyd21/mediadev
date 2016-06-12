public with sharing class AddContractsToCase_Cntrl {
    public Case Case1{get;set;}
    public list<WrapperContracts> WrapperContractList{get;set;}
    public list<WrapperContracts> SelectedWrapperList {get;set;}
    public Map<Id,Id> CCAMap = new Map<Id,Id>();
    public Boolean close{get;set;}
    public boolean SelectAll{get;set;}
    
    public AddContractsToCase_Cntrl (){
        close  = false;
        SelectAll = false;
        WrapperContractList = new list<WrapperContracts>();        
        Case1 = [select id,AccountId from Case where id=: ApexPages.CurrentPage().getParameters().get('Id')];
        for(Case_Contract_Association__c   cca : [select id,Contract__c,Case__c from Case_Contract_Association__c where Case__c =: Case1.Id])
            CCAMap.put(cca.Contract__c,cca.Contract__c);
        for( Contract con: [select id,ContractNumber,AccountId,Account.Name,RecordType.Name,Status,ATC_Contract_Status__c,ATC_Package_Name__c,Make__c,DMA__c,Co_Op__c,StartDate from Contract where AccountId=: Case1.accountId and ATC_Contract_Status__c = 'DELIVERED']){
                if(!CCAMap.containskey(con.Id))
                    WrapperContractList.add(new WrapperContracts(false,con));
        }
    }
    public class WrapperContracts{
        public boolean check{get;set;}
        public Contract Contr{get;set;}
        public WrapperContracts(Boolean che, Contract cont){
            check = che;
            Contr = cont;
        }
     }
     public pagereference AddContracts(){
        
         if(WrapperContractList == null){
             ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,' Please  select the contracts you want to add'));
             close = true;
         }else{
             SelectedWrapperList = new list<WrapperContracts>();
             for(WrapperContracts wc1: WrapperContractList){
                 if(wc1.check == true)
                     SelectedWrapperList.add(wc1);
             }             
         }
         if(SelectedWrapperList == null ||  SelectedWrapperList.size() == 0){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,' Please add atleast one contract'));
            PageReference pageRef = ApexPages.currentPage();
            return pageRef;
        }
        else{
            list<Case_Contract_Association__c> CCAList = new list<Case_Contract_Association__c>();
            Case_Contract_Association__c case_cont;
            for(WrapperContracts swc : SelectedWrapperList ){
                case_cont = new Case_Contract_Association__c();
                case_cont.Case__c = case1.Id;
                case_cont.Contract__c = swc.Contr.Id;
                CCAList.add(case_cont);
            }
            if(CCAList.size()>0){
                insert CCAList;
                return new PageReference('javascript:window.close()');
            }
        }
        system.debug('------------close----------'+close);
        return null;

     }

}