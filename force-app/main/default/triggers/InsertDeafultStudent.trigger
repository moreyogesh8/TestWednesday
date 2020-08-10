trigger InsertDeafultStudent on Teacher__c (after insert) {

    for(Teacher__c tea : Trigger.new){
        Teacher__c Name=[select Name from Teacher__c where Name = :tea.Name];
               
        System.debug('TeacherUpdate Trigger'+tea);
        
        if(tea.Age__c > 35 && tea.Experience_Status__c == 'Experience'){
            Student__c stud=new Student__c();
            stud.Name='Default Student';
            stud.Registration_Number__c='1'; 
            Stud.Teacher__c=tea.Id;
            //Teacher__r.Name=Name;ring s=
            insert stud;
        }
    }
}