@isTest(SeeAllData=true)
public class TestCTIScreenPopPages 
{
   static testmethod void testNoMatch() 
   {             
        system.debug('TESTING CTI NO MATCH SCREEN');
        PageReference tpageRef = Page.CTIScreenPopService;
        Test.setCurrentPage(tpageRef);
        ApexPages.currentPage().getParameters().put('ANI', '8887450000');
        ApexPages.currentPage().getParameters().put('UUI','');
        System.assertEquals( '8887450000',ApexPages.currentPage().getParameters().get('ANI'));
        // create an instance of the controller
        CTIScreenPopServiceController myPageCon = new CTIScreenPopServiceController();
    }

    static testmethod void testMatch1() 
    { 
        //test match on phone number in UUI2    
        system.debug('TESTING CTI MATCH SCREEN2');

        //Test phone number in UUI2
        PageReference tpageRef4 = Page.CTIScreenPopService;
        Test.setCurrentPage(tpageRef4);   
        ApexPages.currentPage().getParameters().put('URL','/apex/CTIScreenPopService?ANI=8887450000&UUI2=8887456471');
        ApexPages.currentPage().getParameters().put('UUI','6788950999%2163349%216788950999%218887456471');
        ApexPages.currentPage().getParameters().put('ANI','8887450000');
        // create an instance of the controller
        // This has to be done to make the unit test work
        // https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_testing_SOSL.htm
        Id [] fixedSearchResults= new Id[2];
        fixedSearchResults[0] = '001c000000kC6vH';
        fixedSearchResults[1] = '003c000000azra1';
        
        Test.setFixedSearchResults(fixedSearchResults);        
        CTIScreenPopServiceController myPageCon4 = new CTIScreenPopServiceController();
        //test match on phone number in caller id    
        

    }
    static testmethod void testMatch2() 
    { 
        //test match on phone number in UUI2    
        system.debug('TESTING CTI MATCH SCREEN3');

        
        PageReference tpageRef2 = Page.CTIScreenPopService;
        Test.setCurrentPage(tpageRef2);
        ApexPages.currentPage().getParameters().put('ANI','6788950999');
        ApexPages.currentPage().getParameters().put('UUI','6788950999%2163349%216788950999%2154477311');
        ApexPages.currentPage().getParameters().put('URL','/apex/CTIScreenPopService?ANI=6788950999&DNIS=17446&isdtp=vw&isWsVw=true&nonce=cde733bef74d27956b0855a741852f186b26646aada46cb8d8c14a758cb150f0&Queue=16356&sfdcIFrameOrigin=https%3A%2F%2Fatgdealer--qa.cs7.my.salesforce.com&UCID=10000043531443011236&UUI=6788950999%2163349%216788950999%2154477311');

        system.debug('TESTING ACCOUNT MATCH');
                
        // create an instance of the controller
        CTIScreenPopServiceController myPageCon2 = new CTIScreenPopServiceController();      
    }        
}