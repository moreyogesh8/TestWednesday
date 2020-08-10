public class StringArrayTest {
    public static List<String> generateStringArray(Integer value){
        List<String> result = new List<String>();
        for(Integer n=0;n<value;n++){
         	result.add('Test '+n);   
        } 
        System.debug('Values - '+result);
        return result;
    }
}