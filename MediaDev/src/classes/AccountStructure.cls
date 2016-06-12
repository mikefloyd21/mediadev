/**  Copyright (c) 2008, Matthew Friend, Sales Engineering, Salesforce.com Inc.
*  All rights reserved.
*
*  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
*  Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer. 
*  Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
*  Neither the name of the salesforce.com nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission. 
*  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
*  INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
*  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, 
*  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; 
*  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
*  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, 
*  EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
**/

/**
* To adapt this to anouther Object simply search for "Change" to go to the places 
* where the sObject and query must be changed
*/
public with sharing class AccountStructure{

    //Declare variables
     /**
    * Allow page to set the current ID
    */
    public string currentId {get;set;}
            /**
    * Allow page to set the hierarchyType
    */
    //public string hierarchyType {get;set;}
    
     public string specifiedhierarchyType {get;set;}
     
    public List<SelectOption> gethierarchyTypeList() {
            List<SelectOption> options = new List<SelectOption>();      

    // Reading picklist values from custom hierarchy type
    Schema.DescribeFieldResult fieldResult = Customer_Hierarchy__c.Type__c.getDescribe();
    List<Schema.PicklistEntry> picklistEntries = fieldResult.getPicklistValues();

    // Adding apicklist values to the select list
    for(Schema.PicklistEntry entry : picklistEntries){
        options.add(new SelectOption(entry.getValue(), entry.getLabel())); 
    }
    
    //set the hierarchyType with the first choice if it is empty 
        if(specifiedhierarchyType == null || specifiedhierarchyType.trim().length() == 0)
        {
          
            specifiedhierarchyType = options[0].getValue();
             System.debug('$$$$$$$$$$$$$$$$$$$$ Setting hierarchyType = ' + specifiedhierarchyType );
        }
        return options;
    }


    public List<ObjectStructureMap> asm;
    public List<ObjectStructureMap> getFinalasm()
    {
        if (asm == null || asm.isEmpty())
        {
            loadHierarchy();
        }
        return asm;
    }
    public Map<String, ObjectStructureMap> masm;
    public List<Integer> maxLevel;
    
    /**
    * Contructor
    */
    public AccountStructure() {
        this.asm = new List<ObjectStructureMap>{};
        this.masm = new Map<String, ObjectStructureMap>{};
        this.maxLevel = new List<Integer>{};
    }

   public PageReference loadHierarchy() {
    

     //System.debug('$$$$$$$$$$$$$$$$$$$$ hierarchyType changed = ' + specifiedhierarchyType );

        getObjectStructure();

        return null;
    }
    /**
    * Allow page to set the current ID
    */
  
    public void setcurrentId( String cid ){
        currentId = cid;
    }

        /**
    * Allow page to set the hierarchyType
    */
  
    public void setspecifiedhierarchyTyp( String htype){
        specifiedhierarchyType= htype;
    }

    /**
    * Return ObjectStructureMap to page
    * @return asm
    */
    public List<ObjectStructureMap> getObjectStructure(){
    
    try{
    //System.debug('BEGIN getObjectStructure hierarchtType = ' + specifiedhierarchyType );
        asm.clear();
        if ( currentId == null ) {
            currentId = System.currentPageReference().getParameters().get( 'id' );
           
        }
        gethierarchyTypeList();
        System.assertNotEquals( currentId, null, 'sObject ID must be provided' );
        System.assertNotEquals( specifiedhierarchyType, null, 'hierarchyType must be provided' );
        asm = formatObjectStructure( currentId ,  specifiedhierarchyType );
          //System.debug('END getObjectStructure hierarchtType = ' + specifiedhierarchyType );
        return asm;
        }
        Catch(Exception ex)
        {
        try{
            Integer exceptioncount =0;
            while(ex != null){
            exceptioncount++;
            system.debug('Exception'+exceptioncount+' Type: '+ ex.getTypeName());
            system.debug('Exception'+exceptioncount+' Message: '+ ex.getMessage());
            system.debug('Exception'+exceptioncount+' LineNumber: '+ ex.getLineNumber());
            system.debug('Exception'+exceptioncount+' StackTraceString: '+ ex.getStackTraceString());
            ex= ex.getCause();
            }
            }
            Catch(Exception ignore)
            {
            }
            
            asm.clear();
            ObjectStructureMap error = new ObjectStructureMap('0', new Boolean[]{false}, new Boolean[]{true}, 'parent', true, false, new Account(Name='Error Processing Hierarchy', id=currentId) );   
            //String nodeId, Boolean[] levelFlag,Boolean[] closeFlag , String nodeType, Boolean lastNode, Boolean currentNode, Account a         
            asm.add(error);
             return asm;
        }
    }

    /**
    * Query Account from top down to build the ObjectStructureMap
    * @param currentId
    * @return asm
    */
    public ObjectStructureMap[] formatObjectStructure( String currentId , String hierarchyType){
    
      //System.debug('loading Hierarchy with hierarchtType= ' + hierarchyType);
      //System.debug('loading Hierarchy with currentId= ' + currentId );
        List<ObjectStructureMap> asm = new List<ObjectStructureMap>{};
        masm.clear();

        //Change below
        List<Account> al            = new List<Account>{};
        List<ID> currentParent      = new List<ID>{};
        Map<ID, String> nodeList    = new Map<ID, String>{};
        List<String> nodeSortList   = new List<String>{};
        List<Boolean> levelFlag     = new List<Boolean>{};
        List<Boolean> closeFlag     = new List<Boolean>{};
        String nodeId               = '0';
        String nodeType             = 'child';
        Integer count               = 0;
        Integer level               = 0;
        Boolean endOfStructure      = false;
        
        //Find highest level obejct in the structure
        currentParent.add( GetTopElement( currentId ) );

        //Loop though all children
        while ( !endOfStructure ){

            if( level == 0 ){
                //Change below     
                al = [ SELECT a.Type, a.ParentId, a.OwnerId, a.Name, a.Industry, a.Id      
                , (Select Name, Account__c, Related_Account__c From Customer_Hierarchy_Account__r     where Name= :hierarchyType)          
                 FROM Account a WHERE a.id IN : CurrentParent ORDER BY a.Name ];
                 
                  System.Debug('Top Parent Children Size: '+ al.size());
                /*List<ID> relationsParent   = new List<ID>{};
                relationsParent.add(currentId);
                for(Customer_Hierarchy__c ch : [Select c.Account__r.Id From Customer_Hierarchy__c c where c.Account__r.Id IN: CurrentParent AND c.Name = :hierarchyType]){
                            relationsParent.add(ch.Account__r.Id);
                }
               
                al = [ SELECT a.Type, a.Site, a.ParentId, a.OwnerId, a.Name, a.Industry, a.Id FROM Account a WHERE a.id IN : relationsParent   ORDER BY a.Name ];
                */
                
                
            } 
            else {
                system.debug('Level: '+ level);
                
                for(ID accountId : nodeList.keySet()){
                    system.debug('accountId :'+ accountId + ' nodeId: '+ nodeList.get(accountId));
                }
                //Change below      
                /*al = [ SELECT a.Type, a.Site, a.ParentId, a.OwnerId, a.Name, a.Industry, a.Id                 
                FROM Account a WHERE a.ParentID IN : CurrentParent ORDER BY a.Name ]*/
                
                System.Debug('Current Parent Size: '+String.valueOf(CurrentParent.size()));
                  for ( Integer i = 0 ; i < CurrentParent.size(); i++ ){
                   System.Debug('Current Parent at index: '+String.valueOf(i)+' :: '+ String.valueOf(CurrentParent[i]));
                  }
                System.Debug('HierarchyType: '+hierarchyType);
                List<ID> relationsChildren  = new List<ID>{};
                List<Customer_Hierarchy__c> heirarchyList =  [Select c.Related_Account__r.Id From Customer_Hierarchy__c c where c.Account__r.Id IN: CurrentParent AND c.Name = : hierarchyType];
                for ( Integer i = 0 ; i < heirarchyList.size(); i++ ){
                                                        //add only if the account already showed up before in the hierrachy as a parent
                              if(!nodeList.containsKey(heirarchyList[i].Related_Account__r.Id)){
                           relationsChildren.add(heirarchyList[i].Related_Account__r.Id);
                           }
                }               
                System.Debug('Children from Hierarchy');
                System.Debug('Size of Children: '+ String.valueOf(heirarchyList.size()));
                //and Account__c IN: nodeList.keySet()
                al = [ SELECT a.Type, a.ParentId, a.OwnerId, a.Name, a.Industry, a.Id 
                , (Select Name, Account__c, Related_Account__c From Customer_Hierarchy_Related_Account__r     where Name= : hierarchyType and Account__c IN: nodeList.keySet())    
                FROM Account a WHERE a.id IN : relationsChildren ORDER BY a.Name ];
                
                //al = [ SELECT a.Type, a.ParentId, a.OwnerId, a.Name, a.Industry, a.Id 
                //, (Select Name, Account__c, Related_Account__c From Customer_Hierarchy_Account__r    where Name= : hierarchyType)    
                //FROM Account a WHERE a.id IN : relationsChildren ORDER BY a.Name ];
                
                System.Debug('Children Accounts from Hierarchy');
                System.Debug('Size of Children Accounts: '+ String.valueOf(al.size()));
                
                for(Account a : al){
                System.Debug('Account: '+a.Name +'; Id: '+ a.id + ', Size of Relations: '+ String.valueOf(a.Customer_Hierarchy_Related_Account__r.size()));
                }
                
                /*al = [SELECT a.Type, a.Site, a.ParentId, a.OwnerId, a.Name, a.Industry, a.Id 
                , (Select Name, Account__c, Related_Account__c From Customer_Hierarchy_Account__r     where Name= :hierarchyType)    
                FROM Account a WHERE a.id IN : CurrentParent ORDER BY a.Name];*/                
            }

            if( al.size() == 0 ){
                endOfStructure = true;
            }
            else{
                currentParent.clear();
                for ( Integer i = 0 ; i < al.size(); i++ ){
                    //Change below
                    Account a = al[i];
                     nodeId = ( level > 0 ) ? NodeList.get( a.Customer_Hierarchy_Related_Account__r[0].Account__c )+'.'+String.valueOf( i ) : String.valueOf( i );
                    //nodeId = ( level > 0 ) ? NodeList.get( a.Customer_Hierarchy_Account__r[0].Related_Account__c )+'.'+String.valueOf( i ) : String.valueOf( i );
                    
                    system.debug('nodeId: '+nodeId );
                    

                    
                    masm.put( NodeID, new ObjectStructureMap( nodeID, levelFlag, closeFlag, nodeType, false, false, a ) );
                    currentParent.add( a.id );
                    nodeList.put( a.id,nodeId );
                    nodeSortList.add( nodeId );
                }
                
                maxLevel.add( level );                
                level++;
            }
        }
        
        //Account structure must now be formatted
        NodeSortList.sort();
        for( Integer i = 0; i < NodeSortList.size(); i++ ){
            List<String> pnl = new List<String> {};
            List<String> cnl = new List<String> {};
            List<String> nnl = new List<String> {};
            
            system.debug('NodeSortList['+i+']: '+NodeSortList[i]);
            
            if ( i > 0 ){
                String pn   = NodeSortList[i-1];
                pnl         = pn.split( '\\.', -1 );
            }

            String cn   = NodeSortList[i];
            cnl         = cn.split( '\\.', -1 );

            if( i < NodeSortList.size()-1 ){
                String nn = NodeSortList[i+1];
                nnl = nn.split( '\\.', -1 );
            }
            
            ObjectStructureMap tasm = masm.get( cn );
            if ( cnl.size() < nnl.size() ){
                //Parent
                tasm.nodeType = ( isLastNode( cnl ) ) ? 'parent_end' : 'parent';
            }
            else if( cnl.size() > nnl.size() ){
                tasm.nodeType   = 'child_end';
                tasm.closeFlag  = setcloseFlag( cnl, nnl, tasm.nodeType );
            }
            else{
                tasm.nodeType = 'child';
            }
            system.debug('cnl:'+cnl);
            tasm.levelFlag = setlevelFlag( cnl, tasm.nodeType ); 
            
            //Change below
            if ( tasm.account.id == currentId ) {
                tasm.currentNode = true;
            }
            asm.add( tasm );
        }
        
        if( asm.size() > 0 ){
        
        asm[0].nodeType             = 'start';
        asm[asm.size()-1].nodeType  = 'end';
        }
        
        return asm;
    }
    
    /**
    * Determin parent elements relationship to current element
    * @return flagList
    */
    public List<Boolean> setlevelFlag( List<String> nodeElements, String nodeType ){
            system.debug('setlevelFlag START' );
            

        List<Boolean> flagList = new List<Boolean>{};
        String searchNode   = '';
        String workNode     = '';
        Integer cn          = 0;
        
        for( Integer i = 0; i < nodeElements.size() - 1; i++ ){
         system.debug('nodeElements['+i+']: '+ nodeElements[i]);
            cn = Integer.valueOf( nodeElements[i] );
            cn++;
            searchNode  = workNode + String.valueOf( cn );
            workNode    = workNode + nodeElements[i] + '.';
            if ( masm.containsKey( searchNode ) ){
                flagList.add( true );
            }
            else {
                flagList.add( false );
            }
        }
                    system.debug('setlevelFlag END' );
        return flagList;
    }
    
    /**
    * Determin if the element is a closing element
    * @return flagList
    */
    public List<Boolean> setcloseFlag( List<String> cnl, List<String> nnl, String nodeType ){
        
        List<Boolean> flagList = new List<Boolean>{};
        String searchNode   = '';
        String workNode     = '';
        Integer cn          = 0;
        
        for( Integer i = nnl.size(); i < cnl.size(); i++ ){
            flagList.add( true );
        }
        
        return flagList;
    }
    
    /**
    * Determin if Element is the bottom node  
    * @return Boolean
    */
    public Boolean isLastNode( List<String> nodeElements ){
        
        String searchNode   = '';
        Integer cn          = 0;
        
        for( Integer i = 0; i < nodeElements.size(); i++ ){
            if ( i == nodeElements.size()-1 ){
                cn = Integer.valueOf( nodeElements[i] );
                cn++;
                searchNode = searchNode + String.valueOf( cn );
            }
            else {
                searchNode = searchNode + nodeElements[i] + '.';
            }
        }
        if ( masm.containsKey( searchNode ) ){
            return false;
        }
        else{
            return true;
        }
    }
    
    /**
    * Find the tom most element in Heirarchy  
    * @return objId
    */
    public String GetTopElement( String objId ){
        Set<String> parsedElements = new Set<String>();
        parsedElements.add(objId);
        Boolean top = false;
        while ( !top ) {
            //Change below
            //Account a = [ Select a.Id, a.ParentId From Account a where a.Id =: objId limit 1 ];
            List<Customer_Hierarchy__c> chList = [ SELECT c.Account__r.Id  FROM Customer_Hierarchy__c c  WHERE c.Name  =:specifiedhierarchyType AND  c.Related_Account__r.id =: objId limit 1 ];
            
            //if ( a.ParentID != null ) {
            if (!chList.isEmpty())
            {
                Customer_Hierarchy__c ch = chList[0];
                if (ch.Account__r.Id != null ) {
                     //objId = a.ParentID;
                     //check if the element has already been parsed if so;
                     //return the current element as top;
                                if(!parsedElements.contains(ch.Account__r.Id)){
                                objId = ch.Account__r.Id;
                                 parsedElements.add(objId);
                                }
                                else{
                                top = true;
                                }
                            }
                            else {
                                top = true;
                            }
            }
              else {
                                top = true;
                            }
            
        }
        return objId ;
    }
    
    /**
    * Wrapper class
    */
    public with sharing class ObjectStructureMap{

        public String nodeId;
        public Boolean[] levelFlag = new Boolean[]{};
        public Boolean[] closeFlag = new Boolean[]{};
        public String nodeType;
        public Boolean currentNode;
        
        /**
        * @Change this to your sObject
        */
        public Account account;
        
        public String getnodeId() { return nodeId; }
        public Boolean[] getlevelFlag() { return levelFlag; }
        public Boolean[] getcloseFlag() { return closeFlag; }
        public String getnodeType() { return nodeType; }
        public Boolean getcurrentNode() { return currentNode; }


        /**
        * @Change this to your sObject
        */
        public Account getaccount() { return account; }
        
        public void setnodeId( String n ) { this.nodeId = n; }
        public void setlevelFlag( Boolean l ) { this.levelFlag.add(l); }
        public void setlcloseFlag( Boolean l ) { this.closeFlag.add(l); }
        public void setnodeType( String nt ) { this.nodeType = nt; }
        public void setcurrentNode( Boolean cn ) { this.currentNode = cn; }

        /**
        * @Change this to your sObject
        */
        public void setaccount( Account a ) { this.account = a; }

        /**
        * @Change the parameters to your sObject
        */
        public ObjectStructureMap( String nodeId, Boolean[] levelFlag,Boolean[] closeFlag , String nodeType, Boolean lastNode, Boolean currentNode, Account a ){
            
            this.nodeId         = nodeId;
            this.levelFlag      = levelFlag; 
            this.closeFlag      = closeFlag;
            this.nodeType       = nodeType;
            this.currentNode    = currentNode;

            //Change this to your sObject  
            this.account = a;
        }
    }
}