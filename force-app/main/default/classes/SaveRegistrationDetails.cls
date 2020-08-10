public class SaveRegistrationDetails {
	
    @AuraEnabled
    public static Id saveRegistrationDetails(Registration_Form__c regForm){
    	//DML Operations to save RegForm Details
    	System.debug('Values from saveRegistrationDetails -> '+regForm);
    	insert regForm;
        return regForm.id;
    }
    
    @AuraEnabled
    public static Id saveEducationDetails(Educational_Detail__c EduDet){
    	//DML Operations to save RegForm Details
    	insert EduDet;
        return EduDet.id;
    }
    
}