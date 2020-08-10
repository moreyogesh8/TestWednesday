@isTest
public with sharing class TestSchedulableClass {
    //Cron Expression : midnight on march 15.
    //Beacuse this is a Test, job executes immediately after Test.stopTest()
    public static String CRON_EXP = '0 0 0 15 3 ? 2022';
    
    static testmethod void test(){
    	Test.startTest();
    	
    	//Schedule the Test Job
    	String jobId = System.schedule('ScheduleApexClassTest',CRON_EXP,new MySchedulableClass());
    	
    	//Get the information from the CronTrigger API Object
    	CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime 
    					FROM CronTrigger WHERE Id = :jobId];
    	
    	//Varify the Expression are same
    	System.assertEquals(CRON_EXP,ct.CronExpression);
    	
    	//Varify the job has not run
    	System.assertEquals(0,ct.TimesTriggered);	
    	
    	//Varify the next time job will run
    	System.assertEquals('2022-03-15 00:00:00',String.valueOf(ct.NextFireTime));
    	
    	//Varify that scheduled job has notrun yet
    	Merchandise__c[] m1 = [SELECT Id FROM Merchandise__C
    										WHERE Name='Scheduled Job Item'];
    	System.assertEquals(m1.size(),0);
    	Test.stopTest();
    	
    	//Now That Scheduled job has executed after test.stopTest() fetch the new merchandise that got added
    	m1 = [SELECT Id FROM Merchandise__c 
    						WHERE Name='Scheduled Job Item'];
    	System.assertEquals(m1.size(),1);					 			
    }  
}