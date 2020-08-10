public with sharing class ContactDataController {
    	
    public List<ContactData> conData {get; set;}
	
       
    public PageReference processSelected(){
		System.debug('From Save method');   
    	List<Contact> selContactList = new List<Contact>();
        
        for(ContactData con1 : conData){
            System.debug('Contact Value - '+con1);
            if(con1.selected == true){
                System.debug('Contact Value - '+con1);
            	selContactList.add(con1.con);    
            }
        }
        
        if(selContactList.size()>0){
            try{
            	delete selContactList;    
            }catch(DmlException e){
            	System.debug('Error Message - '+e.getMessage());    
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage());
            	ApexPages.addMessage(myMsg);
            }
            
        }
        System.debug('Contacts to be deleted - '+selContactList);
		return null;       
    }   
    
	public List<ContactData> getContactList(){
		conData = new List<ContactData>();
		for(Contact con : [SELECT Id,firstname,lastname,email
						FROM contact]){
			ContactData contactDetail = new ContactData(con);
			conData.add(contactDetail);
		}
		System.debug('List of Contacts - '+conData+' List Size - '+conData.size());
		return conData;	
	}
	
	public class ContactData{
        public Contact con			{get; set;}
        public boolean selected	{get; set;}
		//Constructor
		public ContactData(Contact con){
			this.con = con;
			//selected = false;
		}
	}    
}