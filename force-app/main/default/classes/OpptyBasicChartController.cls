public with sharing class OpptyBasicChartController {
    public List<SelectOption> yearList {get; set;}
    public String selYear  {get; set; }
    
    public OpptyBasicChartController(){
    	//year='2018';    
    }

    public PageReference search(){
        System.debug('Test');
    	getOppDataWithMonthNames ();
        getHeaderYear();
        return null;
    }
	
    public Component.Apex.SectionHeader getHeaderYear(){
        System.debug('Year from getHeaderYear - '+selYear);
        Component.Apex.SectionHeader sectionHeader = new Component.Apex.SectionHeader();
        sectionHeader.title = 'Opportunity Analysis for ' + selYear;
        System.debug(sectionHeader.title);
        return sectionHeader;
    }
    
    public List<OpportunityData> getOppDataWithMonthNames () {
		System.debug('Year - '+selYear);
        List<OpportunityData> oppsData = new List<OpportunityData>();
        for (AggregateResult ar : [SELECT SUM(amount) monthlyRev,
									COUNT(name) noOfClosedOpps,
                                    CALENDAR_MONTH(CloseDate) month,
                                    CALENDAR_YEAR(CloseDate) year
                                    FROM Opportunity 
                                    GROUP BY CALENDAR_YEAR(closeDate),
                                    CALENDAR_MONTH(CloseDate), StageName
                                    HAVING StageName='Closed Won' AND
                                    CALENDAR_YEAR(CloseDate) = :Integer.valueOf(selYear)]) {
            Datetime dt = Datetime.newInstance((Integer) ar.get('year'),
                                    (Integer) ar.get('month'), 1);
									
            OpportunityData opp = new OpportunityData(dt.format('MMM'),
                                    (Integer) ar.get('noOfClosedOpps'),
                                    (Double) ar.get('monthlyRev'));

            oppsData.add(opp);
			System.debug('List values - '+oppsData);
        }
        System.debug('CHecking null --'+oppsData);
        if(oppsData.isEmpty()){
                System.debug('CHecking null --'+oppsData);
            	String errorMsg='Data not available for Year '+String.valueOf(selYear);
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.WARNING, errorMsg);
                ApexPages.addMessage(myMsg);
         }
        return oppsData;
    }

    public class OpportunityData {
        public String month { get; set; }
        public Integer noOfClosedOpps { get; set; }
        public Double monthlyRev { get; set; }

        public OpportunityData(String mon, Integer noOfOpps, Double rev) {
            month = mon;
            noOfClosedOpps = noOfOpps;
            monthlyRev = rev;
        }
          
    }
    
    public List<SelectOption> getListOfYears(){
        yearList = new List<SelectOption>();
        Integer currentYear = system.today().year();
       	selYear = String.valueOf(currentYear);
        //yearList.add(new SelectOption(String.valueOf(currentYear),String.valueOf(currentYear)));
        for(Integer i=4; i>=0; i--){
        	yearList.add(new SelectOption(String.valueOf(currentYear-i),String.valueOf(currentYear-i)));	    
        }
		System.debug('Year'+yearList);
		return yearList;        
    }
}