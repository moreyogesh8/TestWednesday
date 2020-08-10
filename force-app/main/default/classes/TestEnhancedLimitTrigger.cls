@isTest
public with sharing class TestEnhancedLimitTrigger {
    static testmethod void testLimit(){
    	//System.debug('Start testLimit');
    	Invoice_Statement__c inv = TestDataFactory.CreateIStatement();
    	Merchandise__c m1 = TestDataFactory.createMerchandiseItem1('Orange juice');
    	Line_Item__c li = TestDataFactory.AddLineItem1(inv,m1);
    	Test.startTest();
    	Database.SaveResult dlr = Database.update(inv,false);
    	Database.SaveResult dlr1 = Database.update(m1,false);
    	Database.SaveResult dlr2 = Database.update(li,false);
    	System.debug(li.name);
    	Test.stopTest();
    	//System.debug('End testLimit');
    	System.debug(dlr.isSuccess());
    	System.assert(dlr.isSuccess());
    } 
}