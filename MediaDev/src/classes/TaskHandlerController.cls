public with sharing class TaskHandlerController {
   public static void onBeforeInsert(List<Task> taskList)
   {  /*  Instead of coding the logic here, call a method by passing taskList  */ 

   }  
   public static void onBeforeUpdate(List<Task> taskList, Map<Id, Task> mapTaskOld)
   {  /*  Instead of coding the logic here, call a method by passing taskListand mapTaskOld  */   

   }  
   public static void onAfterInsert(List<Task> taskList)
   {  /*  Instead of coding the logic here, call a method by passing taskListand   */ 
       updateCaseStatusOnTaskInsert(taskList) ; //service walk
   }  
   public static void onAfterUpdate(List<Task> taskList, Map<Id, Task> mapTaskOld)
   {  /*  Instead of coding the logic here, call a method by passing taskListand and mapTaskOld  */    
       updateCaseStatusOnTaskClose(taskList,mapTaskOld); //service walk
       lastInPersonVisitUpdate(taskList); 
       LastOutboundCallUpdate(taskList);
       LastEmailUpdate(taskList);
       LastInboundCallUpdate(taskList);
       LastOnlineMeetingUpdate(taskList);
       LastServiceUpdate(taskList);
       LastTaskUpdate(taskList);

   }  
   public static void updateCaseStatusOnTaskInsert(List<Task> taskList) 
   {   
      List<Case> casesToUpdate = new List<Case>();
      RecordType rt = [select Id, Name from RecordType where Name = 'ATG Order Entry' and SobjectType = 'Case' limit 1];    
      set<id> caseId=new set<id>();
    
      for (task ts: taskList)    
      { 
        if (ts.WhatId != null)
        {
          if(String.valueOf(ts.whatId).startsWith('500')==TRUE) /* is this related to case */
          {           
            caseId.add(ts.whatId);
            system.debug('Task trigger'+ts.whatId);
            List <Case> cs=[Select Id,status, Contract_Placed_on_Hold__c,RecordTypeId from Case where id in :caseId];
            if  (!cs.isEmpty())
            { 

                if (cs[0].Contract_Placed_on_Hold__c == 'Yes' && cs[0].RecordTypeId == rt.Id) /* is this order entry case with contract on hold */
                {
                    cs[0].Status='Awaiting Sales';
                    system.debug('Task trigger-case updating...'+cs[0]);
                    casesToUpdate.add(cs[0]);
                }
            }
          }
        }
      }
    if (!casesToUpdate.isEmpty())
    {
        update casesToUpdate;
    }    
   }
   public static void updateCaseStatusOnTaskClose(List<Task> taskList,Map<Id, Task> mapTaskOld) 
   {   
      List<Case> casesToUpdate = new List<Case>();
      RecordType rt = [select Id, Name from RecordType where Name = 'ATG Order Entry' and SobjectType = 'Case' limit 1];    
      set<id> caseId=new set<id>();
    
      for (task ts: taskList)    
      {     
        if (ts.WhatId != null)
        {          
          if(String.valueOf(ts.whatId).startsWith('500')==TRUE) /* is this related to case */
          {        
            caseId.add(ts.whatId);
            List <Case> cs=[Select Id,status, Contract_Placed_on_Hold__c,RecordTypeId from Case where id in :caseId];
            if  (!cs.isEmpty())
            { 

              if (cs[0].Contract_Placed_on_Hold__c == 'Yes' && cs[0].RecordTypeId == rt.Id && ts.Status == 'Completed') /* is this order entry case with contract on hold */
              {
                  cs[0].Status='Work In Progress';
                  casesToUpdate.add(cs[0]);
              }
            }
          }
        }
      }
    if (!casesToUpdate.isEmpty())
    {
        update casesToUpdate;
    }         
   }

   public static void lastInPersonVisitUpdate(List<Task> taskList) 
   {
    List<Account> acctsToUpdate = new List<Account>();
    Map<Id,Account> accountMap = new Map<Id,Account>();
    system.debug('in task update trigger');
    For(Task t : taskList)
    {
          system.debug(t.Type);
          system.debug(t.Date_Completed__c);
          system.debug(t.WhatId ); 
          system.debug(t.What.Type);                   
          if (t.Type == 'In Person Visit' && t.Date_Completed__c != null && t.WhatId != null )
          {
              system.debug(t.AccountId);

              if(t.AccountId!= null)
              {
                List<AccountTeamMember> atm = [Select UserId, TeamMemberRole, Id, AccountId From AccountTeamMember where  (TeamMemberRole = 'Advertising Consultant - ATC' OR TeamMemberRole ='Advertising Consultant - Major Accounts') AND AccountId =: t.AccountId LIMIT 2];
                List<Account> a = [Select Id, Last_In_Person__c from Account where Id =: t.AccountId LIMIT 1];
                system.debug('ATC:'+atm);            
                system.debug('is account task');
                system.debug(a[0].Last_In_Person__c);
                system.debug(t.Date_Completed__c);
                if (atm.isEmpty())
                {
                    a[0].Last_In_Person__c = t.Date_Completed__c;
                    system.debug('NO ATC:LIP='+a[0]);
                    if (!accountMap.containsKey(a[0].Id))
                    {
                        accountMap.put(a[0].Id,a[0]);
                        acctsToUpdate.add(a[0]); 
                    }               
                }
                else
                {
                    for (AccountTeamMember allATM : atm)
                    {                       
                        If (allATM.UserId == t.OwnerId && (a[0].Last_In_Person__c < t.Date_Completed__c || a[0].Last_In_Person__c == null ))
                        {
                            a[0].Last_In_Person__c = t.Date_Completed__c;
                            system.debug('ATC:LIP='+a[0]);                          
                            if (!accountMap.containsKey(a[0].Id))
                            {
                                accountMap.put(a[0].Id,a[0]);
                                acctsToUpdate.add(a[0]); 
                            }     
                        }
                    }
                }      
              }
          }
    }
    if (!acctsToUpdate.isEmpty())
    {
        update acctsToUpdate;
    }       
       
  }

   public static void LastOutboundCallUpdate(List<Task> taskList) 
   {
    List<Account> acctsToUpdate = new List<Account>();
    Map<Id,Account> accountMap = new Map<Id,Account>();
    system.debug('in task update trigger');
    For(Task t : taskList)
    {
          system.debug('Task Type' + t.Type);
          system.debug('Task Date Completed' + t.Date_Completed__c);
          system.debug('Task WhatID ' + t.WhatId); 
          system.debug('Task What Type' + t.What.Type);                   
          if (t.Type == 'Outbound Call/Fax' && t.Date_Completed__c !=null && t.WhatId != null )
          {
              system.debug('Account ID '+ t.AccountId);

              if(t.AccountId!= null)
              {
                List<AccountTeamMember> atm = [Select UserId, TeamMemberRole, Id, AccountId From AccountTeamMember where (TeamMemberRole = 'Inside Account Manager - ATC' OR TeamMemberRole = 'Inside Sales Consultant - ATC') AND AccountId =: t.AccountId LIMIT 2];
                List<Account> a = [Select Id, Last_Outbound_Call__c from Account where Id =: t.AccountId LIMIT 1];
                system.debug('ATC query :' +atm);            
                system.debug('is account task');
                system.debug('Last Outbound Call ' + a[0].Last_Outbound_Call__c);
                system.debug('Task Date Completed on Account ' + t.Date_Completed__c);
                if (atm.isEmpty())
                {
                    a[0].Last_Outbound_Call__c = t.Date_Completed__c;
                    system.debug('NO ATC:LIP='+a[0]);
                    if (!accountMap.containsKey(a[0].Id))
                    {
                        accountMap.put(a[0].Id,a[0]);
                        acctsToUpdate.add(a[0]); 
                    }               
                }
                else
                {
                    for (AccountTeamMember allATM : atm)
                    {                       
                        If (allATM.UserId == t.OwnerId && (a[0].Last_Outbound_Call__c < t.Date_Completed__c || a[0].Last_Outbound_Call__c == null ))
                        {
                            a[0].Last_Outbound_Call__c = t.Date_Completed__c;
                            system.debug('ATC:LIP='+a[0]);                          
                            if (!accountMap.containsKey(a[0].Id))
                            {
                                accountMap.put(a[0].Id,a[0]);
                                acctsToUpdate.add(a[0]); 
                            }     
                        }
                    }
                }      
              }
          }
    }
    if (!acctsToUpdate.isEmpty())
    {
        update acctsToUpdate;
    }       
       
  }
    public static void LastEmailUpdate(List<Task> taskList)
        {
            List<Account> acctsToUpdate = new List<Account>();
            Map<Id,Account> accountMap = new Map<Id,Account>();
            system.debug('in task update trigger');
            For(Task t : taskList)
                {
                    system.debug('Task Type' + t.Type);
                    system.debug('Task Date Completed' + t.Date_Completed__c);
                    system.debug('Task WhatID ' + t.WhatId);
                    system.debug('Task What Type' + t.What.Type);
                    if (t.Type == 'Email' && t.Date_Completed__c !=null && t.WhatId != null )
                        {
                            system.debug('Account ID '+ t.AccountId);
                            
                            if(t.AccountId!= null)
                                {
                                    List<Account> a = [Select Id, Last_Email__c from Account where Id =: t.AccountId LIMIT 1];
                                    system.debug('is account task');
                                    system.debug('Last Email ' + a[0].Last_Email__c);
                                    system.debug('Task Date Completed on Account ' + t.Date_Completed__c);
                                    
                                    a[0].Last_Email__c = t.Date_Completed__c;
                                    
                                    if (!accountMap.containsKey(a[0].Id))
                                        {
                                            accountMap.put(a[0].Id,a[0]);
                                            acctsToUpdate.add(a[0]);
                                        }
                                }
                        }
                }
            if (!acctsToUpdate.isEmpty())
                {
                    update acctsToUpdate;
                }
        }
    
    public static void LastInboundCallUpdate(List<Task> taskList)
        {
            List<Account> acctsToUpdate = new List<Account>();
            Map<Id,Account> accountMap = new Map<Id,Account>();
            system.debug('in task update trigger');
            For(Task t : taskList)
                {
                    system.debug('Task Type' + t.Type);
                    system.debug('Task Date Completed' + t.Date_Completed__c);
                    system.debug('Task WhatID ' + t.WhatId);
                    system.debug('Task What Type' + t.What.Type);
                    if (t.Type == 'Inbound Call/Fax' && t.Date_Completed__c !=null && t.WhatId != null )
                        {
                            system.debug('Account ID '+ t.AccountId);
                            
                            if(t.AccountId!= null)
                                {
                                    List<Account> a = [Select Id, Last_Inbound_Call__c from Account where Id =: t.AccountId LIMIT 1];
                                    system.debug('is account task');
                                    system.debug('Last Inbound Call ' + a[0].Last_Inbound_Call__c);
                                    system.debug('Task Date Completed on Account ' + t.Date_Completed__c);
                                    
                                    a[0].Last_Inbound_Call__c = t.Date_Completed__c;
                                    
                                    if (!accountMap.containsKey(a[0].Id))
                                        {
                                            accountMap.put(a[0].Id,a[0]);
                                            acctsToUpdate.add(a[0]);
                                        }
                                }
                        }
                }
            if (!acctsToUpdate.isEmpty())
                {
                    update acctsToUpdate;
                }
        }
    
    public static void LastOnlineMeetingUpdate(List<Task> taskList)
        {
            List<Account> acctsToUpdate = new List<Account>();
            Map<Id,Account> accountMap = new Map<Id,Account>();
            system.debug('in task update trigger');
            For(Task t : taskList)
                {
                    system.debug('Task Type' + t.Type);
                    system.debug('Task Date Completed' + t.Date_Completed__c);
                    system.debug('Task WhatID ' + t.WhatId);
                    system.debug('Task What Type' + t.What.Type);
                    if (t.Type == 'Online Meeting' && t.Date_Completed__c !=null && t.WhatId != null )
                        {
                            system.debug('Account ID '+ t.AccountId);
                            
                            if(t.AccountId!= null)
                                {
                                    List<Account> a = [Select Id, Last_Online_Meeting__c from Account where Id =: t.AccountId LIMIT 1];
                                    system.debug('is account task');
                                    system.debug('Last Online Meeting ' + a[0].Last_Online_Meeting__c);
                                    system.debug('Task Date Completed on Account ' + t.Date_Completed__c);
                                    
                                    a[0].Last_Online_Meeting__c = t.Date_Completed__c;
                                    
                                    if (!accountMap.containsKey(a[0].Id))
                                        {
                                            accountMap.put(a[0].Id,a[0]);
                                            acctsToUpdate.add(a[0]);
                                        }
                                }
                        }
                }
            if (!acctsToUpdate.isEmpty())
                {
                    update acctsToUpdate;
                }
        }
    
    public static void LastServiceUpdate(List<Task> taskList)
        {
            List<Account> acctsToUpdate = new List<Account>();
            Map<Id,Account> accountMap = new Map<Id,Account>();
            system.debug('in task update trigger');
            For(Task t : taskList)
                {
                    system.debug('Task Type' + t.Type);
                    system.debug('Task Date Completed' + t.Date_Completed__c);
                    system.debug('Task WhatID ' + t.WhatId);
                    system.debug('Task What Type' + t.What.Type);
                    if (t.Type == 'Service' && t.Date_Completed__c !=null && t.WhatId != null )
                        {
                            system.debug('Account ID '+ t.AccountId);
                            
                            if(t.AccountId!= null)
                                {
                                    List<Account> a = [Select Id, Last_Service__c from Account where Id =: t.AccountId LIMIT 1];
                                    system.debug('is account task');
                                    system.debug('Last Service ' + a[0].Last_Service__c);
                                    system.debug('Task Date Completed on Account ' + t.Date_Completed__c);
                                    
                                    a[0].Last_Service__c = t.Date_Completed__c;
                                    
                                    if (!accountMap.containsKey(a[0].Id))
                                        {
                                            accountMap.put(a[0].Id,a[0]);
                                            acctsToUpdate.add(a[0]);
                                        }
                                }
                        }
                }
            if (!acctsToUpdate.isEmpty())
                {
                    update acctsToUpdate;
                }
        }
    
    public static void LastTaskUpdate(List<Task> taskList)
        {
            List<Account> acctsToUpdate = new List<Account>();
            Map<Id,Account> accountMap = new Map<Id,Account>();
            system.debug('in task update trigger');
            For(Task t : taskList)
                {
                    system.debug('Task Type' + t.Type);
                    system.debug('Task Date Completed' + t.Date_Completed__c);
                    system.debug('Task WhatID ' + t.WhatId);
                    system.debug('Task What Type' + t.What.Type);
                    if (t.Type == 'Task' && t.Date_Completed__c !=null && t.WhatId != null )
                        {
                            system.debug('Account ID '+ t.AccountId);
                            
                            if(t.AccountId!= null)
                                {
                                    List<Account> a = [Select Id, Last_Task__c from Account where Id =: t.AccountId LIMIT 1];
                                    system.debug('is account task');
                                    system.debug('Last Task ' + a[0].Last_Task__c);
                                    system.debug('Task Date Completed on Account ' + t.Date_Completed__c);
                                    
                                    a[0].Last_Task__c = t.Date_Completed__c;
                                    
                                    if (!accountMap.containsKey(a[0].Id))
                                        {
                                            accountMap.put(a[0].Id,a[0]);
                                            acctsToUpdate.add(a[0]);
                                        }
                                }
                        }
                }
            if (!acctsToUpdate.isEmpty())
                {
                    update acctsToUpdate;
                }
        }  
}