@RestResource(urlMapping='/v2/syncdata3/*')
global with sharing class CreateDataWebService_1 {
    
    @HttpPost
    global static void doPostData(){
        System.debug('Test');
    	RestRequest request = RestContext.request;
        System.debug('Test_1');
    	RestResponse response = RestContext.response;
    	String JSONReequestBody = request.requestBody.toString().trim();
 		System.debug('Test_2');
 		JsonParser_1 jsnPrsr = JsonParser_1.parse(JSONReequestBody);
 		System.debug('Parsing result'+jsnPrsr);
        createRecords(jsnPrsr.accounts);
    }
    private static void createRecords(List<JsonParser_1.accData> accList){
        System.debug('WIthin createRecords');
    	List<Account> accListToInsert = New List<Account>();
        List<Opportunity> oppListToInsert = New List<Opportunity>();
        List<Contact> conListToInsert = new List<Contact>();
        List<OpportunityContactRole> oppConRolrToInsert = new List<OpportunityContactRole>();
        
        for(JsonParser_1.accData acct : accList){
            Account acc = new Account();
            acc.udemyYogAnk__Account_Key__c = acct.Acckey;
            acc.Name = acct.Name;
            acc.Industry = acct.Industry;
            acc.AnnualRevenue = acct.AnnualRevenue;
            System.debug('Account to be added - '+acc);
            accListToInsert.add(acc);
            //Reference Account
            Account accReference = new Account(udemyYogAnk__Account_Key__c = acct.Acckey);
            Contact conRefrence;
            Opportunity oppReference;
            
            for(JsonParser_1.Opportunities oppty : acct.OppData.Opportunities){
            	Opportunity opp = new Opportunity();
                opp.udemyYogAnk__Opportunity_Key__c = oppty.OpptyKey;
                opp.StageName = oppty.StageName;
                opp.Name = oppty.Name;
                opp.CloseDate = Date.valueOf(oppty.CloseDate);
                opp.Amount = oppty.Amount;
                opp.Account = accReference;
                System.debug('Opportunity to be added - '+opp);
                oppListToInsert.add(opp);
                //Reference Opportunity
                oppReference = new Opportunity(udemyYogAnk__Opportunity_Key__c = oppty.OpptyKey);
            }//End For Opportunity Loop
            
            for(JsonParser_1.Contacts con : acct.ConData.Contacts){
            	Contact cont = New Contact();    
                cont.udemyYogAnk__Contact_Key__c = con.ConKey;
                cont.FirstName = con.firstName;
                cont.LastName = con.LastName;
                cont.Email = con.Email;
                cont.Account = accReference;
                System.debug('Contact to be added - '+cont);
                conListToInsert.add(cont);
                //Refrence Contact
                conRefrence = new Contact(udemyYogAnk__Contact_Key__c = con.ConKey);
            }//End For Contacts Loop
            
            for(JsonParser_1.ContactRole conRole : acct.OpptyContact.ContactRole){
                OpportunityContactRole oppConRole = new OpportunityContactRole();
                oppConRole.Contact = conRefrence;
                oppConRole.Opportunity = oppReference;
                oppConRole.IsPrimary = conRole.Primary;
                oppConRole.Role = conRole.Role;
                System.debug('Opportunity Contact Role ->'+oppConRole);
                oppConRolrToInsert.add(oppConRole);
            }//End For OpportunityContactRole Loop
            
        }//End For Account Loop
        if(accListToInsert != null){
            //upsert accListToInsert;
            Database.upsert(accListToInsert,Account.udemyYogAnk__Account_Key__c.getDescribe().getSObjectField(),false) ;
        }
        if(oppListToInsert != null){
            //upsert oppListToInsert;
            Database.upsert(oppListToInsert,Opportunity.udemyYogAnk__Opportunity_Key__c.getDescribe().getSObjectField(),false) ;
        }
        if(conListToInsert != null){
            //upsert conListToInsert;
            Database.upsert(conListToInsert,Contact.udemyYogAnk__Contact_Key__c.getDescribe().getSObjectField(),false) ;
        }
        if(oppConRolrToInsert != null){
            Database.upsert(oppConRolrToInsert,OpportunityContactRole.id.getDescribe().getSObjectField(),false) ;
            

        }
            
    }
}