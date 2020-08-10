trigger ClosedOpportunityTrigger on Opportunity (after insert,after update) {
    System.debug('Inside ClosedOpportunityTrigger');
    List<Task> tList = new List<Task>();
    for(Opportunity oppty : Trigger.New){
        if(oppty.StageName == 'Closed Won'){
            System.debug('Condition is met');
            Task ntask = new Task();
            ntask.Subject='Follow Up Test Task';
            ntask.WhatId=oppty.id;
            tList.add(ntask);
        }
    }
    insert tList;
}