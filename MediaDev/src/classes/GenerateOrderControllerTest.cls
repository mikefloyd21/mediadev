@isTest
public class GenerateOrderControllerTest {
    
    static Account acctObj {get; set;}
    static Opportunity oppObj {get; set;}   

    public static testMethod void testOppToOrderFlow() {
        acctObj = GenerateTestData.createAccount();
        insert acctObj;

        oppObj = GenerateTestData.createOpp(acctObj.Id);
        insert oppObj;
        
        PageReference pageRef = page.GenerateOrder;
        Test.setCurrentPage(pageRef);
        
        Test.startTest();
        
        ApexPages.StandardController stdCtrlr = new ApexPages.StandardController(oppObj);
        GenerateOrderController generateOrderCtrlr = new GenerateOrderController(stdCtrlr);
        
        generateOrderCtrlr.getFlowFinishLocation();
        Test.stopTest();

        Set<Id> ordOppIds = new Set<Id>();
        List<Order> orLst = [SELECT Id, OpportunityId FROM Order WHERE OpportunityId =: oppObj.Id];
        for(Order o : orLst){
            ordOppIds.add(o.OpportunityId);
        }
        System.debug('//test ordOppIds: ' + ordOppIds.size());
        System.assert(ordOppIds.size() != 0);            
    }

    public static testMethod void testOppToOrderFlowFailed() {
        acctObj = GenerateTestData.createAccount();
        insert acctObj;

        Opportunity opptyObj = new Opportunity();
        
        PageReference pageRef = page.GenerateOrder;
        Test.setCurrentPage(pageRef);
        
        Test.startTest();
        
        ApexPages.StandardController stdCtrlr = new ApexPages.StandardController(opptyObj);
        GenerateOrderController generateOrderCtrlr = new GenerateOrderController(stdCtrlr);
        
        generateOrderCtrlr.getFlowFinishLocation();
        Test.stopTest();

        List<Apexpages.Message> msgs = ApexPages.getMessages();
        Boolean error = false;
        System.debug('//test opp: ' + ApexPages.getMessages().size());
        if (ApexPages.getMessages().size() == 0) {                    
            error = true;                
        }    
        System.assert(error);            
    }    
}