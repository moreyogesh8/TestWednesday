public class ContactListController {
	@AuraEnabled
    public static List<Contact> getContactList(String accountId){
        System.debug('Trace received');
        return [Select Id,Name,FirstName,LastName,Email,Phone From Contact Where Email != null
               AND AccountId=:accountId];
    }
    
    @AuraEnabled
    public static Contact createContact(Contact con, Id AccountId){
        System.debug('Inside createContact Method');
        con.AccountId = AccountId;
        insert con;
        System.debug('Contact Id:: '+con.Id);
        return con;
    }
    
}