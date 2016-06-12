public class ContractHandlerController{ 
   public static void onBeforeInsert(List<Contract> contractList)
   {  /*  Instead of coding the logic here, call a method by passing contractList  */ 
       updateESOCreatedby(contractList);
   }  
   public static void onBeforeUpdate(List<Contract> contractList, Map<Id, Contract> mapContractOld)
   {  /*  Instead of coding the logic here, call a method by passing contractListand mapContractOld  */   
       updateCaseWithOrderContract(contractList, mapContractOld); 
       updateESOCreatedby(contractList);

   }  
   public static void onAfterInsert(List<Contract> contractList)
   {  /*  Instead of coding the logic here, call a method by passing contractListand   */ 
       addCaseWithOrderContract(contractList); 

   }  
   public static void onAfterUpdate(List<Contract> contractList, Map<Id, Contract> mapContractOld)
   {  /*  Instead of coding the logic here, call a method by passing contractListand and mapContractOld  */    
       createDMDFulfillmentCase(contractList, mapContractOld);
       updateCasePriorityWithContractPriority(contractList, mapContractOld); 
   }  
   public static void updateESOCreatedby(List<Contract> contractList) 
   {   
      for (contract con: contractList)    
      {       
         if (con.eSO_Created_By__c != null)
         { 
              List <User> ownerInfo = [SELECT Id, Net_ID__c from User where Net_ID__c =: con.eSO_Created_By__c LIMIT 1];
              if (!ownerInfo.isEmpty())
              {
                 con.eSO_Created_By_User__c = ownerInfo[0].Id; 
              }
         }
      }
   }
   public static void addCaseWithOrderContract(List<Contract> contractList) 
   {    
      List<case> casesToUpdate = new List<case>();    
      List<contract> contractsToUpdate = new List<contract>();    
      for (contract con: contractList)    
      {       
         if (con.ATC_Order_Sys_ID__c != null)       
         {  //find all cases with this id and update them with this contract id          
            List<Case> allCase = [select Id,Contract__c,Order_Id__c, Priority, RecordTypeId from Case where  Order_Id__c = : con.ATC_Order_Sys_ID__c];          
            system.debug('##### allCase'+ allCase);          
            for (Case cs: allCase)          
            {             
               Case caseUpd = new Case();
               caseUpd.Id = cs.Id;
               system.debug('##### contract'+ con.Id);
               caseUpd.Contract__c = con.Id;
               Contract newCon = new Contract();
               newCon.Id = con.Id;
               newCon.Order_Cases__c = cs.Id;
               if (con.ATC_Priority_Code__c == 'Medium')
                    caseUpd.Priority = 'Low';
               else if (con.ATC_Priority_Code__c == 'High')
                    caseUpd.Priority = 'High';
               contractsToUpdate.add(newCon);           
               casesToUpdate.add(caseUpd);          
               system.debug('##### case update'+ cs);
               system.debug('##### contract update'+ con);
            }                
         }    
      } 
      if (!casesToUpdate.isEmpty())  
        update casesToUpdate; 
      if (!contractsToUpdate.isEmpty())  
        update contractsToUpdate;    
   }  
   public static void updateCaseWithOrderContract(List<Contract> contractList, Map<Id, Contract> mapContractOld) 
   {    
      List<case> casesToUpdate = new List<case>();    
      for (contract con: contractList)    
      {       
         Contract oldContract = mapContractOld.get(con.Id);
        
         if (con.ATC_Order_Sys_ID__c != oldContract.ATC_Order_Sys_ID__c)    //order id has changed   
         {  
            system.debug('##### contract'+ con.Id);
            //find all old cases with this id and remove them from this contract id 
            if (oldContract.ATC_Order_Sys_ID__c != null) 
            {        
               List<Case> allOldCases = [select Id,Contract__c,Order_Id__c from Case where  Order_Id__c = : oldContract.ATC_Order_Sys_ID__c  ];          
               system.debug('##### alloldCase'+ allOldCases);          
               for (Case csOld: allOldCases)          
               {             
                  csOld.Contract__c = null;
                  con.Order_Cases__c = null;  
                  if (csOld.Status != 'Closed')         
                     casesToUpdate.add(csOld);          
               } 
            } 
            //find all cases with this id and update them with this contract id  
            if (con.ATC_Order_Sys_ID__c != null) 
            {                                
               List<Case> allCase = [select Id,Contract__c,Order_Id__c from Case where  Order_Id__c = : con.ATC_Order_Sys_ID__c];          
               system.debug('##### allnewCase'+ allCase);          
               for (Case cs: allCase)          
               {             
                  system.debug('##### contract'+ con.Id);
                  cs.Contract__c = con.Id;
                  con.Order_Cases__c = cs.Id;           
                  if (cs.Status != 'Closed')         
                   casesToUpdate.add(cs);          
               } 
            }               
         }    
      }    
      if (!casesToUpdate.isEmpty())  
        update casesToUpdate; 
   }  
   
   public static void createDMDFulfillmentCase(List<Contract> contractList, Map<Id, Contract> mapContractOld) 
   {
    // generate Case in the DMD Creative Brief queue when co-op is set yes.
    RecordType rt = [select Id, Name from RecordType where Name = 'ATG DMD Fulfillment' and SobjectType = 'Case' limit 1];
    List<Group> dmdQueue= [select Id, Name from Group where Name = 'DMD Creative Brief' and Type = 'Queue' limit 1];   
    Case dmdCase = new Case();  
    for (contract c: contractList)
    {
       Contract oldContract = mapContractOld.get(c.Id);
       // if co-op and contract delivered and contract status has changed then create DMD case
       if (c.Co_Op__c == 'Yes' && c.ATC_Contract_Status__c == 'DELIVERED' && c.ATC_Contract_Status__c !=  oldContract.ATC_Contract_Status__c)
       {
          dmdCase.recordtypeid = rt.id;
          dmdCase.subject = 'Creative Brief for Recent Contract Delivery';
          dmdCase.description =  'Creative brief needed for recent contract delivery';
          if (!dmdQueue.isEmpty()) {
             dmdCase.OwnerId = dmdQueue[0].Id; 
          }   
          dmdCase.contract__c = c.id;
          dmdCase.ATC_Case_Reason__c = 'Dealer Products';
          dmdCase.ATC_Sub_Reason__c = 'Product Changes';
          dmdCase.Priority = 'Low';
          dmdCase.AccountId = c.AccountId;
          dmdCase.ATC_Root_Cause_Temp__c = 'Creative Brief Update';
          insert dmdCase;

          system.debug('DMDcases:'+dmdCase);        
          system.debug('Contract:'+c);
                
       }
    }
    
   }  
// update case priority based on contract priority    
   public static void updateCasePriorityWithContractPriority(List<Contract> contractList, Map<Id, Contract> mapContractOld) 
   {    
      List<case> casesToUpdate = new List<case>();    
      for (contract con: contractList)    
      {       
        // if the contract priority changed then update the cases
        Contract oldContract = mapContractOld.get(con.Id);
        if (con.ATC_Priority_Code__c != oldContract.ATC_Priority_Code__c)       
        {  //find all cases with this id and update them with this contract id          
            List<Case> allCase = [select Id,Contract__c, Priority, Status from Case where  Contract__c = : con.Id];          
            system.debug('##### allCase'+ allCase);          
            for (Case cs: allCase)          
            {             
               system.debug('##### contract'+ con.Id);
               if (cs.Status != 'Closed')
               {
                  if (con.ATC_Priority_Code__c == 'Medium')
                    cs.Priority = 'Low';
                  else if (con.ATC_Priority_Code__c == 'High')
                    cs.Priority = 'High'; 
                  else //could be blank?
                    cs.Priority = 'Low';                                   
                  casesToUpdate.add(cs);
               }          
            }                
         }    
      } 
      if (!casesToUpdate.isEmpty())  
      { 
         update casesToUpdate; 
      }
   }      
}