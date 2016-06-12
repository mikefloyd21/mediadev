global class OpportunityTeamUpdates {
    private static final List<String> filteredOutProductBU = new List<String>{'CDM', 'Dealer.com', 'Haystak', 'vAuto', 'VinSolutions', 'HomeNet'};
	private static final List<String> filteroutOutBookofBusiness = new List<String>{'Dealer.com', 'HAY', 'VIN'};
    private static final String TIM_TEAM_ROLE_CONST = 'Product Specialist - TIM';
	private static final String ATC_TEAM_ROLE_CONST = 'Product Specialist - ATC';
    
	private static List<OpportunityTeamMember> oppTeamToUpdate = new List<OpportunityTeamMember>();
    
    @InvocableMethod(label='Update Opportunity Team' description='Updates the Opportunity Team based on the provided Account Id')
    public static void updateOpportunityTeam(List<Id> AccountIds){
        
         //this will be list passed in from class
        //List<Id> accountIds = new List<Id> { '001560000067qRA'};
    
        //list of team member roles for sql IN queries -- populate with constant strings
        List<String> teamMemberRoles = new List<String>{TIM_TEAM_ROLE_CONST, ATC_TEAM_ROLE_CONST};
    
        List<Opportunity> oppList = new List<Opportunity>();
        List<AccountTeamMember> teamMemberList = new List<AccountTeamMember>();
        List<OpportunityTeamMember> oppTeamMembers = new List<OpportunityTeamMember>();
        List<OpportunityLineItem> oppLineItems = new List<OpportunityLineItem>();
        
        Map<String, AccountTeamMember> acctTeamMap = new Map<String, AccountTeamMember>();
        Map<String, OpportunityTeamMember> oppTeamMap = new Map<String, OpportunityTeamMember>();
        
        List<Account> accts = [SELECT Id,Name,
        (Select Id, Name From Opportunities),
        (Select UserId, TeamMemberRole, LastModifiedDate From AccountTeamMembers WHERE TeamMemberRole IN :teamMemberRoles ORDER by CreatedDate Desc)
        from Account WHERE Id IN :AccountIds];
        
        //populate the list with all opportunities and the accountteam with all members
        for(Account account : accts){
            oppList.addAll(account.Opportunities);
            teamMemberList.addAll(account.AccountTeamMembers);
        }
        
        for(Opportunity oppty : oppList){
        	System.debug('The opportunity name is ' + oppty.Name);
        }
        
        //add account team members to map so we can look up by team member by role name as we later iterate over opportunities. Will allow us 
        Integer timRoleCount = 0;
        Integer atcRoleCount = 0;
        List<AccountTeamMember> acctTeamToRemove = new List<AccountTeamMember>();
        
        for(AccountTeamMember acctTeamMember : teamMemberList){
            if(acctTeamMember.TeamMemberRole.equals(TIM_TEAM_ROLE_CONST)){
                timRoleCount ++;
                if(timRoleCount > 1){
                    acctTeamToRemove.add(acctTeamMember);
                }
            }
            else{
            	acctTeamMap.put(acctTeamMember.TeamMemberRole, acctTeamMember);
            }
             if(acctTeamMember.TeamMemberRole.equals(ATC_TEAM_ROLE_CONST)){
                atcRoleCount ++;
                if(atcRoleCount > 1){
                    acctTeamToRemove.add(acctTeamMember);
                }
            }
            else{
            	acctTeamMap.put(acctTeamMember.TeamMemberRole, acctTeamMember);
            }
            
        }
        
        List<OpportunityTeamMember> oppTeamToRemove = new List<OpportunityTeamMember>();
        //maybe just do DML delete where matches query
        oppTeamMembers = [Select UserId, OpportunityId, TeamMemberRole from OpportunityTeamMember where OpportunityId IN : oppList and TeamMemberRole IN : teamMemberRoles];
        //iterate over opp team members and put in a map
        for(OpportunityTeamMember oppTeamMember : oppTeamMembers){
            if(oppTeamMember.TeamMemberRole.equals(TIM_TEAM_ROLE_CONST) || oppTeamMember.TeamMemberRole.equals(ATC_TEAM_ROLE_CONST)){
                oppTeamToRemove.add(oppTeamMember);
            }
            oppTeamMap.put(oppTeamMember.TeamMemberRole, oppTeamMember);
        }
        
        //is there a way to get opportunities, products, and opportunitylineitems at the same time
        oppLineItems = [Select OpportunityId, PricebookEntry.Product2.Name,PricebookEntry.Product2.isActive, PricebookEntry.Product2.Product_BU__c, PricebookEntry.Product2.TIM_Product__c, PricebookEntry.Product2.Book_of_Business__c
                        from OpportunityLineItem Where OpportunityId IN :oppList AND PricebookEntry.Product2.Product_BU__c NOT IN : filteredOutProductBU AND 
                       PriceBookEntry.Product2.Book_of_Business__c NOT IN :filteroutOutBookofBusiness AND PricebookEntry.Product2.isActive = true];
        
        //delete duplicate account team
        try{
           delete acctTeamToRemove;             
        }
        catch(DMLException e){
           
        }

        String timMapKey = '';
        String atcMapKey = '';

        for(OpportunityLineItem oppLineItem : oppLineItems){
            //if it is a TIM product and there is someone in the TIM role on the account team, and there isn't already someone in that role and opportunity         
            if(oppLineItem.PricebookEntry.Product2.Tim_Product__c){
            	timMapKey = oppLineItem.OpportunityId + TIM_TEAM_ROLE_CONST;
                if(Null != acctTeamMap.get(TIM_TEAM_ROLE_CONST)){
                	if(Null == oppTeamMap.get(timMapKey)){
                    	AccountTeamMember teamMember = acctTeamMap.get(TIM_TEAM_ROLE_CONST);
                    	System.debug('The opportunity id is ' + oppLineItem.OpportunityId + ' and the team role is ' + teamMember.TeamMemberRole + ' and we are in TIM');
                        OpportunityTeamMember opportunityTeamMember = new OpportunityTeamMember();
                        opportunityTeamMember.UserId = teamMember.UserId;
                        opportunityTeamMember.OpportunityId = oppLineItem.OpportunityId;
                        //opportunityTeamMember.OpportunityAccessLevel = 'EDIT';
                        opportunityTeamMember.TeamMemberRole = teamMember.TeamMemberRole;
                        oppTeamToUpdate.add(opportunityTeamMember);      
                        oppteamMap.put(timMapKey, OpportunityTeamMember);            
                    }
                }                 
            }
            else{
              if(Null != acctTeamMap.get(ATC_TEAM_ROLE_CONST)){
              		atcMapKey = oppLineItem.OpportunityId + ATC_TEAM_ROLE_CONST;
              		if(Null != acctTeamMap.get(ATC_TEAM_ROLE_CONST)){
              			if(Null == oppTeamMap.get(atcMapKey)){
		                    AccountTeamMember teamMember = acctTeamMap.get(ATC_TEAM_ROLE_CONST);
		                	System.debug('The opportunity id is ' + oppLineItem.OpportunityId + ' and the team role is ' + teamMember.TeamMemberRole + ' and we are in ATC');
		                    OpportunityTeamMember opportunityTeamMember = new OpportunityTeamMember();
		                    opportunityTeamMember.UserId = teamMember.UserId;
		                    opportunityTeamMember.OpportunityId = oppLineItem.OpportunityId;
		                   // opportunityTeamMember.OpportunityAccessLevel = 'EDIT';
		                    opportunityTeamMember.TeamMemberRole = teamMember.TeamMemberRole;
		                    oppTeamToUpdate.add(opportunityTeamMember);
		                    //addMemberToOpportunityTeam(teamMember, oppLineItem.OpportunityId);
		                    oppTeamMap.put(atcMapKey, OpportunityTeamMember);
              			}
              		}
                    
                }     
            }
          
        }
        
        
        try{
           delete oppTeamToRemove;
           insert oppTeamToUpdate;
        }
        catch(DMLException e){
            System.debug('that did not work at all');
        }      
 		    	
    }
}