public with sharing class QueryBuilderSetupPageContrlr {
    public String objName {get; set;}
    public String fields  {get; set;}

    //To get all object
    public List<SelectOption> getAllObjects () {
        List<SelectOption> objList = new List<SelectOption> ();
        objList.add(new SelectOption('' ,'-- None --'));
        Map<String, Schema.SObjectType> globDescribeMap = Schema.getGlobalDescribe();
        for (String sObj : globDescribeMap.keySet()) {
            if (globDescribeMap.get(sObj).getDescribe().isSearchable() 
                && globDescribeMap.get(sObj ).getDescribe().isDeletable()) {
                objList.add(new SelectOption(globDescribeMap.get(sObj).getDescribe ().getName (), 
							globDescribeMap.get(sObj).getDescribe().label));
            } // End if
        } // End for
        return objList;
    }

    // To the fields of selected object
    public List<SelectOption> getObjFields () {
        List<SelectOption> fieldList = new List<SelectOption> ();
            fieldList.add(new SelectOption('' ,'-- None --'));
        if (String.isNotBlank (objName)) {
            Map<String, Schema.SObjectType> globDescribeMap = Schema.getGlobalDescribe();
            Map<String, Schema.SobjectField> objFields = 
                                globDescribeMap.get(objName).getDescribe().fields.getMap();
            for (String sObField : objFields.keySet()) {
                if (objFields.get(sObField) != null 
                    && objFields.get(sObField).getDescribe().isAccessible()) {
                    fieldList.add (new SelectOption (objFields.get(sObField).getDescribe().getName (),
                                objFields.get(sObField).getDescribe().label));
                } // End if
            } // End for
        } // End if
        return fieldList;
    }
	
    private String formatFieldNames(String pFIelds){
        if(pFIelds.contains('[')){
         	pFIelds = pFIelds.removeStart('[');   
        }    
        if(pFIelds.contains(']')){
            pFIelds = pFIelds.removeEnd(']');
        }
        return pFIelds;
    }
    
    public PageReference saveObj () {
        Query_Builder__c queryBuilder = new Query_Builder__c ();
        queryBuilder.Active__c = true;
        queryBuilder.Object_Name__c = objName;
        queryBuilder.Fields__c = formatFieldNames(fields);    
        insert queryBuilder;
        return new PageReference ('/'+queryBuilder.Id);
    }
}