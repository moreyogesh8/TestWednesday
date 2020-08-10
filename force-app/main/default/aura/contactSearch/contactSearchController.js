({
	doSearch : function(component, event, helper) {
        console.log("within doSearch function");
		//make a server side call to fetch list of contacts
		var action=component.get("c.getContactList");
        action.setParams({ searchTerm : component.get("v.searchTerm")});
        console.log("Search Term Value"+component.get("v.searchTerm"));
        
        action.setCallback(this, function(response){
        	var state = response.getState();
            if(state === "SUCCESS"){
                var contacts = response.getReturnValue();
                
                //STep1
                var searchCompleteEvent = component.getEvent("ContactSearchComplete");
                console.log('Step1 executed');
                //Step2
                searchCompleteEvent.setParams({ contacts : contacts});
                console.log('Step2 executed');
                //Step3
                searchCompleteEvent.fire();
                console.log('Step3 executed');
            }
        });
        $A.enqueueAction(action);
        console.log('Server Call Completed');
	}
})