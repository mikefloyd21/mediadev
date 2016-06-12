public with sharing class SVOCRequest_Controller
{

  
    public SVOCRequest_Controller() {

    }
    private Set<Account> dupWarningAccounts {get; set;} 

public  List<Account> dupWarningAccountsList {
    get {
            List<Account> accounts = new List<Account>();
            if (dupWarningAccounts != null && !dupWarningAccounts.isEmpty())
             accounts.addAll(dupWarningAccounts);
             return accounts;
        }
    }

public PageReference Validate()
{
    return null;
}
public boolean dupsFound
{
    get
    {
        if (dupWarningAccountsList == null || dupWarningAccountsList.isEmpty())
        {
            return false;   
        }
        else
        {
            return true;
        }
    }
}

public PageReference ForceSave()
{
       // No matches were found, try to save.
        try
        {
 
            insert this.newSVOCRequest;
        }
        catch ( Exception e )
        {
            ApexPages.addMessages( e );
            return null;
        }
        return new pageReference( '/' + this.newSVOCRequest.id );
}

private final SVOC_Request__c newSVOCRequest;
    public SVOCRequest_Controller( ApexPages.StandardController stdController )
    {
        this.newSVOCRequest = (SVOC_Request__c)stdController.getRecord();
    }
    
    public PageReference redirectDefaultSVOCRequest()
    {
        Map<ID, Schema.RecordTypeInfo> rtMap = Schema.SObjectType.SVOC_Request__c.getRecordTypeInfosById();
         System.debug('****RecordTypes Count*****');
         System.debug(rtMap.size());
        for(String key : rtMap.keySet())
        {
            System.debug(key);
            System.debug(rtMap.get(key).getName());
        }
        
        string svocRequestId = ApexPages.currentPage().getParameters().get('id');
        
        //Handle new records
        if(svocRequestId == null)
        {
        string svocRequestRecordTypeId = ApexPages.currentPage().getParameters().get('RecordType');
        

        

           System.debug('****************RecordTypeId**********');
        System.debug(svocRequestRecordTypeId);
        
        
        
        string svocRequestRecordTypeName = rtMap.get(svocRequestRecordTypeId).getName();
        
        System.debug('****************RecordTypeName**********');
        System.debug(svocRequestRecordTypeName);

        //Create record type
        //if (svocRequestRecordType == '012M00000008u7O') {
         if (svocRequestRecordTypeName == 'Create') {
         PageReference svocRequestCreate = Page.SVOCRequestCreate;
           svocRequestCreate.getParameters().put('Id', this.newSVOCRequest.Id);
            //copy the rest of the parameters
            Map<String, String> params = ApexPages.currentPage().getParameters();
            for(string param : params.keySet())
            {
                 svocRequestCreate.getParameters().put(param, params.get(param));
            }
            svocRequestCreate.setRedirect(true);
           return svocRequestCreate;
    
        } else {
            
                  Schema.DescribeSObjectResult R = SVOC_Request__c.SObjectType.getDescribe();
                    // Add /o to end of URL to view recent
                   PageReference defaultNewPage = new PageReference('/' + R.getKeyPrefix() + '/e');
                     //copy the rest of the parameters
                    Map<String, String> params = ApexPages.currentPage().getParameters();
                    for(string param : params.keySet())
                    {
                         defaultNewPage.getParameters().put(param, params.get(param));
                    }
                    defaultNewPage.getParameters().put('nooverride', '1');
                    defaultNewPage.getParameters().remove('save_new');
                    defaultNewPage.getParameters().remove('sfdc.override');
                   
                   return  defaultNewPage;
        }
        }
        else // Handle existing record
        {
            SVOC_Request__c svocRequest = [Select id, recordtypeid from SVOC_Request__c where Id = :svocRequestId];
             System.debug('****************RecordTypeId**********');
             
              string svocRequestRecordTypeId = svocRequest.RecordTypeId;
        System.debug(svocRequestRecordTypeId);
        
        
        
        string svocRequestRecordTypeName = rtMap.get(svocRequestRecordTypeId).getName();
        
        System.debug('****************RecordTypeName**********');
        System.debug(svocRequestRecordTypeName);
          if (svocRequestRecordTypeName == 'Create') {
         PageReference svocRequestCreate = Page.SVOCRequestCreate;
           svocRequestCreate.getParameters().put('Id', this.newSVOCRequest.Id);
            //copy the rest of the parameters
            Map<String, String> params = ApexPages.currentPage().getParameters();
            for(string param : params.keySet())
            {
                 svocRequestCreate.getParameters().put(param, params.get(param));
            }
            svocRequestCreate.setRedirect(true);
           return svocRequestCreate;
    
        } else {
                              
                    PageReference defaultEditPage =  new ApexPages.StandardController(svocRequest).edit();
                    string retUrl = '';
                    //remove the rest of the parameters
                    Map<String, String> params = ApexPages.currentPage().getParameters();
                    for(string param : params.keySet())
                    {
                        if(param == 'retURL')
                        {
                            retUrl = params.get(param);
                        }
                         defaultEditPage.getParameters().remove(param);
                    }
                    defaultEditPage.getParameters().put('retURL', retUrl);
                    defaultEditPage.getParameters().put('nooverride', '1');                 
                    defaultEditPage.getParameters().remove('sfdc.override');
                    return defaultEditPage;
        }
        
        
        }
    }
    
    public pageReference saveSVOCRequest()
    {
    
     // Create a temp account record with details from current record 
     // and see if it matches any existing accounts
     Account tempAccount = new Account();
     tempAccount.Name = this.newSVOCRequest.New_Customer_Name__c;
     tempAccount.BillingStreet =  this.newSVOCRequest.Street_Name__c;
     tempAccount.BillingState = this.newSVOCRequest.State__c;
     tempAccount.BillingCity = this.newSVOCRequest.City__c;
     tempAccount.BillingPostalCode = this.newSVOCRequest.Zip_Code__c;
     tempAccount.ShippingStreet =  this.newSVOCRequest.Street_Name__c;
     tempAccount.ShippingState = this.newSVOCRequest.State__c;
     tempAccount.ShippingCity = this.newSVOCRequest.City__c;
     tempAccount.ShippingPostalCode = this.newSVOCRequest.Zip_Code__c;
     
     // Loook for duplicates in accounts before trying to save.
     List<CRMfusionDBR101.DB_Api.Matches> matchSets = CRMfusionDBR101.DB_Api.findMatches( tempAccount );
      if ( matchSets.isEmpty() )
        {
            // No matches were found, try to save.
            try
            {
                insert this.newSVOCRequest;
            }
            catch ( Exception e )
            {
                ApexPages.addMessages( e );
                return null;
            }
            return new pageReference( '/' + this.newSVOCRequest.id );
        }
      else
        {
            // Matches were found, just display the list of matching ids in an error
            // message as a basic example.

            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.WARNING, 'Duplicate Accounts found!'));   
            dupWarningAccounts = new Set<Account>();         
            for ( CRMfusionDBR101.DB_Api.Matches matchSet : matchSets )
                for ( Id accountId : matchSet.matchedIds )
                {
                    //get account details
                    Account dupAccount = [Select Id, Name,Dealer_Nameplates__c,ShippingStreet,ShippingCity,ShippingState,ShippingPostalCode,ShippingCountry,Website,Phone,SVOC_Status__c from Account where Id=: accountId];
                    //string acccountDetails = '<a href="/' + dupAccount.Id+'" target="_blank">'+dupAccount.Name+'</a>';
                    //ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, acccountDetails ));
                    if(!dupWarningAccounts.contains(dupAccount))
                    {
                        dupWarningAccounts.add(dupAccount);
                    }                    
                }

            return null;
        }
    }
}