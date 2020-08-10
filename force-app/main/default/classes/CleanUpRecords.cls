global class CleanUpRecords implements Database.Batchable<sObject>{
	global final String query;
	
	global CleanUpRecords(String q){
		query=q;
	}
	
	global Database.QueryLocator start(Database.BatchableContext BC){
		System.debug('Start');
		return Database.getQueryLocator(query);
	}
	
	global void execute(Database.BatchableContext BC,List<sObject> scope){
		delete scope;
		Database.emptyRecycleBin(scope);
		System.debug('Execute');
	}
	
	global void finish(Database.BatchableContext BC){
		AsyncApexJob a = 
				[SELECT Id, Status, NumberOfErrors, JobItemsProcessed,
				TotalJobItems, CreatedBy.Email
				FROM AsyncApexJob WHERE Id = :BC.getJobId()];
		
		//Send an email to Apex Job's Submitter notifying of job completion
		Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
		String[] toAddress = new String[] {a.CreatedBy.Email};
		mail.setToAddresses(toAddress);
		mail.setSubject('Record CleanUp Status'+a.Status);
		mail.setPlainTextBody('Batch Apex Job Processed'+a.TotalJobItems +
								'batches with'+a.NumberOfErrors+' failures.');
		Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});		
		System.debug('Finish');				  		
	}
}