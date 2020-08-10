public with sharing class JsonParser_1 {
	
	public static JsonParser_1 parse (String json) {
        return (JsonParser_1) System.JSON.deserialize (json, JsonParser_1.class);
    }
	
	public List<accData> accounts;
	
	public class accData {
		public String Acckey;
		public String Name;
		public String Industry;
		public Decimal AnnualRevenue;
		public OppData OppData;
		public ConData ConData;
		public OpptyContact OpptyContact;  	
	}
	
	public class OppData{
		public List<Opportunities> Opportunities;
	}
	
	public class Opportunities{
		public String OpptyKey;
		public String StageName;
		public String Name;
		public String CloseDate;
		public Decimal Amount;	
	}
	
	public class ConData{
		public List<Contacts> Contacts;
	}
	public class Contacts{
		public String ConKey;
		public String firstName;
		public String LastName;
		public String Email; 	
	}
	
	public class OpptyContact{
		public List<ContactRole> ContactRole;	
	}
	
	public class ContactRole{
		public String ConKey;
		public String OpptyKey;
		public boolean Primary;
		public String role; 
	}    
}