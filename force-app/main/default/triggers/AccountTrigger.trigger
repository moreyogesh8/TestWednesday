trigger AccountTrigger on Account (after update,before update) {
    if(Trigger.isAfter){
        AccountTriggerHandler.updateFaxonContact (Trigger.newMap);
        AccountTriggerHandler.updateChildAccount (Trigger.new);
    }
    if(Trigger.isBefore){    
        //AccountTriggerHandler.updateChildAccount (Trigger.new);
    }    
}