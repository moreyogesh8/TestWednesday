trigger Opportunity_Account_Case_Trigger on Opportunity (before delete) {
	Set<id> accountId = new Set<id>();
    for(Opportunity oppty : Trigger.old){
        if(oppty.AccountId != null){
        	accountId.add(oppty.AccountId);
        	System.debug('Success1 '+accountId);    
        }
    }
    
    Set<id> accountRelatedcase = new Set<id>();
    for(Case accRelcas : [SELECT id,Account.id
                          FROM Case
                          WHERE Case.Accountid In : accountId]){
    	accountRelatedcase.add(accRelcas.Accountid);
        System.debug('Success1 '+accountRelatedcase);
    }
    
    for(Opportunity anoppty : Trigger.old){
        if(accountRelatedcase.contains(anoppty.AccountId)){
            anOppty.addError('Opportunity can not be deleted with account having open cases');
        }
    }
}