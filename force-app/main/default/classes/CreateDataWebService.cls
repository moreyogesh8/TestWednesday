@RestResource(urlMapping='/v1/syncdata/*') 
global with sharing class CreateDataWebService {
	
	@HttpPost
    global static void doPostData () {
        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;
        String jSONRequestBody = request.requestBody.toString().trim();

    JSONParser jsnPrsr = JSONParser.parse(jSONRequestBody);
        createRecords (jsnPrsr.accounts);
    }
	
	// Create records
	private static void createRecords (List<JsonParser.AcctsData> acctList) {
		List<Account> accListToInsert = new List<Account> ();
		List<Opportunity> opptyListToInsert = new List<Opportunity> ();
		
		for (JsonParser.AcctsData acct : acctList) {
			Account acc = new Account ();
			acc.Name = acct.name;
			acc.Industry = acct.industry;
			acc.AnnualRevenue = acct.annualRevenue;
			acc.Account_Key__c = acct.accKey;
			accListToInsert.add (acc);
			// Reference account
            Account accReference = new Account (Account_Key__c = acct.accKey);
			
			for (JsonParser.Oppts oppty : acct.oppData.opportunities) {
				Opportunity opp = new Opportunity ();
				opp.Name = oppty.name;
				opp.StageName = oppty.stageName;
				opp.CloseDate = Date.valueOf(oppty.closeDate);
				opp.Amount = oppty.amount;
				opp.Account = accReference;
				opptyListToInsert.add (opp);
			} // End second for 
		} // End for
		if (!accListToInsert.isEmpty ())
			upsert accListToInsert;
		if (!opptyListToInsert.isEmpty ())
			upsert opptyListToInsert;
	}
}