//When new line item is added to an opportunity, this trigger copies the value of the associated
//product's color to the new record.
trigger oppLineTrigger on OpportunityLineItem (before insert) {
    //For every OpportunityLineItem record, add its associated pricebook entry 
    //to a Set so there are no duplicates.
    Set<Id> pbeIds = new Set<Id>();
    System.debug('pbeIds set is created');
    for(OpportunityLineItem oli : Trigger.new){
        //System.debug('Pricebookentryid from for loop - '+oli.pricebookentryid);
        pbeIds.add(oli.pricebookentryid);
    }
    //System.debug('pbeids set contain values - '+pbeIds);
    //Query the pricebookentries for their associated product color and place the resulte
    //in a map
    Map<Id,PricebookEntry> entries = new Map<Id,PricebookEntry>(
    [select product2.Color__c,product2.Description,product2.Name from pricebookentry 
    where id IN :pbeIds]);
    //System.debug('Map ofPricebookentries - '+entries);
    for(PricebookEntry pbe : entries.values()){
        System.debug(pbe.product2.Color__c+' '+pbe.product2.Description+' '+pbe.product2.Name);        
    }
    //Now use the map to set appropriate color on every OpportunityLineItem processed
    //by the trigger.
    For(OpportunityLineItem oli : Trigger.New){
        oli.Color__c = entries.get(oli.PricebookEntryId).product2.COlor__c;
    }
    
}