public class TestUtility {
    private static map<String,Schema.SObjectType> globalDescribe;
    public static void createTestAccounts(){
        list<sObject> accounts = new list<sObject>();
        list<string> lotSize = new list<string>{'750+', '101-125', '0-15', '251-350', '46-55',
                               '36-45', '66-80', '126-150', '201-205', '36-45'};
        list<string> district = new list<string>{'4', '7', '8', '9', '1',
                               '5', '6', '3', '8', '1'};
        list<string> region = new list<string>{'35', '34', '32', '27', '25',
                               '21', '47', '32', '42', '13'};
        globalDescribe = Schema.getGlobalDescribe();
        Schema.Sobjecttype accType = globalDescribe.get('Account');
        for(Integer i=0; i<10; i++){
            sObject acct = accType.newSObject();
            acct.put('Name', 'Test-Account' + i);
            acct.put('SalesIQ__Account_Status__c', 'Active');
            acct.put('Sales_View_Flag__c', 'Yes');
            acct.put('Sales_Segmentation__c', 'Yes');
            acct.put('SVOC_District__c', district.get(i));
            acct.put('SVOC_Region__c', '35');
            acct.put('ATC_Dealer_Id__c', '6780428' + i);
            acct.put('Lot_Size_New__c', lotSize.get(i));
            //acct.put('RecordTypeId',rt.Id);
            acct.put('Type','Dealer Group');
            accounts.add(acct);
        }
        insert accounts;
    }
    
    public static void createTestTerritories(){
        list<sObject> territories = new list<sObject>();
        Schema.sObjectType territoryType = globalDescribe.get('SalesIQ__Territory__c');
        for(Integer i = 1;i<11;i++){
            sObject territory = territoryType.newSObject();
            territory.put('Name', 'ATC Territory 22-4-' +String.valueOf(i));
            territory.put('SalesiQ__District__c', 'ATC District 22-4');
            territory.put('SalesiQ__Region__c', 'ATC Region 22');
            territory.put('SalesiQ__Territory_Status__c','Active');
            territory.put('SalesiQ__Territory_Id__c','TestTerritory-'+String.valueOf(i));
            territories.add(territory);
        }
        sObject territory1 = territoryType.newSObject();
        territory1.put('Name', 'ATC Territory 22-4-' +15);
        territory1.put('SalesiQ__District__c', 'ATC District 22-4');
        territory1.put('SalesiQ__Region__c', 'ATC Region 22');
        territory1.put('SalesiQ__Territory_Status__c','Pending');
        territory1.put('SalesiQ__Territory_Id__c','TestTerritory-15');
        territories.add(territory1);
        
        sObject territory2 = territoryType.newSObject();
        territory2.put('Name', 'ATC Territory 22-4-' +18);
        territory2.put('SalesiQ__District__c', 'ATC District 22-4');
        territory2.put('SalesiQ__Region__c', 'ATC Region 22');
        territory2.put('SalesiQ__Territory_Status__c','Cancelled');
        territory2.put('SalesiQ__Territory_Id__c','TestTerritory-18');
        territories.add(territory2);
        
        sObject territory3 = territoryType.newSObject();
        territory3.put('Name', 'ATC Territory 22-4-' +16);
        territory3.put('SalesiQ__District__c', 'ATC District 22-4');
        territory3.put('SalesiQ__Region__c', 'ATC Region 22');
        territory3.put('SalesiQ__Territory_Status__c','Rejected');
        territory3.put('SalesiQ__Territory_Id__c','TestTerritory-16');
        territories.add(territory3);
        
        sObject territory4 = territoryType.newSObject();
        territory4.put('Name', 'ATC Territory 22-4-' +17);
        territory4.put('SalesiQ__District__c', 'ATC District 22-4');
        territory4.put('SalesiQ__Region__c', 'ATC Region 22');
        territory4.put('SalesiQ__Territory_Status__c','Deleted');
        territory4.put('SalesiQ__Territory_Id__c','TestTerritory-17');
        territories.add(territory4);
        insert territories; 
    }

    public static void createTestPositions(){
        list<sObject> territories = new list<sObject>(); 
        territories = Database.query('SELECT Id from SalesIQ__territory__c WHERE SalesiQ__District__c = \'ATC District 22-4\'');
        Schema.sObjectType positionType = globalDescribe.get('SalesIQ__Position__c');
        list<sObject> positions = new list<sObject>();
        for(sObject territory : territories){
            sObject position = positionType.newSObject();
            position.put('SalesiQ__Territory__c', territory.get('Id'));
            position.put('SalesiQ__RoleId__c',UserInfo.getUserRoleId());
            position.put('SalesiQ__User__c',UserInfo.getUserId());
            positions.add(position);
        }

        insert positions;
    }
    
    public static void createTestPositionAccounts(){
        list<sObject> accounts = new list<sObject>();
        accounts = Database.query('SELECT Id From Account');
        list<sObject> userRole = new list<sObject>();
        userRole = Database.query('SELECT Id from UserRole WHERE Name = \'ATC District 22-4\'');
        list<sObject> position = new list<sObject>();
        list<sObject> position1 = new list<sObject>();
        position = Database.query('SELECT Id ,SalesiQ__Effective_End_Date__c From SalesiQ__Position__c WHERE SalesiQ__RoleId__c = \'' + userRole[0].get('Id') + '\'');
        list<sObject> positionAccounts = new list<sObject>();
        Schema.sObjectType positionAccountType = globalDescribe.get('SalesiQ__Position_Account__c');
        Integer count = 0;
        for(sObject acct: accounts){
            sObject pa = positionAccountType.newSObject();
            pa.put('SalesiQ__Account__c', acct.get('Id'));
            pa.put('SalesiQ__Position__c', position[count].get('Id'));
            positionAccounts.add(pa);
            count++;
        }
        system.debug('--: positionAccounts :-- ' + positionAccounts);
        insert positionAccounts; 
    }
}