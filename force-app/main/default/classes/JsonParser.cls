/**
 * Description: This class parse the jason response, and create values for 
 * Salesforce records.
 *
 * Created By: [Your Name]
 * Created Date: 03-11-2018
 **/
public with sharing class JsonParser {
	
    public static JsonParser parse (String json) {
        return (JsonParser) System.JSON.deserialize (json, JsonParser.class);
    }
	
	// Wrapper class
	public List<AcctsData> accounts;
	
	public class AcctsData {
		public String name;
		public String industry;
		public Decimal annualRevenue;
		public String accKey;
		public opptyData oppData;
	}
	public class opptyData {
		public List<Oppts> opportunities;
	}
	
	public class Oppts {
		public String name;
		public String stageName;
		public String closeDate;
		public Decimal amount;
		public String opptyKey;
	}
}