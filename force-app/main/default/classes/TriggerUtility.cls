/**
* Decription : This is utility class that contains static methods which are used in 
* different triggers
*  
* Created By: YM
* Created Date: 25-06-2017
**/
public with sharing class TriggerUtility {
    //A method that creates new opportunity when AnnualRevenue is greater than 499999 for Account.
    
    public static void insertOpportunity(List<Account> accList){
        for (Account acc : accList) {
            System.debug ('acc #### '+ acc);
            if (acc.AnnualRevenue > 499999) {
                Opportunity oppty = new Opportunity ();
                oppty.Name = acc.Name + ' - Default oppty';
                oppty.CloseDate = Date.today () + 30;
                oppty.StageName  = 'Qualification';
                oppty.AccountId = acc.Id;
                insert oppty; // Inserting new Oppty
                System.debug ('oppty #### '+ oppty);
            }
        }   
    }
    
    public static void insertPlatformEvent(List<udemyYogAnk__Cloud_News__e> cloudNewsEventList){
        System.debug('Inside insertPlatformEvent');
        //List to hold all cases to be created
        List<Case> cases=new List<Case>();
        //Get queue Id for case owner
        Group queue = [SELECT Id FROM Group WHERE Name='Regional Dispatch' AND Type='Queue']; 
        System.debug('Queue Name - '+queue);
        
        //Iterate through each notification
        for(Cloud_News__e event : cloudNewsEventList){
            if(event.Urgent__c == true){
                //Create case to dispatch new team
                Case cs = new Case();
                cs.Priority='High';
                cs.Subject='News Team dispatch to '+event.udemyYogAnk__Location__c;
                cs.OwnerId = queue.id;
                cases.add(cs);
            }    
        }
        System.debug('Case List - '+cases);
        //Insert all cases corrsponding to events received.
        insert cases;
    } 
    
}