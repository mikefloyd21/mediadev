global  class scheduleUpdateAccountTeamwithDSM implements Schedulable{

   global void execute(SchedulableContext ctx) 
   {
        startFlow();
   }
    public void startFlow()
    {
        Map<string, object> params = new Map<string, object>();
        LIST<String> theRegions = new LIST<String>();
        for(Account_Team_Update_Settings__mdt regions :  [Select Regions__c From Account_Team_Update_Settings__mdt where MasterLabel = 'AccountTeamUpdates'])
        {
            theRegions.add(regions.Regions__c);
        }
        
        system.debug('LIST OF REGIONS: '+ theRegions);

        
        //  get accounts with no AC
        List<ID> listofAcct = new List<ID>();
        for(Account acct : [Select Id, Name, SVOC_Region__c, SalesIQ__Account_Status__c, Sales_Segmentation__c, Sales_View_Flag__c from Account 
where Id NOT IN (Select AccountID From AccountTeamMember where TeamMemberRole = 'Advertising Consultant - ATC') 
AND (SalesIQ__Account_Status__c NOT IN ('Transfer to MA', 'Transfer to DSC', 'Not a Car Dealership')) 
AND SVOC_Id__c != null AND Sales_View_Flag__c = 'Yes' 
AND (Sales_Segmentation__c = 'Yes' OR Sales_Segmentation__c = '') 
AND SVOC_Region__c IN ('10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24', '25', '26', '27', '28', '29', '30') 
//AND SVOC_Region__c IN :theRegions
AND Id IN (select SalesIQ__Account__c from SalesIQ__Position_Account__c )])
        {
            listofAcct.add(acct.id);
            }
        system.debug('LIST OF ACCOUNTS: '+ listofAcct);
        params.put('varAccountList', listofAcct);
        
        
        system.debug('FLOW INIT:Update_Account_Team_with_DSM_when_no_AC_headless - params'+ params);
        if (params!=null)
        {       
            //  pass list to flow
           Flow.Interview.Update_Account_Team_with_DSM_when_no_AC_headless uatDSM = new Flow.Interview.Update_Account_Team_with_DSM_when_no_AC_headless(params);
            system.debug('FLOW STARTING:Update_Account_Team_with_DSM_when_no_AC_headless');
            uatDSM.start(); 
        } 
        else
            system.debug('FLOW NOT RUN - list empty');      
    }
}