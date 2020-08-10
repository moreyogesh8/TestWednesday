({
	handlingLPComplaints : function(component, event, helper) {
		console.log("LP Message Received at District Level");
        var MessageReceived = event.getParam("complaintMessage");
        console.log("Message from handlingLPComplaints is "+MessageReceived);
	},
    
    handlingMPComplaints : function(component, event, helper) {
		console.log("MP Message Received at District Level");
        var MessageReceived = event.getParam("complaintMessage");
        console.log("Message from handlingMPComplaints is "+MessageReceived);
        var eventSourceInfo = event.getSource();
        var sourceComponentName = event.getSource().getName();
        console.log("Source Component Name is "+sourceComponentName);
        if(sourceComponentName === "cS1D1Township1"){
            event.pause();
            //Analysis - Outcome is can be resolved so stop propagation
            //event.stopPropagation();
            //Analysis - Outcome is can't be resolved so resume event propagation
            event.resume();
        }
	},
    
    handlingHPComplaints : function(component, event, helper) {
		console.log("HP Message Received at District Level");
        var MessageReceived = event.getParam("complaintMessage");
        console.log("Message from handlingHPComplaints @ District level is "+MessageReceived);
        var eventSourceInfo = event.getSource();
        var sourceComponentName = event.getSource().getName();
        console.log("Source Component Name is "+sourceComponentName);
        
	}
})