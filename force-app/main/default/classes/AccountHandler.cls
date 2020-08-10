public class AccountHandler {
    public static Account insertNewAccount(String accountNm){
        try{
        	Account acc = new Account(Name = accountNm);
            insert acc;
        	Id id = acc.Id;
        	return acc;
        }catch(DmlException de){
            return null;
        }
       
    }
}