public class BeerSearchAuraService {
	@AuraEnabled
    public static List<sObject> searchBeer(String searchText){
        System.debug('Parameter :: '+searchText);
        String likeParameter = '%'+searchText+'%';
        String Query = '';
        if(searchText != null){
        	Query = 'SELECT Id,Name,Alcohol__c,brewery_id__c,brewery_Name__c,Id__c,Price__c,Remaining_Quantity__c,Tags__c,Total_Quantity__c FROM udemyYogAnk__Beer__c WHERE Name like :likeParameter limit 10';    
        }else{
        	Query = 'SELECT Id,Name,Alcohol__c,brewery_id__c,brewery_Name__c,Id__c,Price__c,Remaining_Quantity__c,Tags__c,Total_Quantity__c FROM udemyYogAnk__Beer__c limit 10';    
        }
        
        List<sObject> beerList = Database.query(Query);
        System.debug('beerList ::'+beerList);
        return beerList;
    }
}