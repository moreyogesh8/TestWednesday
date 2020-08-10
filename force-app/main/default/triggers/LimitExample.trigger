trigger LimitExample on Invoice_Statement__c (before insert, before update) {
    for(Invoice_Statement__c inv:Trigger.new){
        //This SOQL query executes once for each item in Trigger.new
        //It gets the line item for each invoice statement
        List<Line_Item__c> liList = [SELECT Id,Units_Sold__c,Merchandise__C
                                    FROM Line_Item__c 
                                    WHERE Invoice_Statement__c = :inv.Id];
        for(Line_Item__c li:liList){
            li.Name='Test007';
            //System.debug(li.Id+','+li.Units_Sold__c+','+li.Merchandise__c);
            update li;
        }   
                                
    }    
}