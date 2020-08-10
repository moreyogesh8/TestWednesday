trigger OrderEventTrigger on udemyYogAnk__Order_Event__e (after insert) {
	System.debug('Within OrderEventTrigger');
    List<Task> taskList = new List<Task>();
    for(udemyYogAnk__Order_Event__e orderEVent : Trigger.New){
        if(orderEvent.Has_Shipped__c == true){
            Task t = new Task();
            t.priority = 'Medium';
            t.Subject = 'Follow up on shipped order '+orderEvent.udemyYogAnk__Order_Number__c;
            t.OwnerId = orderEvent.CreatedById;
            taskList.add(t);
        }
    }
    insert taskList;
}