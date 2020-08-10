trigger TaskTriggerHandler on Task (after insert) {
   if(Trigger.isAfter && Trigger.isInsert){
       TaskTriggerHandler.cloneRecurringTask(Trigger.new);
   } 
}