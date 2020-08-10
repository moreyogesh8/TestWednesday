trigger TeacherNameUpdateOnStudent on Teacher__c (after update) {
    List<Student__c> studentList;
    for(Teacher__c tea1:Trigger.old){
        studentList=[Select Name,Additional_Activit__c,Teacher__c,Registration_Number__c
        from Student__c stu where stu.Teacher__c=:tea1.Id];
        System.debug('Value: '+studentList);
    }
    
    for(Teacher__c tea2:Trigger.new){
        for(Student__c stud:studentList){
            stud.Teacher__c=tea2.id;
        }
    }
}