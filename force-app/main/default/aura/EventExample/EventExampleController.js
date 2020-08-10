({
	dochange : function(component, event, helper) {
		console.log('change system event fire');	
	},
    doChangeValue : function(component, event, helper){
    	component.set('v.test','Value Change');
        var applicationEvent = $A.get('e.c:aeEvent');
        applicationEvent.fire();
    },
    doinit : function(component, event, helper){
        component.set('v.test','Value change from init');
        console.log('Init system event fire');
    },
})