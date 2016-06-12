@isTest
private class UpdateNewDMRProdGraphicsController_Test{
   private static final Id caseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('ATC DMR - Update').getRecordTypeId();
   private static final  QueueSOBject que = [Select Id, SobjectType, QueueId, Queue.Name from QueueSobject where SobjectType = 'Case' and Queue.Name= 'DMD Rework'];
  
    static testMethod void myUnitTest() {       
          Account acc = new Account(name='test account');
          insert acc;
          Case Cas1= new Case(AccountId=acc.Id,RecordTypeId = caseRecordTypeId );
          insert cas1;
          Case Cas2= new Case(AccountId=acc.Id,RecordTypeId = caseRecordTypeId);
          insert cas2;
          ApexPages.StandardController sc = new ApexPages.StandardController(cas1);
          UpdateNewDMRProductsGraphicsController cls1 = new UpdateNewDMRProductsGraphicsController(sc); 
          cls1.submit();
          Contract cont = new Contract(AccountId= acc.id,ATC_Contract_Status__c = 'DELIVERED');
          insert cont;
          cls1.CancelContracts();
          cls1.AddContractsToPage();
          cls1.AddContracts();
          cls1.AddContractsToPage();
          cls1.SelectAll = true;
          cls1.SelectAll();
          cls1.SaveContracts();
          cls1.DMRCase.Alpha_Header__c  = true;
          cls1.DMRCase.Description = 'tesrd';
          cls1.submit();
          cas1.Status = 'Closed';
          update cas1;
          acc.SVOC_Region__c = '43';
          update acc;
          Case cas3 = new Case(AccountId=acc.Id,RecordTypeId = caseRecordTypeId,Description='test',Alpha_Header__c  = true);
          insert cas3;
          Case_Contract_Association__c cca = new Case_Contract_Association__c(Contract__c = cont.id,Case__c = cas3.Id);
          insert cca;
          ApexPages.StandardController sc1 = new ApexPages.StandardController(cas3);
          UpdateNewDMRProductsGraphicsController cls2 = new UpdateNewDMRProductsGraphicsController(sc1);
          cls2.submit();
          Case cas4 = new Case(AccountId=acc.Id,RecordTypeId = caseRecordTypeId,Description='test',Alpha_Header__c  = true);
          insert cas4;
          Case_Contract_Association__c cca1 = new Case_Contract_Association__c(Contract__c = cont.id,Case__c = cas4.Id);
          insert cca1;
          ApexPages.StandardController sc3 = new ApexPages.StandardController(cas4);
          UpdateNewDMRProductsGraphicsController cls3 = new UpdateNewDMRProductsGraphicsController(sc3);
          cls3.submit();
          ApexPages.CurrentPage().getParameters().put('page','contract');
          cls3 = new UpdateNewDMRProductsGraphicsController(sc3);
          cls3.Cancel_SubmitDMR();
          cls3.New_Submit_DMR();
          cls3.addContract();
    }
}