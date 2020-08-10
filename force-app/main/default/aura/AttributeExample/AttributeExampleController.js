({
	doclick : function(component, event, helper) {
        alert(component.isValid());
        alert(component.getName());
        alert(component.get("v.whom"));
        component.set("v.whom","Anki Tutorial");
        var ageComp = component.find("test");
        alert(ageComp.get("v.value"));
        ageComp.set("v.value","88");
	}
})