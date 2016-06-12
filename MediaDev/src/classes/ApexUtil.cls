global without sharing class ApexUtil{

/**
     * getActiveSObjectRecordTypes
     * @param  sObjectName    sObject API name
     * @param  setIDAsMapKey  flag to indicate Id need to set as Map key
     * @return                Active RecordType Map with Name, ID pair 
     */
    public static Map<String, String> getActiveSObjectRecordTypes(String sObjectName, Boolean setIDAsMapKey){
        List<RecordType> recordTypes = [SELECT ID, Name, DeveloperName from RecordType where sObjectType = :sObjectName and isActive=true];
        
        Map<String, String> sobjRecordTypes = new Map<String, String>{};
        for(RecordType rt: recordTypes){
            if(setIDAsMapKey)
                sobjRecordTypes.put(rt.ID, rt.DeveloperName);
            else
                sobjRecordTypes.put(rt.DeveloperName, rt.ID);
        }
        return sobjRecordTypes;
    }
    
}