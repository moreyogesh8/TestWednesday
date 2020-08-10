trigger RestrictInvoiceDeletion on Invoice_Statement__c (before delete) {
	//With each of the invoice statements targeted by the trigger
	//and that have line items, add an error to prevent them
	//from being deleted.
	for(Invoice_Statement__c invoice : 
		[Select Id From Invoice_Statement__c
		Where Id In (Select Invoice_Statement__C from Line_Item__C) AND
		Id IN :Trigger.old ]){
            System.debug(Trigger.old);
			Trigger.oldMap.get(invoice.Id).addError('Cannot delete invoice statement with line item');		
				
		}
}