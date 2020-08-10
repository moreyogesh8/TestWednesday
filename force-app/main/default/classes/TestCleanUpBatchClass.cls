@isTest
private class TestCleanUpBatchClass {
    static testmethod void test(){
    	//The query used by the job
    	String query = 'SELECT Id,CreatedDate FROM Merchandise__c WHERE Id NOT IN(SELECT Merchandise__c FROM Line_Item__c)';
    	
    	//Create Some Test Merchandise item to be deleted by the batch job
    	Merchandise__c[] m1=new List<Merchandise__C>();
    	for(Integer i=0;i<10;i++){
    		Merchandise__c m = new Merchandise__c(
    		Name='Merchandise '+i,
    		Description__c='Some Description',
    		Price__c=2,
    		Total_Inventory__c=1000);
    		m1.add(m);
    	}	
    	insert m1;
    	
    	Test.startTest();
    	CleanUpRecords c=new CleanUpRecords(query);
    	Database.executeBatch(c);
    	Test.stopTest();
    	
    	//Varify Merchandise item got deleted
    	Integer i=[SELECT count() FROM Merchandise__c];
    	System.assertEquals(i,0);			
    }
}