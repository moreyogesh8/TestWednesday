public class MyContactListController {
	@AuraEnabled
    public static List<Contact> getContacts(Id recordId){
        System.debug('Inside MyContactListController recordId value ->'+recordId);
    	return [SELECT Id, FirstName, LastName, Email, Phone FROM Contact WHERE AccountId= :recordId];    
    }
    
    @AuraEnabled
    public static List<Contact> getContactList(List<Id> accountIds){
        //Getting List of Contact based on the Account Id
        System.debug('Inside getContactlist method');
        List<Contact> contactList = [SELECT Id, FirstName, LastName, Email, Phone, AccountId FROM Contact WHERE AccountId IN :accountIds ];
		System.debug('Contact List - '+contactList); 
        //Returning ContactList
        return contactList;
    }
    
    @AuraEnabled
    public static Map<String,String> saveContactList(List<Contact> contactList){
        //A Map is a collection of key value pairs where each unique key maps to a single value
        //Keys and Values can be of any data-type primitive types, collections, sObjects, user-defined types and built in apex-types
        //Forming String map to return response
        Map<String,String> resultMap = new Map<String,String>();
        //Adding try-catch for exception handeling
        try{
            //Update the Contact
            update contactList;
            //In case of success, update the resultMap
            resultMap.put('status','success');
            resultMap.put('message','contact updated successfully');
        }catch(Exception e){
            //There is an error, update the error message in resultMap
            resultMap.put('status','error');
            resultMap.put('message',e.getMessage());
        }
        return resultMap;
    }
}