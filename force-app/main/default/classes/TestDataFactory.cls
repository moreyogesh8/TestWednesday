@isTest
public class TestDataFactory {
    public static Invoice_Statement__c createOneInvoiceStatement(Boolean withLineItem){
    	Invoice_Statement__c testInvoice = createInvoiceStatement();
    	if(withLineItem == true){
    		//Create Merchandise item
    		Merchandise__c m = createMerchandiseItem('Orange juice');
    		
    		//Create one Line Item and associate it with with invoice statement
    		AddLineItem(testInvoice,m);
    	}
    	return testInvoice;
    }
    
    //Helper Methods
    private static Merchandise__c createMerchandiseItem(String merchName){
    	Merchandise__c m = new Merchandise__c(
    	Name = merchName,
    	Description__c = 'Fresh Juice',
    	Price__c = 2,
    	Total_Inventory__c = 1000);
    	insert m;
    	return m;
    }
    
    private static Invoice_Statement__c createInvoiceStatement(){
    	Invoice_Statement__c inv = new Invoice_Statement__c(
    	Description__c = 'Test Test Invoice');
    	insert inv;
    	return inv;	
    }
    
    private static Line_Item__c AddLineItem(Invoice_Statement__c inv,Merchandise__c m){
    	Line_Item__c lineItem = new Line_Item__c(
    	Invoice_Statement__c=inv.Id,
    	Merchandise__c=m.Id,
    	Unit_Price__c=m.Price__c,
    	Units_SOld__c=(Double)(10*Math.random()+1));
    	insert lineItem;
    	return lineItem;
    }
    
    public static Invoice_Statement__c CreateIStatement(){
    	System.debug('Start CreateIStatement');
    	Invoice_Statement__c test1=createInvoiceStatement1();
    	//Merchandise__c m1 = createMerchandiseItem1('Orange juice');
    	//Line_Item__c li = AddLineItem1(test1,m1);	
    	System.debug('End CreateIStatement');
    	return test1;
    }
    
     public static Merchandise__c createMerchandiseItem1(String merchName){
     	System.debug('Start createMerchandiseItem1');
    	Merchandise__c m = new Merchandise__c(
    	Name = merchName,
    	Description__c = 'Fresh Juice',
    	Price__c = 2,
    	Total_Inventory__c = 1000);
    	System.debug('End createMerchandiseItem1');
    	insert m;
    	return m;
    }
    
     public static Invoice_Statement__c createInvoiceStatement1(){
     	System.debug('Start createInvoiceStatement1');
    	Invoice_Statement__c inv11 = new Invoice_Statement__c(
    	Description__c = 'Test Test Invoice 007');
    	insert inv11;
    	System.debug('End createInvoiceStatement1');
    	return inv11;
    }
    
     public static Line_Item__c AddLineItem1(Invoice_Statement__c inv,Merchandise__c m1){
     	System.debug('Start AddLineItem1');
     	
    	Line_Item__c lineItem = new Line_Item__c(
    	Name='Hello',
    	Invoice_Statement__c=inv.Id,
    	Merchandise__c=m1.Id,
    	Units_SOld__c=(Double)(10*Math.random()+1));
    	System.debug('End AddLineItem1');
    	insert lineItem;
    	return lineItem;
    	
    }
}