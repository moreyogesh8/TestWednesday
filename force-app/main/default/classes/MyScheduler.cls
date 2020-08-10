global class MyScheduler implements Schedulable {
	global void execute(SchedulableContext sc){
		//query used by the batchjob
		String query = 'SELECT Id,CreatedDate FROM Merchandise__c WHERE Id NOT IN(SELECT Merchandise__c FROM Line_Item__c)';
		CleanUpRecords c  = new CleanUpRecords(query);
		Database.executeBatch(c);				
	}    
}