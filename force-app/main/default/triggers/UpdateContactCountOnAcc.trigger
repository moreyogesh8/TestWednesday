trigger UpdateContactCountOnAcc on Contact (after insert,
                                            after update) {
    Set<Id> accIdSet = new Set<Id> ();
    for (Contact aCon : Trigger.new) {
        if (aCon.AccountId != null) {
            accIdSet.add (aCon.AccountId);
        if (Trigger.isUpdate && aCon.AccountId != 
            Trigger.oldMap.get (aCon.Id).AccountId)
            accIdSet.add (Trigger.oldMap
                        .get (aCon.Id).AccountId);

        }
    } // End for
    
    List<Account> accListToUpdate = new List<Account> ();
    for (Account acc : [SELECT Id, (SELECT Id, Name
                                    FROM Contacts)
                        FROM Account
                        WHERE Id IN : accIdSet]) {
        acc.Contact_Count__c = acc.Contacts.size ();
        accListToUpdate.add (acc);
    }

    if (accListToUpdate.size () > 0)
        update accListToUpdate;
}