public class MerchandiseOperations {
 	public static Id invoice(String pName, Integer pSold, String pDesc){
 		//Retrieves Pencil Sample Merchandise
 		Merchandise__c m = [Select Price__c,Total_Inventory__c 
 							From Merchandise__c WHERE Name = :pName LIMIT 1];
 		//break if no Merchandise if found
 		System.assertNotEquals(null,m);
 		//Add a new Invoice
 		Invoice_Statement__c i = new Invoice_Statement__c(Description__c = pDesc);
 		insert i;
 		
 		//Add new Line Item to the Invoice
 		Line_Item__c l = new Line_Item__c(
 			Name = '1',
 			Invoice_Statement__c = i.id,
 			Merchandise__c = m.id,
 			Unit_Price__c = m.Price__c,
 			Units_Sold__c = pSold);
 		insert l;
 		
 		//Update inventory of merchandise item
 		m.Total_Inventory__c = m.Total_Inventory__C - pSold;
 		update m;
 		return i.id;								
 	}   
}