@isTest
public class PlatformEventTest {
    @isTest static void test1(){
        //Create Test Event instanc
        udemyYogAnk__Cloud_News__e newsEvent = new udemyYogAnk__Cloud_News__e(
        	Location__c = 'Mountain City',
            Urgent__c = true,
            News_Content__c = 'Test Message'
        ); 
        
        Test.startTest();
        	//Call Method to publish Event
        	Database.SaveResult er = EventBus.publish(newsEvent);
        Test.stopTest();
        
        //Varify that publich was successful
        System.assertEquals(true, er.isSuccess());
        
        //Check that the case that trigger created is present
        List<Case> cases = [SELECT Id FROM Case];
        
        //Validate that this test case was found
        //There is only one test case in test context
        System.assertEquals(1, cases.size());
    }
}