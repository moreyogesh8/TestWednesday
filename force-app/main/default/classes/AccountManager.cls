@RestResource(urlMapping='/Accounts/*/contacts')
global with sharing class AccountManager {
	@HttpGet
    global static Account getAccount(){
        System.debug('Inside getAccount Method');
        RestRequest request = RestContext.request;
        String result = request.requestURI.removeEnd('/contacts');
        Id accountId = result.substring(result.lastIndexOf('/')+1);
        System.debug('Account Id - '+accountId);
        Account acc = [SELECT Id,Name, (Select Id,Name From Contacts) FROM Account WHERE Id = :accountId ];
        return acc;
    }
}