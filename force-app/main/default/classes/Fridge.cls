public class Fridge {
    private String modelNumber;
    private Integer numberInStock;
    public static final Integer stockThreshold = 5;
    
    public Fridge(){
        modelNumber='XX-XX';
        numberInStock=0;
    }
    
    public Fridge(String theModelNumber,Integer theNumberInStock){
        modelNumber=theModelNumber;
        numberInStock=theNumberInStock;
    }
    
    public static void toDebug(Fridge aFridge){
        System.debug('ModelNumber: '+aFridge.modelNumber);
        System.debug('Number In Stock: '+aFridge.numberInStock);
    }
    
    public void setModelNumber(String theModelNumber){
        modelNumber=theModelNumber;
    }
    
    public String getModelNumber(){
        return modelNumber;
    }
    public void updateStock(Integer justSold){
        numberInStock=numberInStock-justSold;
    }
}