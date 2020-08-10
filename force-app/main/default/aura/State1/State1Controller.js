({
	handlingMPComplaints : function(component, event, helper) {
		console.log("MP Message Received at State Level");
        var MessageReceived = event.getParam("complaintMessage");
        console.log("Message from handlingMPComplaints @ State Level is "+MessageReceived);
	},
    
    handlingHPComplaints : function(component, event, helper) {
		console.log("HP Message Received at State Level");
        var MessageReceived = event.getParam("complaintMessage");
        console.log("Message from handlingHPComplaints @ state level is "+MessageReceived);
        var eventSourceInfo = event.getSource();
        var sourceComponentName = event.getSource().getName();
        console.log("Source Component Name is "+sourceComponentName);
        
	}
})