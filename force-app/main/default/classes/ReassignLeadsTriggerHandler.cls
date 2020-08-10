public with sharing class ReassignLeadsTriggerHandler {
	public static void reassignLeads(Set<Id> leadIds){
        System.debug('Inside reassignLeads');
        AssignmentRule ar = new AssignmentRule();
        ar = [SELECT Id, Name FROM AssignmentRule WHERE SobjectType = 'Lead' AND Active = true LIMIT 1];
        System.debug ('Assignment Name ==> ' + ar.Name);
        //Creating the DMLOptions for "Assign using active assignment rules" checkbox
        Database.DMLOptions dmo = new Database.DMLOptions();
        //dmo.assignmentRuleHeader.useDefaultRule = true;
       	dmo.assignmentRuleHeader.assignmentRuleId= ar.Id;
        List<Lead> leadListToUpdate = new List<Lead> ();
        for (Lead leadInstance : [SELECT Id, Reassign__c FROM Lead WHERE Id IN: leadIds]){
             //Note this next line assumes you've created a custom field called Reassign, which is 
             //used to trigger the reassignment
             if(leadInstance.Reassign__c == true){
                 leadInstance.setOptions(dmo);
                 leadInstance.Reassign__c = false; //set it to false to avoid continually reassigning this lead
                 //Database.update(leadInstance,dmo);
                 //System.debug (' in try leadListToUpdate ==> ' + leadInstance);
                 //leadInstance.setOptions(dmo);
                 leadListToUpdate.add (leadInstance);
             }
         }//for
         try {
             if(leadListToUpdate.size()>0){
                 System.debug (' in try leadListToUpdate ==> ' + leadListToUpdate);
                 //AssignmentRule ar = new AssignmentRule();
        		 //ar = [SELECT Id, Name FROM AssignmentRule WHERE SobjectType = 'Lead' AND Active = true LIMIT 1];
                 //Database.DMLOptions dmo = new Database.DMLOptions();
                 //dmo.assignmentRuleHeader.assignmentRuleId= AR.id;
                 //dmo.assignmentRuleHeader.useDefaultRule = true;
                 Database.update(leadListToUpdate,dmo);
             }
             
         }catch (DMLException e){
             System.debug('Something went wrong with the reassignLeads method: ' + e.getMessage());
         }
	}
}