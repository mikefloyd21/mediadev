public with sharing class GenerateOrderController {
    private Opportunity oppObj;
    
    public GenerateOrderController(ApexPages.StandardController controller) {
        oppObj = (Opportunity) controller.getRecord();
    }
    
    public PageReference getFlowFinishLocation(){
        invokeFlow();
        PageReference pgRef = new PageReference('/' + oppObj.Id);           ////returns page to the Opportunity record
        return pgRef;
    }
    
    /**
     * invokeFlow      
     * @description:            Method that calls a Flow to run
     */    
    public void invokeFlow(){
        Map<String, Object> params = new Map<String, Object>();
        params.put('OpptyID', oppObj.Id);               //insert a key, and Opportunity Id value to the map
        Flow.Interview.Opportunity_to_Order oppToOrderFlow = new Flow.Interview.Opportunity_to_Order(params);   //invoke the Flow having the Opportunity Id as the parameter
        try{
        	oppToOrderFlow.start();
        }
        catch(Exception e){
        	System.debug(LoggingLevel.ERROR, e.getMessage() + e.getStackTraceString());        //throws an exception if the Flow failed to run due to invalid parameter
        }        	
    }
}