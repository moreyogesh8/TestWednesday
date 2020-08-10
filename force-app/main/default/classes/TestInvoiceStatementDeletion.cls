@isTest
public with sharing class TestInvoiceStatementDeletion {
    static testmethod void TestDeleteInvoiceWithLineItem(){
    	//Create Invoice Statement with Line Item then try to delete it
    	Invoice_Statement__c inv = TestDataFactory.createOneInvoiceStatement(true);
    	Test.startTest();
    	Database.DeleteResult result = Database.delete(inv,false);
    	Test.stopTest();
    	
    	//Varify invoice with line item did not get deleted
    	System.assert(!result.isSuccess());
    }
    
    static testmethod void TestDeleteInvoiceWIthoutLineItems(){
    	//Create an invoice statement without Line Item and try to delete it
    	Invoice_Statement__c inv = TestDataFactory.createOneInvoiceStatement(false);
    	Test.startTest();
    	Database.DeleteResult result = Database.delete(inv,false);
    	Test.stopTest();
    	
    	//Varify Invoice without Line Item got deleted
    	System.assert(result.isSuccess());
    }
    
    static testmethod void TestBulkDeleteInvoices(){
 		//Create two invoice statements one with and one without LineItems. Then try to delete them both in a bulk operation,as might happen when trigger fires
 		List<Invoice_Statement__c> invList = new List<Invoice_Statement__c>();
 		invList.add(TestDataFactory.createOneInvoiceStatement(true));  
 		invList.add(TestDataFactory.createOneInvoiceStatement(false));
 		Test.startTest();
 		Database.DeleteResult[] result=Database.delete(invList,false);
 		Test.stopTest();
 		
 		//Varify Invoice with Line Item did not get deleted
 		System.assert(!result[0].isSuccess()); 
 		
 		//Varify Invoice with Line Item gets deleted
 		System.assert(result[1].isSuccess());	
    }
}