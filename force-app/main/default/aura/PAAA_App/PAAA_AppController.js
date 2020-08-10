({
	openOrcloseRegistartionForm : function(component, event, helper) {
        console.log("In openOrcloseRegistartionForm");
        var a = event.getSource().get("v.label");
        console.log('Event -> '+event.getSource());
        console.log(event.getSource().get("v.label"));
        if( a == "Open Registartion Form"){
            component.set("v.OpenRegistrationForm",true);
            component.set("v.ButtonLabel","Close the Form");
        }
        if(a =="Close the Form"){
            component.set("v.OpenRegistrationForm",false);
            component.set("v.ButtonLabel","Open Registartion Form");
        }
	}
})