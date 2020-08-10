public class TaskTriggerHandler {
    //Static boolean variable to stop recursion
    private static Boolean isFirstRun = true; 
    
    public static void cloneRecurringTask(List<Task> newTasks){
    	System.debug('Inside cloneRecurringTask Method');                
        List<Task> taskListToCreate = new List<Task>();
        if(isFirstRun){
        	for(Task task : newTasks){
                if(task.Create_Followup_Task__c == true){
                    Task tempTask = task.clone(false,false,false,false);
                    tempTask.Subject = 'Follow Up '+task.Subject;
                    tempTask.ActivityDate = Date.today().addDays(3);
                    taskListToCreate.add(tempTask); 
                    System.debug('CLone Object'+tempTask);   
                } 
        	}    
        }
        isFirstRun=false;
        if(taskListToCreate.size()>0){
         	insert taskListToCreate;   
        }        
    }
}