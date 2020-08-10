({
	handleSearchEvent : function(component, event, helper) {
		console.log("Inside handle search event");
        var contactList = event.getParam("contacts");
        console.log('Contact List -> '+contactList);
        component.set("v.appContacts",contactList);
        console.log('test------'+component.get("v.appContacts"));
        component.set("v.showTable",true);
	}
})