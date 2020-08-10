global class LeadProcessor implements
	Database.Batchable<sObject>{
        global integer leadsProcesed = 0;
        global Database.QueryLocator start(Database.BatchableContext bc){
         	return DataBase.getQueryLocator('SELECT Id,LeadSource FROM Lead'); 
        }        
        global void execute(Database.BatchableContext bc, List<Lead> scope){
            List<Lead> leads = new List<Lead>();
            for(Lead lead : scope){
                lead.LeadSource = 'Dreamforce';
                leads.add(lead);
                leadsProcesed = leadsProcesed + 1;
            }
            update leads;
        }
        	
        global void finish(Database.BatchableContext bc){
         	System.debug('Number of leads procesed = '+leadsProcesed);
            AsyncApexJob job = [SELECT Id, Status, NumberOfErrors,
                              JObItemsProcessed,
                              TotalJobItems, CreatedBy.Email
                              FROM AsyncApexJOb 
                              WHERE Id = :bc.getJobId()];
            String messageBody = 'Number Of Leads Processed - '+leadsProcesed;
            EmailManager.sendMail('moreyogesh8@gmail.com', 'Results for LeadProcessor Job', messageBody);
        }
}