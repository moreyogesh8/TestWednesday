@isTest
private class LeadProcessorTest {
	@testSetup
    static void setup(){
        List<Lead> leadList = new List<Lead>();
        for(Integer i=0; i<10; i++){
            leadList.add(new Lead(
            	FirstName = 'First'+i,
                LastName = 'Last'+1,
                Company = 'Test-Company-'+i,
                Status = 'Open - Not Contacted',
                LeadSource = 'Web'
            ));
        }
        insert leadList;
    }
    
    @isTest
    static void test(){
        Test.startTest();
        LeadProcessor leadProc = new LeadProcessor();
        Id batchId = Database.executeBatch(leadProc);
        Test.stopTest();
        System.assertEquals(10, [SELECT count() FROM Lead WHERE LeadSource='Dreamforce']);
    }
}