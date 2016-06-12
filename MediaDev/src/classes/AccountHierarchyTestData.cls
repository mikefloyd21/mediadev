public with sharing class AccountHierarchyTestData{

    public String AccountNameStartsWith = 'TestHierarchyAccount';
    public Map<String, Account>        mapAccList = new Map<String, Account>();
   
public Customer_Hierarchy__c CreateHierarchyRelation(Account parent , Account child, string type){
Customer_Hierarchy__c ch = new Customer_Hierarchy__c();
ch.Account__c = parent.id;
ch.Related_Account__c = child.id;
ch.Name= type;
ch.Type__c= type;
insert ch;
return ch;
}
public Account GetAccount(Integer index){
    //system.debug('Getting Account by Name:' + AccountNameStartsWith+string.valueOf(index));
    return mapAccList.get(AccountNameStartsWith+string.valueOf(index));
}


   
   public void createAccounts( Integer accountToCreate ){

    List<Account> auxList = new List<Account>();
    
    for( Integer i = 1; i <= accountToCreate; i++ ){
        Account accAux              = new Account();
        accAux.Name                 = AccountNameStartsWith+i;
        accAux.ShippingStreet       = '1 Main St.';
        accAux.ShippingState        = 'VA';
        accAux.ShippingPostalCode   = '12345';
        accAux.ShippingCountry      = 'USA';
        accAux.ShippingCity         = 'Anytown';
        accAux.Description          = 'This is a test account';
        accAux.BillingStreet        = '1 Main St.';
        accAux.BillingState         = 'VA';
        accAux.BillingPostalCode    = '12345';
        accAux.BillingCountry       = 'USA';
        accAux.BillingCity          = 'Anytown';
        accAux.AnnualRevenue        = 10000;
        accAux.ParentId             = null;
        accAux.Type = 'Customer';

        
        auxList.add( accAux );
       
    }
    
         try{
            insert auxList;
           
        }
        catch( Exception ex ){
            System.assert( false ,'Pre deploy test failed, This may be because of custom validation rules in your Org. You can check ignore apex errors or temporarily deactivate your validation rules for Accounts and try again.');
        }

         for(Account a: auxList){
             //system.debug('Account Name:'+ a.Name);
             if(!mapAccList.containsKey(a.Name)){
             //system.debug('Adding Account Name:'+ a.Name + ' Id:'+a.id);
             mapAccList.put(a.Name,a);
             }
             else{
                 throw new ATGException('Duplicate Accounts with Name:'+a.Name);
             }
             
             
         }
  
}


    /**
    * Set the necesary attributes used during test
    */
    public static void createTestHierarchy(){
        
        InlineAcountHerachy_TestUtilities testUtils = new InlineAcountHerachy_TestUtilities();
        //Set of Fields should be checked
        Set<String> fieldsToCheck = new Set<String>{'AnnualRevenue', 'BillingCity','BillingCountry','BillingPostalCode','BillingState', 'BillingStreet', 'Description', 'ShippingCity', 'ShippingStreet', 'Name', 'ShippingState', 'ShippingPostalCode', 'ShippingCountry' };
        
        //Create my Parent Account 
        testUtils.createAccounts( 1 , fieldsToCheck );
        testUtils.testAccList[0].Name = 'HierarchyTest0';
        testUtils.updateAccountList( fieldsToCheck );
        
        Account parentAccount = testUtils.testAccList[0];
        Id parentID = parentAccount.Id;
        System.Assert( parentID != null , 'Parent Id not found' );
        
        // Create 10 sub accounts
        testUtils.createAccounts( 10 , fieldsToCheck );
        Integer i = 0;
        for ( Account accAux : testUtils.testAccList ){ //Now i need change the names
            accAux.Name = 'HierarchyTest' + String.valueOf( i );
            i++;
        }
        testUtils.updateAccountList( fieldsToCheck );        
        
        List<Account> accountList = [ Select Id, parentID, name from account where name like 'HierarchyTest%' ORDER BY Name limit 10 ];
                
        for ( Integer x = 0; x < accountList.size(); x++ ){
            if ( accountList[x].name != 'HierarchyTest0' ){
                accountList[x].parentID = parentID;
                parentID = accountList[x].Id; 
            }
        }
        
        testUtils.testAccList.clear();
        testUtils.testAccList.addAll( accountList );
        testUtils.updateAccountList( fieldsToCheck );

        // Create 10 sub accounts
        Account subTreeParent = [ Select id, parentID, name from account where name = 'HierarchyTest4' limit 10 ];
        parentID = subTreeParent.Id;
        testUtils.createAccounts( 10, fieldsToCheck );
         
        i = 0;
        for ( Account accAux : testUtils.testAccList ){ //Now i need change the names
            accAux.Name = 'HierarchyTest' + '4.' + String.valueOf( i );
        }
        testUtils.updateAccountList( fieldsToCheck );

        List<Account> subAccountsList = [ Select Id, parentID, Name from Account where Name like 'HierarchyTest4%' limit 10  ];
        for ( Integer z = 1; z < subAccountsList.size(); z++ ){
            subAccountsList[z].parentID = parentID;
            parentID = accountList[z].Id; 
        }
        
        testUtils.testAccList.clear();
        testUtils.testAccList.addAll( subAccountsList );
    }


}