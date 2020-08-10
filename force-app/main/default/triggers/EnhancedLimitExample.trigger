trigger EnhancedLimitExample on Invoice_Statement__c (before update) {
    //Perform SOQL query outside the for loop
    //This SOQL query run once for all items in Trigger.new
    List<Line_Item__c> li1 = new List<Line_Item__c>();
    List<Invoice_Statement__c> invoicesWithLineItems = 
    [SELECT Id,Description__c,(SELECT Id,Units_Sold__c,Merchandise__c FROM Line_Items__r)
    FROM Invoice_Statement__c WHERE Id IN : Trigger.newMap.KeySet()];
    for(Invoice_Statement__c inv : invoicesWithLineItems){
        Integer i=1;
        for(Line_Item__c li : inv.Line_Items__r){
            li.Name='Test'+i;
            i++;
            li1.add(li);
        }       
    }
    update li1;
 }