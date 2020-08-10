({
	doinit : function(component, event, helper) {
		var action = component.get("c.getContactList");
        /* optional */
        action.setParams({
            accountId : component.get("v.recordId"),  
        });
        action.setCallback(this,function(response){
            console.log('Inside');
            var responseValue = response.getReturnValue();
            console.log('responseValue ::: ',responseValue);
            component.set("v.contactList",responseValue);
        });
        $A.enqueueAction(action, false);
	},
    doRedirect : function(component, event, helper){
    	console.log('Inside doRedirect function');  
        var eventSource = event.getSource();
        var id = eventSource.get('v.name');
        console.log('Contact Id :: '+id);
        var navEvt = $A.get("e.force:navigateToSObject");
        navEvt.setParams({
            "recordId": id,
            "slideDevName": "detail"
        });
        navEvt.fire();
    },
    handleComponentEvent : function( component, event, helper){
    	console.log('Handler for component - quickContact');    
        var availableContactList = component.get('v.contactList');
        var contactRecord = event.getParam('ContactRecord');
        console.log(Object.values(contactRecord));
        availableContactList.push(contactRecord);
        component.set('v.contactList',availableContactList);
    },
})