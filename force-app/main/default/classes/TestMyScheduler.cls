@isTest
public class TestMyScheduler {
	public static String CRON_EXP = '0 0 0 15 3 ? 2022';
    static testmethod void test(){
    	String query = 'SELECT Id,CreatedDate FROM Merchandise__c WHERE Id NOT IN(SELECT Merchandise__c FROM Line_Item__c)' ;
    	Merchandise__c[] m1=new List<Merchandise__c>();
    	for(Integer i=0;i<10;i++){
    		Merchandise__c m = new Merchandise__c(
    		Name = 'Test',
    		Description__c = 'Test',
    		Price__c = 10,
    		Total_Inventory__c = 100);
    		m1.add(m);
    	}
    	insert m1;
    	
    	test.startTest();
    	String jobid = System.schedule('TestMyScgeduler',CRON_EXP,new MyScheduler());
    	
    	//Get the information from Cron Trigger API Object
    	CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE Id = :jobid];
    	
    	//Varify The Expression are same
    	System.assertEquals(CRON_EXP,ct.CronExpression);
    	
    	//Varify the job has not run
    	System.assertEquals(0,ct.TimesTriggered);
    	
    	//Varify the next time job will run
    	System.assertEquals('2022-03-15 00:00:00',String.valueOf(ct.NextFireTime));
    	
    	//Varify the scheduled job hasn't run yet
    	Integer i = [Select count() FROM Merchandise__c];
    	System.assertEquals(m1.size(),10);
    	test.stopTest();
    	
    	//Not that the scheduled job has executed after the test.stopTest(),
    	Integer i1 = [SELECT Count() FROM Merchandise__c];
    	System.debug(i1);
    	System.assertEquals(i1,10); 
    }
}