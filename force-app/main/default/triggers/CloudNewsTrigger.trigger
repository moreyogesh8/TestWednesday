trigger CloudNewsTrigger on udemyYogAnk__Cloud_News__e (after insert) {
	TriggerUtility.insertPlatformEvent(Trigger.New);
}