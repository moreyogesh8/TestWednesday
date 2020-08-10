@IsTest
public class AccountManagerTest {
    @isTest static void testGetAccount(){
    	Id accountId = CreateAccountRecord();    
        RestRequest request = new RestRequest();
        request.requesturi = 'https://yogank-dev-ed.my.salesforce.com/apexrest/Accounts/'+accountId+'/contacts';
        request.httpMethod='GET';
        RestContext.request = request;
        Account testAcc = AccountManager.getAccount();
        System.assert(testAcc.Id != null);
        System.assertEquals('Ankita Test',testAcc.Name);
    }
    
    private static Id CreateAccountRecord(){
        Account account = new Account();
        account.Name = 'Ankita Test';
        insert account;
        return account.Id;
    }
}