public class contactSearchController {
	@AuraEnabled
    public static List<Contact> getContactList(String searchTerm){
        System.debug('Search Term: '+searchTerm);
        String modifiedSearchTerm = '%'+searchTerm+'%';
        List<Contact> matchedContactList = [SELECT name,email FROM Contact WHERE name like :modifiedSearchTerm ];
        System.debug('Retuened List: '+matchedContactList);
        return matchedContactList;
    }
}