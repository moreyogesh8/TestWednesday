/**
 * Description: This is a trigger handler for opportunity
 **/
public with sharing class OpportunityTriggerHandler {
    private static boolean isFirstRun = True;
	// A method that prevents deletion of closed won opportunity 
	public static void stopOpptyDelete (List<Opportunity> opptyList) {
		if (retrieveCustSetting ()) {
			for(Opportunity oppty: opptyList){
				if(oppty.StageName == 'Closed Won'){
					oppty.addError(Label.ClosedWonOptyDelMsg);
				}    
			} // End for
		} // End if 
	} // End method 
	
	// Fetching custom setting (trigger switch) data
	private static Boolean retrieveCustSetting () {
		OpportunityTriggerSwitch__c opCs = 
			OpportunityTriggerSwitch__c.getInstance();
		return opCs.PreventOptyDeletion__c;
	}
    
   public static void checkLostOpportunityAmount (Map<Id, Opportunity> opportunityMap,
                                                  Map<Id, Opportunity> opportunityOldMap){
        Set<Id> accIdSet = new Set<Id> ();
        for (Opportunity oppty : opportunityMap.values ()) {
            if (String.isNotBlank (oppty.AccountId)) {
                accIdSet.add (oppty.AccountId);
                if(opportunityOldMap != null){
              		Opportunity oldOppty = opportunityOldMap.get(oppty.Id);
                    if(oldOppty.AccountId != oppty.AccountId){
                     	accIdSet.add(oldOppty.AccountId);   
                        System.debug('Old Account Id - '+oldOppty.AccountId);
                        System.debug('New Account Id - '+oppty.AccountId);
                    }
                } //End inner if
            } // End if
        } // End for
        
        Map<Id, Decimal> accIdAmtMap = new Map<Id, Decimal> ();
        for (Opportunity anOpp : [SELECT Id, AccountId, Amount
                                    FROM Opportunity
                                    WHERE AccountId IN: accIdSet
                                    AND StageName = 'Closed Lost']) {
            if (!accIdAmtMap.containsKey (anOpp.AccountId))
                accIdAmtMap.put (anOpp.AccountId, 0);
            Decimal amt = accIdAmtMap.get (anOpp.AccountId);
            amt += anOpp.Amount;
            accIdAmtMap.put (anOpp.AccountId, amt);
            
        }
        
        List<Account> accListToUpdate = new List<Account> ();
        for (Account acc : [SELECT Id, Total_Lost_Amount__c
                                FROM Account
                                WHERE Id IN :accIdAmtMap.keySet()]) {
            acc.Total_Lost_Amount__c = accIdAmtMap.get (acc.Id);
            accListToUpdate.add (acc);
        } // End for
    	if (accListToUpdate.size () > 0)
            update accListToUpdate;
    }
    
    public static void updateAccountStatus(Map<Id, Opportunity> newOpprtunityMap){
        //Trigeer For Updating All Contacts related to opportunity
        /*System.debug('Inside updateAccountStatus');
		Set<id> AccountIdSet = new Set<id>();
        for(Opportunity oppty : newOpprtunityMap.values()){
            	AccountIdSet.add(oppty.AccountId);
        }
		System.debug('Opprtunity Set - '+AccountIdSet);
        
        Set<Id> contactIdSet = new Set<Id>();
        for(Contact con1:[Select Id 
                          FROM Contact 
                          WHERE Contact.AccountId IN: AccountIdSet]){
            System.debug('Conatct Id - '+con1);
            contactIdSet.add(con1.Id);
        }
        
		
		Set<Id> contactList = new Set<Id>();
		for(OpportunityContactRole opptyConRole : [SELECT Id,ContactId,OpportunityId 
                                                   FROM OpportunityContactRole
													WHERE ContactId IN: contactIdSet]){													                                                        
			System.debug('Contact Id in OpportunityContactRole'+opptyConRole.ContactId);											
			contactList.add(opptyConRole.ContactId);
		}
		System.debug('Contact Id in OpportunityContactRole'+contactList);
		
        List<Contact> cList = new List<Contact>();
        for(Contact con : [SELECT Level__c 
                          FROM Contact
                           WHERE Id IN: contactList]){
        	con.Level__c='Primary';
            cList.add(con);     
		}
        update cList;*/
        
        /*	This trigger will work when creating opportunity from Contact Page
         *  It will only update contact from which opportunity is created
         * */
        System.debug('Inside updateAccountStatus');
        Set<Id> opptyIdSet = new Set<Id>();
        for(Opportunity oppty : newOpprtunityMap.values()){
            opptyIdSet.add(oppty.Id);
        }
        System.debug('Opprtunity Set - '+opptyIdSet);
        
        List<Contact> contactListToUpdate = new List<Contact>();
        for(Contact aCon :[Select Id, Level__c
                          FROM Contact 
                          WHERE Id IN (SELECT ContactId
                                       FROM OpportunityContactRole
                                       WHERE OpportunityId IN : opptyIdSet)]){
            System.debug('Conatct Id - '+aCon);
            aCon.Level__c = 'Primary';
            contactListToUpdate.add(aCon);
        }
        if (contactListToUpdate.size () > 0)
            update contactListToUpdate;
    }
    
    public static void createNewOpportunityTask(List<Opportunity> oldOpptyList){
        System.debug('Inside createNewOpportunityTask Method');
        List<Task> taskList = new List<Task>();
        System.debug('isFirstRun value - '+isFirstRun);
        if(isFirstRun){
            for(Opportunity oppt : oldOpptyList){
                Task task=new Task();
                task.Subject = 'Won Oppty!';
                task.ActivityDate = Date.today();
                task.whatId = oppt.id;
                taskList.add(task);
            }
            isFirstRun = false;
            if(taskList.size() > 0){
                insert taskList;
            }    
       	}
        System.debug('New Task List '+taskList);
        System.debug('isFirstRun value - '+isFirstRun);
    }
}