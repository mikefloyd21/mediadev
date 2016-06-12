/**
 *@author Original: Aakash Wankhede - Cloud Sherpas/Auto Trader, Last Modified: Aakash Wankhede - Cloud Sherpas/Auto Trader
 *@description: Trigger class used to restrict the user from adding more than one product configuration per Product.
 */
public with sharing class ProductConfigurationTriggerClass {
    /**
     * beforeInsert
     * @param  productConfigList: List of Product Configuration records from trigger.new
     * @description: Method called before inserting Product_Configuration records
     */
    public static void beforeInsert(List <Product_Configuration__c> productConfigList) {
        Set <ID> setOfProductId = new Set < ID > ();                    //set of product2 Ids realted with product configuration
        
        //map of product id and product configuration
        Map < id, list < Product_Configuration__c >> product2ToProductConfigMap = new Map < id, list < Product_Configuration__c >> ();
        
        for (Product_Configuration__c productConfigObj: productConfigList) {            //iterate all the Product_Configuration records that was inserting
            setOfProductId.add(productConfigObj.Product2__c);
        }
        
        //capture the list of Product_Configuration records
        list <Product_Configuration__c> configList = [SELECT Product2__c
                                                        FROM Product_Configuration__c
                                                        WHERE Product2__c in : setOfProductId];

        for (Product_Configuration__c config: configList) {
            if (!product2ToProductConfigMap.containsKey(config.Product2__c)) {
                //create new product configuration record with new product
                product2ToProductConfigMap.put(config.Product2__c, new List < Product_Configuration__c > {
                    config
                });
            } else {
                product2ToProductConfigMap.get(config.Product2__c).add(config);        //add the product configuration to existing product
            } 
        }
        
        //Iterate all the Product_Configuration records that was inserting to check size 
        for(Product_Configuration__c productConfigObj: productConfigList) {
            if(productConfigObj.Product2__c != null ){
                if (product2ToProductConfigMap.get(productConfigObj.Product2__c) != null) {
                
                //Check the size of production configuration record, display error message when product configuration record is greater than 1 per product
                if (product2ToProductConfigMap.get(productConfigObj.Product2__c).Size() >=  1) {
                    productConfigObj.adderror(Label.RestrictProductConfig);
                }
              }
            }
        }
    }
}