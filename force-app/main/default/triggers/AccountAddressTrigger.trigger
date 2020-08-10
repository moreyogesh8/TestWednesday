trigger AccountAddressTrigger on Account (before insert, before update) {
	System.debug('Inside AccountAddressTrigger');
    List<Account> accList = new List<Account>();
    for(Account acc : Trigger.new){
        System.debug('acc - '+acc);                   
    	if(acc.udemyYogAnk__Match_Billing_Address__c == true && !String.isBlank(acc.BillingPostalCode)){
            acc.ShippingPostalCode = acc.BillingPostalCode;
            System.debug('Both conditions are true'+acc.udemyYogAnk__Match_Billing_Address__c+':'+acc.BillingPostalCode);
			accList.add(acc);    
        }                   
	}
    
}