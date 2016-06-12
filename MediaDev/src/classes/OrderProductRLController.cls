/**
 *@author Original: Aakash Wankhede - Cloud Sherpas/Auto Trader, Last Modified: Aakash Wankhede - Cloud Sherpas/Auto Trader
 *@description:This  is a controller of OrderProductRL page used to display 
    the order products realted to order.
 */
public with sharing class OrderProductRLController {
    public Order orderObj {get; set;}
    public List<OrderItem> odrItmLst {get; set;}
     public Boolean isInternalError {get; set;}
    
    public OrderProductRLController(ApexPages.StandardController controller) {
        orderObj = (Order) controller.getRecord();
        isInternalError = false;
        this.init();                        //Initialize method to do initial setup and fetch data from database
    }
    
    // initialize method for page setup
    private void init(){
        try{
                if(orderObj.Id != null){
                //checks whether order is present otherwise throws error
                    odrItmLst = [SELECT Id, PricebookEntry.Product2.Name FROM OrderItem WHERE OrderId = :orderObj.Id];
                 }   
                else{
                        isInternalError = true;
                }
       }
        catch(Exception e){
            System.debug(LoggingLevel.ERROR, e.getMessage() + e.getStackTraceString());
        }
        if(odrItmLst == null){
            odrItmLst = new List<OrderItem>();       //create new order item list
        }
    }
    
    //Redirecting to OrderProduct page
    public PageReference redirectToOrderProduct(){
        //Gets the product id from Url
        String odrProdId = (String) ApexPages.currentPage().getParameters().get('OdrProdId');
        PageReference pgRef = new PageReference('/apex/OrderConfigurationVF?id=' + odrProdId);
        return pgRef;
    }
}