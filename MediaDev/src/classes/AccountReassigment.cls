public class AccountReassigment{


public static Boolean Reassign(MassAccountTeamReassignController.MassAccountTeamReassignRec  rec, User existingUser  , String currentUserRole, User replacingUser , String newUserRole, Boolean reassignActivites, Boolean reassignOpp){
Boolean isSuccess = true;
String result = '';
system.debug('AccountReassigment.ReAssign Start');
system.debug('accountId:'+rec.AccountId);
system.debug('existingAccountTeamId:'+existingUser.Id);
system.debug('replacementAccountTeamId:'+replacingUser.Id);
system.debug('currentUserRole:'+currentUserRole);
system.debug('newUserRole:'+newUserRole);
system.debug('reassignActivites:'+reassignActivites);
system.debug('reassignOpp:'+reassignOpp);

//get account data
//User object is assumed to be populated by the caller
Account account = [Select Id, Name from Account where Id=: rec.AccountId];


 
      
    Savepoint runSavepoint = Database.setSavepoint(); 
    try
    {
        //Reassign TeamRole
        result = ReAssignTeamMembers(rec,account ,existingUser , replacingUser , newUserRole);
        if(result.contains('ERROR::')){
            isSuccess  = false;
        }
        if(reassignActivites){
        

        
        //Reassign Tasks
        result  = result  + '<br/>' + ReAssignTasks(rec,account ,existingUser , replacingUser );
        if(result.contains('ERROR::')){
            isSuccess  = false;
        }
        //Reassign Events
        //ReAssignEvents(account ,existingUser , replacingUser );
        }
        
        if(reassignOpp){
        //Reassign Opportunity
        result = result  + '<br/>' + ReAssignOpportunites(rec,account ,existingUser , replacingUser );
        if(result.contains('ERROR::')){
            isSuccess  = false;
        }
        }
        //Reassign Cases
        //ReAssignCases(account ,existingUser , replacingUser );
      
      if(!isSuccess){
       Database.RollBack(runSavepoint);
       result =  result  + '<br/>' + 'Reassignment Failed.';
       
      }
      else{        
      result =  result  + '<br/>' + 'Reassignment is complete.';
      }
      
    }
    catch(Exception ex)
    {
      Database.RollBack(runSavepoint);      
      result  =  result  + '<br/>' +'ERROR::' + '<br/>' + ex.getMessage();
      result =  result  + '<br/>' + 'Reassignment Failed.';
      System.Debug('rec.ReassignResult:'+result  );
    }
    system.debug('AccountReassigment.ReAssign End');
    rec.ReassignResult = result;
    return isSuccess;
}



public static String ReAssignTeamMembers(MassAccountTeamReassignController.MassAccountTeamReassignRec  rec,Account account,User existingUser , User newUser, String newUserRole){
String result = '';
try
    {
        List<AccountTeamMember> teamMemberRoleOfExistingUser = [Select Id, TeamMemberRole,AccountId,UserId from AccountTeamMember where UserId=:existingUser.Id AND AccountId =:account.Id];    
         if(teamMemberRoleOfExistingUser != null || teamMemberRoleOfExistingUser .size() > 0){
         List<AccountTeamMember> teamMemberRoleOfNewUser = new List<AccountTeamMember>();
                        for(AccountTeamMember actTM : teamMemberRoleOfExistingUser){
                            AccountTeamMember newMember = new AccountTeamMember();                            
                            newMember.AccountId = account.Id;   
                            newMember.UserId = newUser.Id;                                                  
                             //change the role if not to use the same role as the existing user
                             if (newUserRole != 'Use Role of Replaced Team Member'){                                
                                       newMember.TeamMemberRole = newUserRole;
                                       
                             }
                             else{
                             newMember.TeamMemberRole = actTM.TeamMemberRole;
                             } 
                             rec.NewUserId = newUser.Id;
                             rec.NewUserName = newUser.Name;          
                             rec.NewUserLink= (new ApexPages.StandardController(newUser)).view().getUrl();
                             rec.NewTeamMemberRole = newMember.TeamMemberRole ;
                             teamMemberRoleOfNewUser.add(newMember);                            
                             }
                           
                   delete teamMemberRoleOfExistingUser ;   
                   insert teamMemberRoleOfNewUser;  
        }
        
        result  = 'Reassigning TeamMembers/Roles Complete';
    }
     catch(Exception ex)
    {
      result  =  result  + '<br/>' +'ERROR::' + '<br/>' + ex.getMessage();
      System.Debug('ReAssignTeamMembers: Error'+result  );
    }
    
return result;
}


public static String ReAssignTasks(MassAccountTeamReassignController.MassAccountTeamReassignRec  rec,Account account,User existingUser , User newUser){
String result = '';
try
    {
        List<Task> tasksOfExistingUser = [Select Id, OwnerId,WhatId, Status from Task where ownerId =:existingUser.Id AND WhatId =:account.Id AND Status =:'Open'];
        if(tasksOfExistingUser!= null || tasksOfExistingUser.size() > 0){
               for(Task t : tasksOfExistingUser){
                   t.ownerId = newUser.Id;
               }
               
               update tasksOfExistingUser;        
        }
        result  = 'Reassigning Open Tasks Complete';
    }
     catch(Exception ex)
    {
      result  =  result  + '<br/>' +'ERROR::' + '<br/>' + ex.getMessage();
      System.Debug('ReAssignTasks: Error'+result  );
    }
    
return result;
}
/*
public static String ReAssignEvents(Account account,User existingUser , User newUser){
String result = '';
try
    {
        List<Event> eventsOfExistingUser = [Select Id, OwnerId, AccountId from Event where ownerId =:existingUser.id  AND AccountId=:account.Id];
        if(eventsOfExistingUser != null || eventsOfExistingUser .size() > 0){
               for(Event e : eventsOfExistingUser ){
                   e.ownerId = newUser.Id;
               }
               
               update eventsOfExistingUser;        
        }
    }
     catch(Exception ex)
    {
      result  =  ex.getMessage();
      System.Debug('ReAssignEvents: Error'+result  );
    }
    
return result;
}*/

public static String ReAssignOpportunites(MassAccountTeamReassignController.MassAccountTeamReassignRec  rec,Account account,User existingUser , User newUser){
String result = '';
try
    {
        List<Opportunity> opportunitiesOfExistingUser = [Select Id, OwnerId , AccountId from Opportunity where ownerId =:existingUser.id AND AccountId =:account.Id AND IsClosed =false];
        if(opportunitiesOfExistingUser != null || opportunitiesOfExistingUser.size() > 0){
               for(Opportunity o : opportunitiesOfExistingUser ){
                   o.ownerId = newUser.Id;
               }
               
               update opportunitiesOfExistingUser;        
               result  = 'Reassigning Open Opportunites Complete';
               //All Tasks of the Opportunites
               List<Task> opptasksOfExistingUser = [Select Id, OwnerId,WhatId, Status from Task where ownerId =:existingUser.Id AND WhatId IN :opportunitiesOfExistingUser  AND Status =:'Open'];
               if(opptasksOfExistingUser != null || opptasksOfExistingUser.size() > 0){
               for(Task t : opptasksOfExistingUser){
                   t.ownerId = newUser.Id;
               }
               
               update opptasksOfExistingUser;    
               result  = result   + '<br/>'+ 'Reassigning Open Opportunity Tasks Complete';
               }
        }
        
        
    }
     catch(Exception ex)
    {
      result =  result  + '<br/>' +'ERROR::' + '<br/>' + ex.getMessage();
      System.Debug('ReAssignOpportunites: Error'+result  );
    }
    
return result;
}

/*public static String ReAssignCases(Account account,User existingUser , User newUser){
String result = '';
try
    {
        List<Case> casesOfExistingUser = [Select Id, OwnerId from Case where ownerId =:existingUser.id ];
        if(casesOfExistingUser != null || casesOfExistingUser.size() > 0){
               for(Case c : casesOfExistingUser ){
                   c.ownerId = newUser.Id;
               }
               
               update casesOfExistingUser;        
        }
    }
     catch(Exception ex)
    {
      result  =  ex.getMessage();
      System.Debug('ReAssignCases: Error'+result  );
    }
    
return result;
}*/


}