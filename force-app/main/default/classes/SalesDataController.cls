/**
 * Description: This is a controller class that return a list of wrapper obj to Visualforce page
 *
 * Created By: Siddharth Pandit
 * Created Date: 30-09-2018
 **/
public with sharing class SalesDataController {
	
    public List<Sobject> sObjList {get; set;}
    
	// A method to return list of businessData 
	public List<BusinessData> getRecords () {
    	sObjList = new List<Sobject> ();    
		List<BusinessData> recordsToReturn = retrieveAccounts ();
		recordsToReturn.addAll (retrieveOppties ());
		recordsToReturn.addAll (retrieveLeads ());
		return recordsToReturn;
	}
	
	// A method to return 10 accounts
	private List<BusinessData> retrieveAccounts () {
		List<BusinessData> accListToReturn = new List<BusinessData> ();
		for (Account acc : [SELECT Id, Name, Industry, AnnualRevenue
							FROM Account
							WHERE AnnualRevenue > 0
							LIMIT 5]) {
			BusinessData wrpInstance = new BusinessData (acc.Name, acc.Industry,
														acc.AnnualRevenue);
			accListToReturn.add (wrpInstance);
            sObjList.add(acc);                    
		}
		return accListToReturn;
	}
	
	// A method to return 10 Oppties
	private List<BusinessData> retrieveOppties () {
		List<BusinessData> opptyListToReturn = new List<BusinessData> ();
		for (Opportunity oppty : [SELECT Id, Name, StageName, Amount
								FROM Opportunity
								WHERE Amount > 0
								LIMIT 5]) {
			BusinessData wrpInstance = new BusinessData (oppty.Name, oppty.StageName,
														oppty.Amount);
			opptyListToReturn.add (wrpInstance);
            sObjList.add(oppty);
		}
		return opptyListToReturn;
	}
	
	// A method to return 10 Leads
	private List<BusinessData> retrieveLeads () {
		List<BusinessData> leadListToReturn = new List<BusinessData> ();
		for (Lead ld : [SELECT Id, Name, Status, AnnualRevenue
								FROM Lead
								WHERE AnnualRevenue > 0
								LIMIT 5]) {
			BusinessData wrpInstance = new BusinessData (ld.Name, ld.Status,
														ld.AnnualRevenue);
			leadListToReturn.add (wrpInstance);
            sObjList.add(ld);
		}
		return leadListToReturn;
	}
	
	
	// Wrapper class 
	public class BusinessData {
		public String recName 		{get; set;}
		public String recStatus	 	{get; set;}
		public Decimal recRev		{get; set;}
		
		// Constructor
		public businessData (String pRecName, String pRecStatus, Decimal pRecRev) {
			this.recName = pRecName;
			this.recStatus = pRecStatus;
			this.recRev = pRecRev;
		} // End constructor
	}
}