public class ContactSearch {
    public static List<Contact> searchForContacts(String value1, String value2){
        List<Contact> demo = new List<Contact>();
        for(Contact con : [SELECT Id,Name FROM Contact WHERE LastName= :value1 and MailingPostalCode= :value2]){
            demo.add(con);
        }
        return demo;
    }
}