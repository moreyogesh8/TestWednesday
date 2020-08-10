public class ContactAndLeadSearch {
    public static List<List<sObject>> searchContactsAndLeads(String value){
        System.debug(value);
        List<List<sObject>> searchList = [FIND :value IN ALL FIELDS
                                         RETURNING Contact(FirstName,LastName), Lead(FirstName,LastNAme)];
        Contact[] accList = (Contact[])searchList[0];
        Lead[] leadList = (Lead[])searchList[1];
        for(Contact a : accList){
            System.debug(a);
        }
        for(Lead l : leadList){
            System.debug(l);
        }
        return searchList;
    }
}