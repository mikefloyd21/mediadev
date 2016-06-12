/**********************************************************************************************
@author     : Rahul Khilwani
@date       : 10/23/2015
@description: Batch to remove MA/DSC/Dealer Group accounts from SalesIQ.
Revison(s)  : 1
**********************************************************************************************/
global class BatchToProcessMARecords implements Database.Batchable<sObject> {
    public String query;
    global Database.QueryLocator  start(Database.BatchableContext bc){
        query = 'SELECT Id, Name, SalesIQ__Account__r.Name from SalesIQ__Position_Account__c WHERE SalesIQ__Account__r.SVOC_Region__c = \'35\' OR SalesIQ__Account__r.SVOC_Region__c = \'39\' OR SalesIQ__Account__r.SVOC_Region__c = \'43\'';
        return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext info, List<sObject> scope){
        delete scope;
    }
    global void finish(Database.BatchableContext info){}
}