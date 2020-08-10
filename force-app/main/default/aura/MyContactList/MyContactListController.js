({
	myAction : function(component, event, helper) {
		console.log('myAction function is called');
        //For Seeting Columns in the grid display
        component.set("v.Columns",[
            {label:"First Name", fieldName:"FirstName", type:"text"},
            {label:"Last Name", fieldName:"LastName", type:"text"},
            {label:"Email", fieldName:"Email", type:"email"},
            {label:"Phone", fieldName:"Phone", type:"phone"}
        ]);
        
        //Action is reference to the getContacts() function
        var action = component.get("c.getContacts");
        
        //Set the paramenters to be passed to getContacts
        action.setParams({
            recordId : component.get("v.recordId")  
        });
        
        //CallBack Function
        //getReturnValue() will return list of contacts retrieved, assigns this to v.Contacts list
        action.setCallback(this,function(data){
            component.set("v.Contacts", data.getReturnValue());
        });
        
        $A.enqueueAction(action);
	},
    newContact : function(Component, Event, Helper){
        console.log('NewContact function started');
        //Assign global-event e.force:createRecord to create Contact Record
        //Here $A is used to refrence the global-event e.force:createRecord
        var createContact = $A.get("e.force:createRecord");
        //Set the Parameters to createContact Variable
        //entityApiName points to the object for which we need to create Record
        //defaultFieldValues is used to assign default values for AccountId Field
        //Here we are assigning AccountId to v.recordId for referencing current account
        createContact.setParams({
            'entityApiName':'Contact',
            'defaultFieldValues' : {
                'AccountId': Component.get("v.recordId")
            }
        });
        //Fire the event which will make sure the new Contact dialogue box should be displayed
        createContact.fire();
    }
})