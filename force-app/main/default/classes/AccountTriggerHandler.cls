public class AccountTriggerHandler {
    
    // A method to update Fax on related contact
    public static void updateFaxonContact (Map<Id, Account> accNewMap) {
        
        List<Contact> conListToUpdate = new List<Contact> ();
        for (Contact aCon : [SELECT Id, Fax, AccountId
                                FROM Contact
                                WHERE AccountId IN :accNewMap.keySet ()]) {
            aCon.Fax = accNewMap.get (aCon.AccountId).Fax;
            conListToUpdate.add (aCon);
        } // End for 
        
        if (conListToUpdate.size () > 0)
            update conListToUpdate;
    }
    
    public static void updateChildAccount (List<Account> accountList){
    	System.debug('Inside updateChildAccount method'); 
        List<Account> accountList1 = new List<Account>();
        for(Account acc : [SELECT id,Active__c,Parent.Active__c  
                           FROM Account
                           WHERE Parentid IN: accountList ]){
        	acc.Active__c = acc.Parent.Active__c;
            System.debug('Parent Id - '+acc.Parent.Active__c);                   
            accountList1.add(acc);                   
    	}
        System.debug('Parent Account'+accountList1);
        if(accountList1.size()>0){
            update accountList1; 
        }
    }
}