trigger ReAssignLeads on Lead (before insert, before update) {
    Set<Id> leadIds = new Set<Id>();
    for(Lead aLead:trigger.new) {
        leadIds.add (aLead.id);    
    } // End for
   ReassignLeadsTriggerHandler.reassignLeads (leadIds);
} // End trigger