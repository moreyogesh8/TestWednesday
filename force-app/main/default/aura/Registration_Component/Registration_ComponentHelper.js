({
	onClickCheckBoxhelper1 : function(component,event) {
		//body of helper
		console.log("This text is from helper function");
        console.log(component.find("checkBox").get("v.type"));
        var checkBoxValue = component.find("checkBox").get("v.checked");
        
        //Data change occurs whenever we click the checkbox
        //if checkbox is mark --> checkBoxValue attribute is true
        //if checkbox is unchecked --> checkboxvalue attribute is false
        component.set("v.checkBoxValue",checkBoxValue);
        component.set("v.RegForm.udemyYogAnk__Available__c",checkBoxValue);       
	}
})