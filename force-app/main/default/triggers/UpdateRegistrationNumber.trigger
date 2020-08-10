trigger UpdateRegistrationNumber on Student__c (before insert) {
    Integer registrationNumCount = [SELECT COUNT() FROM Student__c ];
    for(Student__c stud:Trigger.new){
        registrationNumCount++;
        stud.Registration_Number__c='STD-0000'+registrationNumCount;
    }
}