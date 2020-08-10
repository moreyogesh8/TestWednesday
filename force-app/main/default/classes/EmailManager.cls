public class EmailManager {
	//Public Method
    public static void sendMail(String address, String subject, String body){
        Messaging.SingleEmailMessage mail=new Messaging.SingleEmailMessage();
    	String[] toAddress = new String[] {address};
    	mail.setToAddresses(toAddress);
        mail.setSubject(subject);
        mail.setPlainTextBody(body);
        //Pass this email message to the build-in send email method of the Messaging class
        Messaging.SendEmailResult[] results = Messaging.sendEmail(
            new Messaging.singleEmailMessage[]{mail});
        //Call helper method to inspect the returned result
        inspectResults(results);
    }
    
    //Helper Mathod
    private static boolean inspectResults(Messaging.sendEmailResult[] results){
        Boolean sendResult = true;
        //sendEmail returns an array of result object
        //Iterate through the list to inspect result.
        //In this class, method sends only one email
        //so we should have only one result
        for(Messaging.sendEmailResult res : results){
            if(res.isSuccess()){
                System.debug('Email sent successfully');
            }else{
                sendResult = false;
                System.debug('Following error occured - '+res.getErrors());
            }
        }
        return sendResult;
    }
	
}