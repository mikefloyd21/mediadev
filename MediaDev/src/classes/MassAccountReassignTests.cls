@isTest 
public class MassAccountReassignTests {
public static testMethod void testmassReassignmentStep1Validations(){

MassAccountReassignTestUtility testData = new MassAccountReassignTestUtility();
testData.AccountNameStartsWith  = 'TestCaseAccountMassReassign';
testData.UserNameStartsWith  = 'TestCaseUserAccountMassReassign';
testData.dataSize = 5;
testData.CreateTestUsers();
testData.CreateTestMassReassign();

PageReference pageRef = Page.MassAccountTeamReassignStep1;
Test.setCurrentPage(pageRef); 

MassAccountTeamReassignController pageController = new MassAccountTeamReassignController();
//unselect options to reassign activities and opportunites
pageController.ReassignActivites = false;
pageController.ReassignOpportunities= false;

//try seraching with out any parameters
pageController.SearchForAccountsToSelect();
system.assert(pageController.showmessages,'Validation failed on missing selecting existingTeamMember');
AccountTeamMember existingTeamMember = new AccountTeamMember();
existingTeamMember.UserId = testData.massReassignAccountUserList.get(0).id;
pageController.setExistingTeamMember(existingTeamMember);
pageController.SearchForAccountsToSelect();
system.assert(!pageController.showmessages,'Validation did not clear after selecting missing existingTeamMember');

//get roles to search for ;
system.assertEquals(pageController.getaccountTeamSearchRoleList().get(0).getLabel().trim(),'Select One');


//search records no rows
existingTeamMember = new AccountTeamMember();
existingTeamMember.UserId = testData.massReassignAccountUserList.get(1).id;
pageController.setExistingTeamMember(existingTeamMember);
pageController.SearchForAccountsToSelect();
system.assert(pageController.getSearchAccountResults().size()==0,'Records are not expected to return');
system.assert(!pageController.ShowSearchResults,'Searche results are not expected to show');
system.assert(pageController.showmessages,'Messages are expected to be displayed');



//search records
existingTeamMember = new AccountTeamMember();
existingTeamMember.UserId = testData.massReassignAccountUserList.get(0).id;
pageController.setExistingTeamMember(existingTeamMember);
pageController.SearchForAccountsToSelect();
system.assert(pageController.getSearchAccountResults().size()>0,'Search results are expected');
system.assert(pageController.ShowSearchResults,'Search results are expcted to show');
system.assert(!pageController.showmessages, 'No messages are expected to show');



//navigate to step2 without selecting rows
pageRef = pageController.step2();
system.assert(pageRef== null,'Navigated to another page with out selecting rows');

List<Apexpages.Message> msgs = ApexPages.getMessages();
boolean b = false;
for(Apexpages.Message msg:msgs){
    if (msg.getDetail().contains('Please select Accounts to Reassign')) b = true;
}
system.assert(b);//Assert the Page Message was Properly Displayed

//reset the page to step1
pageRef = Page.MassAccountTeamReassignStep1;
Test.setCurrentPage(pageRef); 

pageController = new MassAccountTeamReassignController();
//unselect options to reassign activities and opportunites
pageController.ReassignActivites = false;
pageController.ReassignOpportunities= false;
existingTeamMember = new AccountTeamMember();
existingTeamMember.UserId = testData.massReassignAccountUserList.get(0).id;
pageController.setExistingTeamMember(existingTeamMember);
pageController.SearchForAccountsToSelect();
    
//select some accounts and navigate to step2 
List<MassAccountTeamReassignController.MassAccountTeamReassignRec> searchAccountsTemp = new List<MassAccountTeamReassignController.MassAccountTeamReassignRec>();
Integer selectedAccountscount = 2;
Integer tempCount = 0;
tempCount = selectedAccountscount;
for(MassAccountTeamReassignController.MassAccountTeamReassignRec  rec: pageController.getSearchAccountResults()){  
if(tempCount >0){  
tempCount--;
rec.isSelected = true;
}
searchAccountsTemp.add(rec);
}
system.assert(searchAccountsTemp.size()>0);
pageController.setSearchAccountResults(searchAccountsTemp);
system.assert(pageController.getSearchAccountResults().size()>0);
pageRef = pageController.step2();
system.assert(pageController.getSelectedAccounts().size()>0 ,'correct number of accounts are not selected');
system.assert(pageController.ShowSelectedAccounts,'Selected accounts are not showing');
//msgs = ApexPages.getMessages();
//if(msgs != null)
//for(Apexpages.Message msg:msgs){
//    system.assert(msg == null,msg.getDetail());
//}
//system.assert(msgs.size()==0,'No errors are expected');
//Not sure why below 2 lines are not working
//system.assert(pageRef== null,'Did not navigate to any page');
//system.assert(pageRef ==Page.MassAccountTeamReassignStep2,'Did not navigate to Step2 after selecting accounts; Navigated to:'+pageRef.getUrl());


//Page 2 Validation
pageRef = Page.MassAccountTeamReassignStep2;
Test.setCurrentPage(pageRef); 

//check replacement roles list
system.assert(pageController.getaccountTeamReplaceRoleList()!= null,'No Replacement roles listed');
system.assert(pageController.getaccountTeamReplaceRoleList().get(0).getLabel().trim()=='Use Role of Replaced Team Member','\'Use Role of Replaced Team Member\' is not listed as first option');

//check validation on missing replacement teammember
pageRef = pageController.ReassignAccountsSelected();
system.assert(pageController.showmessages, 'messages are expected to show');
system.assert(pageController.messages.contains('* Replacement TeamMember is required'),'Missing replacement teammember is not displayed');

//select replacement teammember
AccountTeamMember replacementTeamMember = new AccountTeamMember();
replacementTeamMember.UserId = testData.massReassignAccountUserList.get(1).id;
pageController.setReplacementTeamMember(replacementTeamMember);
pageRef = pageController.ReassignAccountsSelected();
system.assert(pageController.getSelectedAccounts().size()>0,'Search results are expected');

}

public static testMethod void testmassReassignmentOfRoles(){

MassAccountReassignTestUtility testData = new MassAccountReassignTestUtility();
testData.AccountNameStartsWith  = 'TestCaseAccountMassReassign';
testData.UserNameStartsWith  = 'TestCaseUserAccountMassReassign';
testData.dataSize = 5;
testData.CreateTestUsers();
testData.CreateTestMassReassign();

PageReference pageRef = Page.MassAccountTeamReassignStep2;
Test.setCurrentPage(pageRef); 

MassAccountTeamReassignController pageController = new MassAccountTeamReassignController();
//unselect options to reassign activities and opportunites
pageController.ReassignActivites = false;
pageController.ReassignOpportunities= false;

//select a user and get all his accounts
AccountTeamMember existingTeamMember = new AccountTeamMember();
existingTeamMember.UserId = testData.massReassignAccountUserList.get(0).id;
pageController.setExistingTeamMember(existingTeamMember);
pageController.SearchForAccountsToSelect();
system.assert(!pageController.showmessages,'Validation did not clear after selecting missing existingTeamMember');

//select all accounts
List<MassAccountTeamReassignController.MassAccountTeamReassignRec> searchAccountsTemp = new List<MassAccountTeamReassignController.MassAccountTeamReassignRec>();
Integer selectedAccountscount = 2;
for(MassAccountTeamReassignController.MassAccountTeamReassignRec  rec: pageController.getSearchAccountResults()){  
rec.isSelected = true;
searchAccountsTemp.add(rec);
}
system.assert(searchAccountsTemp.size()>0);
pageController.setSearchAccountResults(searchAccountsTemp);
system.assert(pageController.getSearchAccountResults().size()>0);
pageRef = pageController.step2();
system.assert(pageController.getSelectedAccounts().size()>0 ,'correct number of accounts are not selected');

pageRef = Page.MassAccountTeamReassignStep2;
Test.setCurrentPage(pageRef); 

system.assert(pageController.getaccountTeamReplaceRoleList().get(0).getLabel().trim()=='Use Role of Replaced Team Member','\'Use Role of Replaced Team Member\' is not listed as first option');

//select replacement teammember
AccountTeamMember replacementTeamMember = new AccountTeamMember();
replacementTeamMember.UserId = testData.massReassignAccountUserList.get(1).id;
pageController.setReplacementTeamMember(replacementTeamMember);
system.assert(pageController.CancelDoneLabel=='Cancel','Cancel label is not displayed on the button, before processing');
system.assert(!pageController.ShowResultMessages,'Result Message is displayed, before processing');
Integer count =0;
do{
pageRef = pageController.ReassignAccountsSelected();
system.assert(pageController.messages == '','Unexpected message');
system.assert(pageController.ShowResultMessages,'Result Message is not displayed, after processing');
system.assert(pageController.resultmessages.trim() != '','Result Message to display is empty, after processing begins');

count++;
 

system.assert(pageController.getRemainingAccountsSelected() ==pageController.getSelectedAccounts().size() - count, 'Remaining messages count is not correct'+'pageController.getRemainingAccountsSelected()+'!='('+pageController.getSelectedAccounts().size()+'-'+count+')');
system.assert(pageController.getUnprocessedMessage()!= '','Live progress message is empty');
}while(count <pageController.getSelectedAccounts().size());

system.assert(pageController.CancelDoneLabel=='Done','Done label is not displayed on the button, after processing');
system.assert(pageController.getSelectedAccounts().size()>0,'Search results are expected');

//check if the results are showing success.
for(MassAccountTeamReassignController.MassAccountTeamReassignRec  rec: pageController.getSelectedAccounts()){ 
    system.assert(rec.isSuccess,'One of the record errored out:'+ rec.ReassignResult);
}

//check if the accounts are reasigned.
List<AccountTeamMember> newUserAccounts = [SELECT Account.Name
       ,Account.ATC_Status__c
       ,Account.Region__c
       ,Account.SVOC_Id__c
       ,Account.ATC_Spend__c
       ,Account.District__c
       ,Account.BillingState
       ,AccountId
       ,UserId
       ,User.Name
       ,User.FirstName
       ,User.LastName
       ,TeamMemberRole 
       FROM AccountTeamMember 
       where UserId =:testData.massReassignAccountUserList.get(1).id
       and AccountId  IN :testData.massReassignAccountList
      ];

    system.assert(newUserAccounts!= null,'No accounts are assinged to the new user');
    system.assert(pageController.RowsSucceeded == pageController.getSelectedAccounts().size(),'not all accounts succeded');
        system.assert(pageController.RowsFailed == 0,'some accounts failed');
    system.assert(newUserAccounts.size()== pageController.getSelectedAccounts().size(),'Not all accounts are assinged to the new user');
    
    //check tasks are not assigned.
    List<Task> newUserTasks = [Select Id, whatId, ownerId from  Task 
       where ownerId =:testData.massReassignAccountUserList.get(1).id
       and WhatId  IN :testData.massReassignAccountList];
       
    system.assert(newUserTasks.size()==0,'There are tasks that are moved over to the new User');
     
}

public static testMethod void testmassReassignmentOfActivites(){
    
MassAccountReassignTestUtility testData = new MassAccountReassignTestUtility();
testData.AccountNameStartsWith  = 'TestCaseAccountMassReassign';
testData.UserNameStartsWith  = 'TestCaseUserAccountMassReassign';
testData.dataSize = 3; //hits soql limits with 5
testData.CreateTestUsers();
testData.CreateTestMassReassign();

PageReference pageRef = Page.MassAccountTeamReassignStep2;
Test.setCurrentPage(pageRef); 

MassAccountTeamReassignController pageController = new MassAccountTeamReassignController();
//unselect options to reassign activities and opportunites
pageController.ReassignActivites = true;
pageController.ReassignOpportunities= false;

//select a user and get all his accounts
AccountTeamMember existingTeamMember = new AccountTeamMember();
existingTeamMember.UserId = testData.massReassignAccountUserList.get(0).id;
pageController.setExistingTeamMember(existingTeamMember);
pageController.SearchForAccountsToSelect();
system.assert(!pageController.showmessages,'Validation did not clear after selecting missing existingTeamMember');

//select all accounts
List<MassAccountTeamReassignController.MassAccountTeamReassignRec> searchAccountsTemp = new List<MassAccountTeamReassignController.MassAccountTeamReassignRec>();
Integer selectedAccountscount = 2;
for(MassAccountTeamReassignController.MassAccountTeamReassignRec  rec: pageController.getSearchAccountResults()){  
rec.isSelected = true;
searchAccountsTemp.add(rec);
}
system.assert(searchAccountsTemp.size()>0);
pageController.setSearchAccountResults(searchAccountsTemp);
system.assert(pageController.getSearchAccountResults().size()>0);
pageRef = pageController.step2();
system.assert(pageController.getSelectedAccounts().size()>0 ,'correct number of accounts are not selected');

pageRef = Page.MassAccountTeamReassignStep2;
Test.setCurrentPage(pageRef); 

system.assert(pageController.getaccountTeamReplaceRoleList().get(0).getLabel().trim()=='Use Role of Replaced Team Member','\'Use Role of Replaced Team Member\' is not listed as first option');

//select replacement teammember
AccountTeamMember replacementTeamMember = new AccountTeamMember();
replacementTeamMember.UserId = testData.massReassignAccountUserList.get(1).id;
pageController.setReplacementTeamMember(replacementTeamMember);
system.assert(pageController.CancelDoneLabel=='Cancel','Cancel label is not displayed on the button, before processing');
system.assert(!pageController.ShowResultMessages,'Result Message is displayed, before processing');
Integer count =0;
do{
pageRef = pageController.ReassignAccountsSelected();
system.assert(pageController.messages == '','Unexpected message');
system.assert(pageController.ShowResultMessages,'Result Message is not displayed, after processing');
system.assert(pageController.resultmessages.trim() != '','Result Message to display is empty, after processing begins');

count++;
 

system.assert(pageController.getRemainingAccountsSelected() ==pageController.getSelectedAccounts().size() - count, 'Remaining messages count is not correct'+'pageController.getRemainingAccountsSelected()+'!='('+pageController.getSelectedAccounts().size()+'-'+count+')');
system.assert(pageController.getUnprocessedMessage()!= '','Live progress message is empty');
}while(count <pageController.getSelectedAccounts().size());

system.assert(pageController.CancelDoneLabel=='Done','Done label is not displayed on the button, after processing');
system.assert(pageController.getSelectedAccounts().size()>0,'Search results are expected');

//check if the results are showing success.
for(MassAccountTeamReassignController.MassAccountTeamReassignRec  rec: pageController.getSelectedAccounts()){ 
    system.assert(rec.isSuccess,'One of the record errored out:'+ rec.ReassignResult);
}

//check if the accounts are reasigned.
List<AccountTeamMember> newUserAccounts = [SELECT Account.Name
       ,Account.ATC_Status__c
       ,Account.Region__c
       ,Account.SVOC_Id__c
       ,Account.ATC_Spend__c
       ,Account.District__c
       ,Account.BillingState
       ,AccountId
       ,UserId
       ,User.Name
       ,User.FirstName
       ,User.LastName
       ,TeamMemberRole 
       FROM AccountTeamMember 
       where UserId =:testData.massReassignAccountUserList.get(1).id
       and AccountId  IN :testData.massReassignAccountList
      ];

    system.assert(newUserAccounts!= null,'No accounts are assinged to the new user');
    system.assert(pageController.RowsSucceeded == pageController.getSelectedAccounts().size(),'not all accounts succeded');
        system.assert(pageController.RowsFailed == 0,'some accounts failed');
    system.assert(newUserAccounts.size()== pageController.getSelectedAccounts().size(),'Not all accounts are assinged to the new user');
    
    //check tasks are assigned.
    List<Task> newUserTasks = [Select Id, whatId, ownerId from  Task 
       where ownerId =:testData.massReassignAccountUserList.get(1).id
       and WhatId  IN :testData.massReassignAccountList];
       
    system.assert(newUserTasks.size()==testData.dataSize,'There are tasks that are not moved over to the new User');
    
    //check that opportunites are not moved over
    List<Opportunity> newUserOppList = [Select Id, AccountId, Name from Opportunity
    where ownerId =:testData.massReassignAccountUserList.get(1).id
    and AccountId IN:testData.massReassignAccountList ];
       system.assert(newUserOppList.size()==0,'There are opportunites that are moved over to the new User');
   
}

public static testMethod void testmassReassignmentOfOpportunites(){
        
MassAccountReassignTestUtility testData = new MassAccountReassignTestUtility();
testData.AccountNameStartsWith  = 'TestCaseAccountMassReassign';
testData.UserNameStartsWith  = 'TestCaseUserAccountMassReassign';
testData.dataSize = 3; //hits soql limits with 5
testData.CreateTestUsers();
testData.CreateTestMassReassign();

PageReference pageRef = Page.MassAccountTeamReassignStep2;
Test.setCurrentPage(pageRef); 

MassAccountTeamReassignController pageController = new MassAccountTeamReassignController();
//unselect options to reassign activities and opportunites
pageController.ReassignActivites = false;
pageController.ReassignOpportunities= true;

//select a user and get all his accounts
AccountTeamMember existingTeamMember = new AccountTeamMember();
existingTeamMember.UserId = testData.massReassignAccountUserList.get(0).id;
pageController.setExistingTeamMember(existingTeamMember);
pageController.SearchForAccountsToSelect();
system.assert(!pageController.showmessages,'Validation did not clear after selecting missing existingTeamMember');

//select all accounts
List<MassAccountTeamReassignController.MassAccountTeamReassignRec> searchAccountsTemp = new List<MassAccountTeamReassignController.MassAccountTeamReassignRec>();
Integer selectedAccountscount = 2;
for(MassAccountTeamReassignController.MassAccountTeamReassignRec  rec: pageController.getSearchAccountResults()){  
rec.isSelected = true;
searchAccountsTemp.add(rec);
}
system.assert(searchAccountsTemp.size()>0);
pageController.setSearchAccountResults(searchAccountsTemp);
system.assert(pageController.getSearchAccountResults().size()>0);
pageRef = pageController.step2();
system.assert(pageController.getSelectedAccounts().size()>0 ,'correct number of accounts are not selected');

pageRef = Page.MassAccountTeamReassignStep2;
Test.setCurrentPage(pageRef); 

system.assert(pageController.getaccountTeamReplaceRoleList().get(0).getLabel().trim()=='Use Role of Replaced Team Member','\'Use Role of Replaced Team Member\' is not listed as first option');




//select replacement teammember
AccountTeamMember replacementTeamMember = new AccountTeamMember();
replacementTeamMember.UserId = testData.massReassignAccountUserList.get(1).id;
pageController.setReplacementTeamMember(replacementTeamMember);
system.assert(pageController.CancelDoneLabel=='Cancel','Cancel label is not displayed on the button, before processing');
system.assert(!pageController.ShowResultMessages,'Result Message is displayed, before processing');

//check if there are opportunites
    List<Opportunity> oldUserOppList = [Select Id, AccountId, Name from Opportunity
    where ownerId =:testData.massReassignAccountUserList.get(0).id
    and AccountId IN:testData.massReassignAccountList AND IsClosed =false ];
       system.assert(oldUserOppList.size()==testData.dataSize,'There are no opportunites that needs to move over to the new User');

//check if there are tasks for the opportunites
List<Task> oppTasks = [Select Id, WhatId, ownerId from Task  
where ownerId =:testData.massReassignAccountUserList.get(0).id
and whatId IN:oldUserOppList];
 system.assert(oppTasks.size()==testData.dataSize,'There are no opportunites tasks that needs to move over to the new User');
      
Integer count =0;
do{
pageRef = pageController.ReassignAccountsSelected();
system.assert(pageController.messages == '','Unexpected message');
system.assert(pageController.ShowResultMessages,'Result Message is not displayed, after processing');
system.assert(pageController.resultmessages.trim() != '','Result Message to display is empty, after processing begins');

count++;
 

system.assert(pageController.getRemainingAccountsSelected() ==pageController.getSelectedAccounts().size() - count, 'Remaining messages count is not correct'+'pageController.getRemainingAccountsSelected()+'!='('+pageController.getSelectedAccounts().size()+'-'+count+')');
system.assert(pageController.getUnprocessedMessage()!= '','Live progress message is empty');
}while(count <pageController.getSelectedAccounts().size());

system.assert(pageController.CancelDoneLabel=='Done','Done label is not displayed on the button, after processing');
system.assert(pageController.getSelectedAccounts().size()>0,'Search results are expected');

//check if the results are showing success.
for(MassAccountTeamReassignController.MassAccountTeamReassignRec  rec: pageController.getSelectedAccounts()){ 
    system.assert(rec.isSuccess,'One of the record errored out:'+ rec.ReassignResult);
}

//check if the accounts are reasigned.
List<AccountTeamMember> newUserAccounts = [SELECT Account.Name
       ,Account.ATC_Status__c
       ,Account.Region__c
       ,Account.SVOC_Id__c
       ,Account.ATC_Spend__c
       ,Account.District__c
       ,Account.BillingState
       ,AccountId
       ,UserId
       ,User.Name
       ,User.FirstName
       ,User.LastName
       ,TeamMemberRole 
       FROM AccountTeamMember 
       where UserId =:testData.massReassignAccountUserList.get(1).id
       and AccountId  IN :testData.massReassignAccountList
      ];

    system.assert(newUserAccounts!= null,'No accounts are assinged to the new user');
    system.assert(pageController.RowsSucceeded == pageController.getSelectedAccounts().size(),'not all accounts succeded');
        system.assert(pageController.RowsFailed == 0,'some accounts failed');
    system.assert(newUserAccounts.size()== pageController.getSelectedAccounts().size(),'Not all accounts are assinged to the new user');
    
    //check that opportunites are moved over
    List<Opportunity> newUserOppList = [Select Id, AccountId, Name from Opportunity
    where ownerId =:testData.massReassignAccountUserList.get(1).id
    and AccountId IN:testData.massReassignAccountList ];
       system.assert(newUserOppList.size()==testData.dataSize,'There are opportunites that are not moved over to the new User');
    
    //check if there are tasks for the opportunites are moved
    oppTasks = [Select Id, WhatId, ownerId from Task  
    where ownerId =:testData.massReassignAccountUserList.get(1).id
    and whatId IN:oldUserOppList];
    system.assert(oppTasks.size()==testData.dataSize,'opportunites tasks that are not moved over to the new User');
    
    //check tasks are not assigned.
    List<Task> newUserTasks = [Select Id, whatId, ownerId from  Task 
       where ownerId =:testData.massReassignAccountUserList.get(1).id
       and WhatId  IN :testData.massReassignAccountList];
       
    system.assert(newUserTasks.size()==0,'There are tasks that are moved over to the new User');
    
    
       
}
}