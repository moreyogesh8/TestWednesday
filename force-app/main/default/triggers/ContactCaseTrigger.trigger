trigger ContactCaseTrigger on Contact (before delete) {
        if (Trigger.isAfter && Trigger.isUpdate) {
        ContactTriggerHandler.updateContactCount (Trigger.newMap, Trigger.oldMap);
    } 
    if (Trigger.isAfter && Trigger.isDelete){
        ContactTriggerHandler.updateContactCount (Trigger.oldMap, null);
    } else {
        ContactTriggerHandler.updateContactCount (Trigger.newMap, null);
    }

}