trigger UpdateTrackingNum on Opportunity (before insert) {
    Integer opptyCount = [SELECT COUNT() FROM Opportunity];
    for (Opportunity oppty : Trigger.new) {
        opptyCount ++;
        oppty.TrackingNumber__c = 'TN-0000'+opptyCount;
    }
}