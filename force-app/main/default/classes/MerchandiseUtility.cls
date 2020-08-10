public class MerchandiseUtility {
	public static void mainProcessing(){
        try{
            insertMerchandise();
        }catch(MerchandiseException e){
            System.debug('Message: '+e.getMessage());
            System.debug('Cause: '+e.getCause());
            System.debug('Line Number: '+e.getLineNumber());
            System.debug('Stack Trace: '+e.getStackTraceString());
        }
    }   
    
    public static void insertMerchandise(){
        try{
            //insert merchandise without required fields
            Merchandise__c m=new Merchandise__c();
            insert m;
        }catch(DmlException de){
            //Something happen that prevents the insertion of Merchandise custom object, So throwing more specific Exception
            throw new MerchandiseException('Merchandise item could not be inserted',de);
        }
    }
}