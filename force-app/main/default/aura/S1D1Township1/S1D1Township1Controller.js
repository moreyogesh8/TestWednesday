({
	forwardLPComplaint : function(component, event, helper) {
        console.log('Inside forwardLPComplaint method');
		//fire Component Event, below are the steps involved
		// 1. Get Reference to our component event
		var LPCEvent = component.getEvent("LowPriorityComplaintFromTownship1");
        // 2. Set Attribute Value
        LPCEvent.setParams({"complaintMessage":"Township2 is not behaving Properly"});
        // 3. Fire the Event
        LPCEvent.fire();
	},
    
    forwardMPComplaint : function(component, event, helper) {
        console.log('Inside forwardMPComplaint method');
		//fire Component Event, below are the steps involved
		// 1. Get Reference to our component event
		var MPCEvent = component.getEvent("MediumPriorityComplaintFromTownship1");
        // 2. Set Attribute Value
        MPCEvent.setParams({"complaintMessage":"Township2 is dumping waste in Township1"});
        // 3. Fire the Event
        MPCEvent.fire();
	},
    
    forwardHPComplaint : function(component, event, helper) {
        console.log('Inside forwardHPComplaint method');
		//fire Component Event, below are the steps involved
		// 1. Get Reference to our component event
		var HPCEvent = component.getEvent("HighPriorityComplaintFromTownship1");
        // 2. Set Attribute Value
        HPCEvent.setParams({"complaintMessage":"Township2 is contaminating water supplies to Township1"});
        // 3. Fire the Event
        HPCEvent.fire();
	}
})