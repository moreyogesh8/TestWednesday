public class ContactTriggerHandler {
	// A method to update contact count on parent account
	public static void updateContactCount (Map<Id, Contact> conNewMap,
											Map<Id, Contact> conOldMap) {
		Set<Id> accountIdSet = new Set<Id> ();
		for (Contact con : conNewMap.values()) {
			if (String.isNotBlank (con.AccountId)) {
				accountIdSet.add (con.AccountId);
				if (conOldMap != null){
					Contact oldCon = conOldMap.get (con.Id);
					if (con.AccountId != oldCon.AccountId)
						accountIdSet.add (oldCon.AccountId);
				}
			}
		} // End for 
		
		List<Account> accListToUpdate = new List<Account> ();
		for (Account acc : [SELECT Id, Contact_Count__c,
								(SELECT Id FROM Contacts)
							FROM Account
							WHERE Id IN: accountIdSet]) {
            if(acc.Contact_Count__c != acc.Contacts.size ()){
            	acc.Contact_Count__c = acc.Contacts.size ();
            	System.debug (acc);
				accListToUpdate.add (acc);		                    	    
            }                    
			
		} // End for
		
		if (accListToUpdate.size () > 0)
			update accListToUpdate;
	}
}