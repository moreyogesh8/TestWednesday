public class RandomContactFactory {
    public static List<Contact> generateRandomContacts(Integer noOfContacts, String LastName){
        List<Contact> conList = new List<Contact>();
        for(Integer i=0; i<noOfContacts; i++){
            conList.add(new Contact(
                FirstName = 'Test '+i
            	));
        }   
        return conList;
    }
}