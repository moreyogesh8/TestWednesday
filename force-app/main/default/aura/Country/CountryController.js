({
	handlingHPComplaints : function(component, event, helper) {
		console.log("HP Message Received at National Level");
        var MessageReceived = event.getParam("complaintMessage");
        console.log("Message from handlingHPComplaints @ National Level is "+MessageReceived);
        var eventSourceInfo = event.getSource();
        var sourceComponentName = event.getSource().getName();
        console.log("Source Component Name is "+sourceComponentName);
        
	}

})