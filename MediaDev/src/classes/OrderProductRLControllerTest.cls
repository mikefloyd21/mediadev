/**
 * This class contains unit tests for validating the behavior of 
 * VisualForce Extensions.
 * The @isTest class annotation indicates this class only contains testmethods.
 */   
@isTest
public class OrderProductRLControllerTest {

    public static Account accountObj {get; set;}
    public static OrderItem orderItemObj{get; set;}
    public static Order orderObj{get; set;}
    public static Order orderObj2{get; set;}
    public static Product2 productobj {get; set;}
    public static Pricebook2 pricebookObj {get; set;}
    public static PricebookEntry pricebookEntryObj {get; set;}
   
    //This testmethod test the OrderProductVF controller verfying
    //order products are realted to order that are currently in context.
    public static testmethod void testOrderProductRL(){
        Test.startTest();
            
            accountObj=GenerateTestData.createAccount();
            insert accountObj;
            
            productobj = GenerateTestData.createProduct();
            insert productobj;
           
            pricebookObj = GenerateTestData.createPricebook();
            insert pricebookObj;
            
            pricebookEntryObj = GenerateTestData.createPricebookentry(productobj.Id,pricebookObj.Id);
            insert pricebookEntryObj;
        
            orderObj = GenerateTestData.createOrders(accountObj.id , pricebookObj.id );
            insert orderObj;
        
            orderItemObj = GenerateTestData.orderStatAct(orderObj.Id, Null , pricebookEntryObj.id, Null, pricebookObj.Id);
            insert orderItemObj;
            //sets current page reference
            PageReference pRef= Page.OrderProductRLVF;
            Test.setCurrentPageReference(pRef); 
  
            ApexPages.StandardController stdControllerObj = new ApexPages.StandardController(orderObj);
            OrderProductRLController controllerObj = new OrderProductRLController(stdControllerObj);    
            controllerObj.redirectToOrderProduct();
            
            List<OrderItem> orderItemTestList = [Select OrderId from OrderItem where OrderId =: orderObj.id];
            system.assertEquals(1, orderItemTestList.size());
    
        Test.stopTest();
    } 
    //test method for testing controller without order
    public static testmethod void testWithoutOrder(){
        Test.startTest();
            
            accountObj=GenerateTestData.createAccount();
            insert accountObj;
        
            productobj = GenerateTestData.createProduct();
            insert productobj;
           
            pricebookObj = GenerateTestData.createPricebook();
            insert pricebookObj;
            
            pricebookEntryObj = GenerateTestData.createPricebookentry(productobj.Id,pricebookObj.Id);
            insert pricebookEntryObj;
        
            orderObj = GenerateTestData.createOrders(accountObj.id , pricebookObj.id );
           
            PageReference pRef= Page.OrderProductRLVF;
            Test.setCurrentPageReference(pRef);
            
            ApexPages.StandardController stdControllerObj = new ApexPages.StandardController(orderObj);
            OrderProductRLController controllerObj = new OrderProductRLController(stdControllerObj);
            
             
        Test.stopTest(); 
    }
    
}