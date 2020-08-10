trigger StateTriggerOnOpportunity on Opportunity (before update, before delete, after update, after insert, after delete) {
   
    if(Trigger.isBefore && Trigger.isDelete){
        OpportunityTriggerHandler.stopOpptyDelete (Trigger.old);
    }    
    If(Trigger.isBefore && Trigger.isUpdate){
        OpportunityTriggerHandler.createNewOpportunityTask(Trigger.old);        
    }
    
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            //OpportunityTriggerHandler.checkLostOpportunityAmount(Trigger.newMap,null);
            OpportunityTriggerHandler.updateAccountStatus(Trigger.newMap);
        }
        if(Trigger.isUpdate){
            OpportunityTriggerHandler.checkLostOpportunityAmount(Trigger.newMap,Trigger.oldMap);
        }
        if(Trigger.isDelete){
            OpportunityTriggerHandler.checkLostOpportunityAmount(Trigger.oldMap,null);
        }
    }
}