public class AnimalLocator {
    public static String getAnimalNameById(Integer id){
        System.debug('Value - '+id);
        //String strName;
        AnimalResult result;
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/'+id);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        if(response.getStatusCode() == 200){
            /*Map<String,Object> results = (Map<String,Object>) JSON.deserializeUntyped(response.getBody());
            System.debug('Test - '+results);
            Map<String,Object> animals = (Map<String,Object>) results.get('animal');
            System.debug('Data - '+animals);
            System.debug(animals.get('name')+':'+animals.get('eats')+':'+animals.get('says'));
            strName = String.valueOf(animals.get('name'));*/
            result = (AnimalResult) JSON.deserialize(response.getbody(), AnimalResult.class);
            System.debug('Test - '+result);
            System.debug(result.animal.name);
            
        }
        //return strName;
        return result.animal.name;
        
    }
    public class AnimalResult{
    	Animal animal;
    }
        
    public class Animal{
        public String name;
        public String eats;
        public String says;
    }
}