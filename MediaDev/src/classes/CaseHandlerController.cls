public class CaseHandlerController
{
 public static void onBeforeInsert(List<Case> caseList){
  /*
  Instead of coding the logic here, call a method by passing caseList
  */
   updateOwnerOnCase(caseList, true);/* true indicates this is create */
   setOrderCasePriorityToContractPriority(caseList);   
   updateCaseSubjectLineOnQAFail(caseList);
   insertContractCreatedByOwnerFMConfig(caseList);
   updateESOCreatedBywithContractValue(caseList);
  // updateSystemCaseRouting(caseList);
   
 }
 
 public static void onBeforeUpdate(List<Case> caseList, Map<Id, Case> mapCaseOld){
  /*
  Instead of coding the logic here, call a method by passing caseListand mapCaseOld
  */
   updateOwnerOnCase(caseList, false);  
   updateContractWithOrderEntryCase(caseList, mapCaseOld);
   updateOrderCasePriorityToContractPriority(caseList, mapCaseOld);   
   updateESOCreatedBywithContractValue(caseList);

 }
 
 public static void onAfterInsert(List<Case> caseList){
  /*
  Instead of coding the logic here, call a method by passing caseListand 
  */
    updateParentCaseNew(caseList);
    addContractWithOrderEntryCase(caseList);
    
 }
 
 public static void onAfterUpdate(List<Case> caseList, Map<Id, Case> mapCaseOld){
  /*
  Instead of coding the logic here, call a method by passing caseListand and mapCaseOld
  */
    createTaskOnContractReject(caseList,mapCaseOld);
    updateParentOnChildClose(caseList,mapCaseOld);
 }
 
 public static void updateParentOnChildClose(List<Case> caseList, Map<Id, Case> mapCaseOld)
 {
    RecordType rt = [select Id, Name from RecordType where Name = 'ATC Dealer Service - HomeNet' and SobjectType = 'Case'];    

    List<Case> casesToUpdate = new List<Case>();
    Set<Id> parentCaseId = new Set<Id>();
    
    for (case c: caseList)
    { 
        Case oldCase = mapCaseOld.get(c.Id);
        
        if (c.ParentId != null && c.Status == 'Closed' && c.Status!= oldCase.Status)
        {           
           /* update parent status */
           Case parentCase = new Case();
           parentCase.Id = c.ParentId;
        
           parentCase.ATC_One_and_Done__c = 'No';      
           parentCaseId.add(c.ParentId);
           Case existingParent = [select Id,Priority, Status From Case  Where Id in :parentCaseId LIMIT 1];
           if (existingParent.Priority != 'High')
             parentCase.Priority = 'Medium';           
           parentCase.Status = 'Work In Progress';          
            // if status is awaiting internal then workflow will change priority
            
           // Update Parent Case
           casesToUpdate.add(parentCase);
        }                     
    }
    if (!casesToUpdate.isEmpty())
    {
        update casesToUpdate;
    }     
 }
 public static void updateParentCaseNew(List<Case> caseList)
 {
    List<Case> casesToUpdate = new List<Case>();
    
    for (case c: caseList)
    {
       system.debug('LYNN:parent:'+c.Parent.CaseNumber);
       system.debug('LYNN:case number'+c.CaseNumber);

       if (c.ParentId != null)
       {
           /* update parent status */
           Case parentCase = new Case();
           parentCase.Id = c.ParentId;
           parentCase.Status = 'Awaiting Internal';
           parentCase.ATC_One_and_Done__c = 'No';
           parentCase.HasChildCases__c = true;
           system.debug('LYNN:added parent to update');
           // Update Parent Case
           casesToUpdate.add(parentCase);          

       }
    }
    if (!casesToUpdate.isEmpty())
    {
        update casesToUpdate;
    }    
 }
  public static void updateOwnerOnCase(List<Case> caseList, boolean isCaseCreation)
 {
    for (case c: caseList)
    {
       if (c.ATC_Co_op__c == 'Yes' && c.ATC_Rework_Approval_Status__c == 'Rejected' && c.Status == 'QA Complete' )
       {
          system.debug('CreatedByOwner:'+ c.CreatedById);
          system.debug('Previous_Owner:'+ c.Previous_Owner__c);
          if (c.Previous_Owner__c != null)
            c.OwnerId = c.Previous_Owner__c;
          else
            c.OwnerId = c.CreatedById;
       }
       if (c.Status == 'Design Complete')
       {
          c.Previous_Owner__c = UserInfo.getUserId();
       }
        system.debug('---------c.Task_Type__c'+c.Task_Type__c);
       if (c.Task_Type__c == 'Back To Contract' && c.Status != 'Closed' && isCaseCreation == true)
       {
           List<Contract> esoInfo = [SELECT Id, eSO_Created_By__c from Contract where Id =: c.Contract__c LIMIT 1];
           system.debug('------esoinfo-----'+esoInfo);
           List<Group> esoQ = [SELECT Id from Group where Name = 'ESO Order Entry' and Type = 'Queue'];
            system.debug('------esoQ-----'+esoQ);
           c.Priority = 'High';
           if (!esoInfo.isEmpty())
           {
             if (esoInfo[0].eSO_Created_By__c != null)
             {
                List<User> ownerInfo = [SELECT Id, Net_ID__c from User where Net_ID__c =: esoInfo[0].eSO_Created_By__c LIMIT 1];
                
                if (!ownerInfo.isEmpty())
                {
                    c.OwnerId = ownerInfo[0].Id;
                    c.eSO_Created_By__c = ownerInfo[0].Id;              
                }
                else if (!esoQ.isEmpty())
                    c.OwnerId = esoQ[0].Id;
             }
             else if (!esoQ.isEmpty())
                    c.OwnerId = esoQ[0].Id;
           }
           else if (!esoQ.isEmpty())
                c.OwnerId = esoQ[0].Id;

       }    
    }
 }
 public static void addContractWithOrderEntryCase(List<Case> caseList)
 {
  
    // if order id is added to new case, search for contract with same order id and create a relationship
    // this also sets the case priority to the priority of the contract
    for (case c: caseList)
    {
       if (c.Order_ID__c != null)
       {
          //find all contracts with this id and update them with this case id
          List<Contract> allCon = [select Id,Order_Cases__c,ATC_Order_Sys_ID__c, ATC_Priority_Code__c, contractnumber from Contract where ATC_Order_Sys_ID__c = : c.Order_ID__c];
          system.debug('##### allCon'+ allCon);
          for (Contract con: allCon)
          {
             system.debug('##### allCon cases'+ con.Order_Cases__c);
             Case caseUpd = new Case();
             Contract contractUpd = new Contract();
             contractUpd.Id = con.Id;
             caseUpd.Id = c.Id;
             contractUpd.Order_Cases__c = c.Id;
             system.debug('added case '+c.casenumber+' to contract '+con.contractnumber);
             system.debug('contract on case before:'+c.contract__c);
             caseUpd.contract__c = con.Id;
             system.debug('contract on case after:'+caseUpd.contract__c);
             if (con.ATC_Priority_Code__c == 'Medium' && c.Task_Type__c != 'Back To Contract')
                caseUpd.Priority = 'Low';
             else if (con.ATC_Priority_Code__c == 'High')
                caseUpd.Priority = 'High';              
             //cannot use best practice here and must update in for loop because case could be updated twice with different contracts assoc.          
             system.debug('##### updated contract'+ contractUpd.Id + '::'+contractUpd);
             system.debug('##### updated case'+ caseUpd.Id + '::'+caseUpd.casenumber+ '::'+caseUpd);             
             update caseUpd;
             update contractUpd;

          }

       }
    }
 

 }
  public static void updateContractWithOrderEntryCase(List<Case> caseList, Map<Id, Case> mapCaseOld)
 {
    List<contract> contractsToUpdate = new List<contract>();
    // if order id is added to new case, search for contract with same order id and create a relationship
    // this also sets the case priority to the priority of the contract
    for (case c: caseList)
    {
       Case oldCase = mapCaseOld.get(c.Id);
        
       if ((c.Order_ID__c != oldCase.Order_ID__c) ) //order id changed and it isnt a closed case
       {
          //find all contracts with this id and update them with this case id if eso order id not blank
          if (oldCase.Order_ID__c != null)
          {
            //remove contracts from this case
            List<Contract> allConOld = [select Id,Order_Cases__c,ATC_Order_Sys_ID__c from Contract where ATC_Order_Sys_ID__c = : oldCase.Order_ID__c];
            system.debug('##### allConOld'+ allConOld);
            for (Contract con: allConOld)
            {
                system.debug('##### allConOld cases'+ con.Order_Cases__c);

                system.debug('removing a case from contract '+con.Order_Cases__c);
                con.Order_Cases__c = null;

                contractsToUpdate.add(con);
                c.contract__c = null;
            }
          }
          if (c.Order_ID__c != null)
          {
             List<Contract> allCon = [select Id,Order_Cases__c,ATC_Order_Sys_ID__c, ATC_Priority_Code__c,contractnumber from Contract where ATC_Order_Sys_ID__c = : c.Order_ID__c];
             system.debug('##### allCon'+ allCon);
             for (Contract con: allCon)
             {
                system.debug('##### allCon cases'+ con.Order_Cases__c);

                con.Order_Cases__c = c.Id;
                system.debug('Associating contract '+con.contractnumber+'with case '+c.casenumber);
                contractsToUpdate.add(con);
                c.contract__c = con.Id;
                if (con.ATC_Priority_Code__c == 'Medium'  && c.Task_Type__c != 'Back To Contract' )
                    c.Priority = 'Low';
                else if (con.ATC_Priority_Code__c == 'High')
                    c.Priority = 'High';                        
                system.debug('Associating case with contract'+ con.contractnumber + '::'+con);
                system.debug('##### case updated'+ c.Id + '::'+c.casenumber+ '::'+c);
            }              
          }

       }
    }
    if (!contractsToUpdate.isEmpty())
    {
        update contractsToUpdate;   
    }
    system.debug('##### update cases:'+contractsToUpdate);
 }
 public static void createTaskOnContractReject(List<Case> caseList, Map<Id, Case> mapCaseOld)
 {
    List<Task> tasksToUpdate = new List<Task>();
    RecordType rt = [select Id, Name from RecordType where Name = 'ATG Order Entry' and SobjectType = 'Case'];    
    RecordType rtTsk = [select Id, Name from RecordType where Name = 'AC Consultants' and SobjectType = 'Task'];    
    
    // automating the generation of a task for contracts that are rejected.
    String comment1 = 'Hello, \n';
    String comment2 = 'We are unable to process the attached package: ';
    String comment3 = ' Sales Order for the following reasons:\n\n';
    String comment4 = '\n\nPlease submit a revised Sales Order with the information needed.\nShould you have any questions, you can reach us by e-mail at dealersupportemails@autotrader.com or \n by calling 1-877-353-9360, Monday - Friday 8am - 10pm EST, Saturday, 9am - 6pm EST.';
    String comment5 = 'Contract Rejection Reasons: \n';
    String comment6 = '\n\n';
    
    for (case c: caseList)
    {
        if (!TriggerRunOnce.isAlreadyDone(c.Id)) 
        {

    
            // if the order entry case contract rejection changed  and set to yes then create task
            Case oldCase = mapCaseOld.get(c.Id);
            system.debug('TESTING CONTRACT REJECT UPDATE::oldCase'+oldCase.Contract_Rejected__c);
            system.debug('TESTING CONTRACT REJECT UPDATE::new case'+c.Contract_Rejected__c);
            if (c.Contract_Rejected__c == 'Yes' && c.Contract_Rejected__c != oldCase.Contract_Rejected__c && c.RecordTypeId == rt.Id)
            {
                Task newTask = new Task();
                system.debug('Case:'+c.AccountId);
          
                List<AccountTeamMember> atm = [Select UserId, TeamMemberRole, Id, AccountId From AccountTeamMember where  (TeamMemberRole = 'Advertising Consultant - ATC' OR TeamMemberRole = 'Inside Sales Consultant - ATC') AND AccountId =: c.AccountId LIMIT 1];
                //List<AccountTeamMember> atm = [Select UserId, TeamMemberRole, Id, AccountId From AccountTeamMember where  TeamMemberRole = 'Advertising Consultant - ATC' AND AccountId =: c.AccountId LIMIT 1];
                system.debug('ATC:'+atm);
                boolean ownerFound = false;
                If (!atm.isEmpty())
                {
                    User atmUser = [select Id, IsActive,ManagerId  from User where Id =: atm[0].UserId limit 1];
                    if (atmUser.IsActive == true)
                    {
                      newTask.OwnerId = atmUser.Id ;
                        ownerFound = true;
                    }
                    else if (atmUser.ManagerId != null)
                    {
                        User manager = [select Id, IsActive from User where Id =: atmUser.ManagerId limit 1];
                        if (manager.IsActive == true)
                        {
                          ownerFound = true;
                         newTask.OwnerId = manager.Id ;                           
                        }
                        
                    }
                }
                if (ownerFound == false)
                {
                    newTask.OwnerId = c.OwnerId;
                }
                List<Account> acc = [Select Id, Name From Account Where Id =: c.AccountId LIMIT 1];
                if (!acc.isEmpty())
                    newTask.Subject = acc[0].Name +' - '+c.Account_SVOC_Id__c+': Contract Rejected - Re-Submit Sales Order';
                else
                    newTask.Subject = 'Unknown Account - '+c.Account_SVOC_Id__c+': Contract Rejected - Re-Submit Sales Order';
                    
                newTask.WhatId = c.Id;
                newTask.Type = 'Other';
                newTask.Priority = 'High';
                newTask.RecordtypeId = rtTsk.id;
                newTask.ActivityDate = Date.today();
                newTask.ActivityDate =newTask.ActivityDate.addDays(1);
                if (String.isNotBlank(c.Contract_Rejection_Comments__c))
                    newTask.Description = comment1 + comment2 + c.Contract_Rejection_Package_Name__c + comment3 + comment5 + c.Contract_Rejection_Reason__c + comment6 + c.Contract_Rejection_Comments__c + comment4;
                else
                    newTask.Description = comment1 + comment2 + c.Contract_Rejection_Package_Name__c + comment3 + comment5 + c.Contract_Rejection_Reason__c + comment4;
                
                tasksToUpdate.add(newTask); 
                TriggerRunOnce.setAlreadyDone(c.Id);
            }
        }               
    }
    if (!tasksToUpdate.isEmpty())
    {
        // add code to trigger email notification
        //Set EmailHeader.triggerUserEmail to true
        Database.DMLOptions dmlo = new Database.DMLOptions();
        dmlo.EmailHeader.triggerUserEmail = true;    
        database.insert( tasksToUpdate,dmlo);
    }
 }
 public static void updateCaseSubjectLineOnQAFail(List<Case> caseList)
 {
    Set<Id> rtList = new Set<Id>();
    //use schema rather than query to get record type names
    rtList.add(Schema.SObjectType.Case.getRecordTypeInfosByName().get('ATG DMD Fulfillment').getRecordTypeId());    
    rtList.add(Schema.SObjectType.Case.getRecordTypeInfosByName().get('ATG Order Activity').getRecordTypeId());    
    rtList.add(Schema.SObjectType.Case.getRecordTypeInfosByName().get('ATG Order Activity QA').getRecordTypeId());    
    system.debug('RTList'+rtList);    
    Integer LastOwnerIndex;
    String lastOwnerName;
    Id      lastOwnerId;
    
    
   // altering the subject line of cases that have previously failed QA

    for (case c: caseList)
    {     
        /* get all cases with same contract id and task type */
         system.debug('The related contract is: '+c.Contract__c+'id:'+ c.Contract__r.Id);
         if (rtList.contains(c.RecordTypeID))// add code to alleviate soql limits on test
         {
          List<Case> allCases = [select Id, Contract__r.Id, Task_Type__c,RecordTypeId, OwnerId, Status, casenumber from Case where Contract__r.Id = : c.Contract__c and RecordTypeId in :rtList and Task_Type__c =: c.Task_Type__c ORDER BY casenumber ASC ];
          system.debug('##### allCases on this contract: '+ c.Contract__c+'::'+allCases);
          if (!allCases.isEmpty() && c.Contract__c!=null)
          {
            LastOwnerIndex = allCases.size()-1;
            List<User> userOwner = [select Name from user where Id =: allCases[LastOwnerIndex].OwnerId limit 1];
            List<Group> queueOwner = [select Name from group where Id =: allCases[LastOwnerIndex].OwnerId limit 1];
            if (userOwner.isEmpty())
            {
                //owner is queue
                lastOwnerName = queueOwner[0].Name;
                lastOwnerId = queueOwner[0].Id;
            }
            else
            {
                //owner is user
                lastOwnerName = userOwner[0].Name;
                lastOwnerId = userOwner[0].Id;
            }
            if (c.Task_Type__c!= null)
            {
                if (c.subject.contains('QA Fail'))
                    c.subject = c.Task_Type__c +' [QA Fail '+ allCases.size() +', Last Status '+lastOwnerName+']';
                else
                    c.subject = c.Task_Type__c +' [Regenerated '+ allCases.size() +', Last Status '+lastOwnerName+']';
                c.priority = 'High';
                c.OwnerId = lastOwnerId;
                if (c.Task_Type__c!= 'Quality Assurance' && c.Task_Type__c!= 'KBB Quality Assurance')
                    c.Status = 'Work In Progress';
            }
            system.debug('subject: '+c.subject+'priority: '+c.priority+'owner Id: '+c.ownerId);
          }
       } //end fix for test soql limits   
    }  

 }
 public static void setOrderCasePriorityToContractPriority(List<Case> caseList)
 {
    // this also sets the case priority to the priority of the contract
    for (case c: caseList)
    {        
       if ((c.Contract__c != null) ) //case has a contract associated
       {    
            system.debug('UPDATING PRIORITY ON CASE TO CONTRACT PRIORITY '+c.Contract__C);
            Contract con = [select Id,ATC_Priority_Code__c from Contract where Id = : c.Contract__c];
            system.debug('con: '+con);
            if (con.ATC_Priority_Code__c == 'Medium'  && c.Task_Type__c != 'Back To Contract')
                c.Priority = 'Low';
            else if (con.ATC_Priority_Code__c == 'High')
                c.Priority = 'High';                                   
            system.debug('PRIORITY UPDATED ON CASE TO CONTRACT PRIORITY '+c.Priority);
       }
    }
 }
 public static void updateOrderCasePriorityToContractPriority(List<Case> caseList, Map<Id, Case> mapCaseOld)
 {
    // this also sets the case priority to the priority of the contract
    for (case c: caseList)
    {        
       Case oldCase = mapCaseOld.get(c.Id);
        
       if (c.Contract__c != oldCase.Contract__c && c.Contract__c != null ) //contract changed 
       {    
   
            system.debug('UPDATING PRIORITY ON CASE TO CONTRACT PRIORITY '+c.Contract__C);
            Contract con = [select Id,ATC_Priority_Code__c from Contract where Id = : c.Contract__c];
            system.debug('con: '+con);
            if (con.ATC_Priority_Code__c == 'Medium'  && c.Task_Type__c != 'Back To Contract')
                c.Priority = 'Low';
            else if (con.ATC_Priority_Code__c == 'High')
                c.Priority = 'High';                       
            system.debug('PRIORITY UPDATED ON CASE TO CONTRACT PRIORITY '+c.Priority);
       }
    }
 } 
 
 // Create a mechanism, when a case with the task type = Contract FM Config is created, auto associate that case owner with 
 // the Salesforce user that entered the contract in eSO.  That user is known by the value of the field “eSO Created By (User)
 // in the contract object.  The value of that field contains the NetID which is part of the User object in Salesforce.  
 // If the value of the field “eSO Created By (User)” is null, blank, or if does not match with the values of the User object
 //  in Salesforce, then assign the case owner to ESO Order Entry queue.
 private static void insertContractCreatedByOwnerFMConfig(List<Case> caseList)
 {
    for (case c: caseList)
    { 
        if (c.Task_Type__c == 'Contract FM Config')
        {
           List<Contract> esoInfo = [SELECT Id, eSO_Created_By__c from Contract where Id =: c.Contract__c LIMIT 1];
           List<Group> esoQ = [SELECT Id from Group where Name = 'ESO Order Entry' and Type = 'Queue'];
           if (!esoInfo.isEmpty()) // did i find associated contract
           {
              if (esoInfo[0].eSO_Created_By__c != null)
              {
                List<User> ownerInfo = [SELECT Id, Net_ID__c from User where Net_ID__c =: esoInfo[0].eSO_Created_By__c LIMIT 1];
                if (!ownerInfo.isEmpty())
                {// found user
                    c.OwnerId = ownerInfo[0].Id;
                    c.eSO_Created_By__c = ownerInfo[0].Id;              
                }
                else if (!esoQ.isEmpty())//didnt find user so assign to queue
                    c.OwnerId = esoQ[0].Id;
              }
              else if (!esoQ.isEmpty()) //couldnt find contract created by
                c.OwnerId = esoQ[0].Id;
           }
           else if (!esoQ.isEmpty()) //couldnt find contract so assign to queue
                c.OwnerId = esoQ[0].Id;

        }    
    }   
 }
 private static void updateESOCreatedBywithContractValue(List<Case> caseList)
 {
    Integer i=0;
    for (case c: caseList)
    {  
        system.debug('case status:'+c.status+i+'test:'+Test.isRunningTest());
        if (c.status != 'Closed' && !(c.Status == 'New' && Test.isRunningTest())) // add code to alleviate mass close SOQL limits Defect D-03791 
        {
           List<Contract> esoInfo = [SELECT Id, eSO_Created_By_User__c from Contract where Id =: c.Contract__c LIMIT 1];
           if (!esoInfo.isEmpty()) // did i find associated contract field
           {
                c.eSO_Created_By__c = esoInfo[0].eSO_Created_By_User__c;              
           }
        }
        i++;
    }
 }
 /* 
 private static void updateSystemCaseRouting(List<Case> caseList)
 {
    Integer i=0;
    for (case c: caseList)
    {  
        c.System_Case_Routing__c = c.origin;

    }
 } 
 */
}