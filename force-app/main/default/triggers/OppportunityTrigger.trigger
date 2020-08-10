trigger OppportunityTrigger on Opportunity (before delete) {
    Set<Id> accIdSet = new Set<Id> ();
    for (Opportunity oppty : Trigger.old) {
        if (oppty.AccountId != null)
            accIdSet.add (oppty.AccountId);
    } // End for
    
    Set<Id> activeAccIdSet = new Set<Id> ();
    for (Account acc : [SELECT Id
                        FROM Account
                        WHERE Id IN : accIdSet
                        AND Active__c = 'Yes']) {
        activeAccIdSet.add (acc.Id);
    } // End for 
    
    for (Opportunity anOppty : Trigger.old) {
        if (activeAccIdSet.contains (anOppty.AccountId))
            anOppty.addError ('You can\'t delete this opportunity!');
    } // End for 
} // End trigger