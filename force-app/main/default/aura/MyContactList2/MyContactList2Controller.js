({
	getContactsList : function(component, event, helper) {
		console.log('getContactsList method execution started');
        //Helper function - fetchContacts called for interaction with server
        helper.fetchContacts(component, event, helper);
	},
    
    //Function used to create new Contact
    newContact : function(component, event, helper){
        console.log('newContact method execution started');
        //Global event force:createRecord is used
        var createContact = $A.get("e.force:createRecord");
        //Parameters like Api name and default value are set
        createContact.setParams({
            "entityApiName":"Contact",
            "defaultFieldValues":{
                "AccountId":component.get("v.recordId")
            }
        });
        //Event fired and new Contact dialog open
        createContact.fire();
    },
    
    //Function used to update the Contact
    editContacts : function(component, event, helper){
        console.log("editContacts method execution started");
        //Getting the button element
        var btn = event.getSource();
        console.log('1');
        //Getting the value in name attribute
        var name = btn.get('v.name');
        console.log('1');
        //Getting the recordViewForm and recordEditForm elements
        var recordViewForm = component.find('recordViewForm');
        var recordEditForm = component.find('recordEditForm');
        console.log('recordViewForm and recordEditForm added');
        //If button is edit
        if(name=='edit'){
            console.log('Record editing process started');
            //Hiding the recordViewForm and making recordEditForm visible
            $A.util.addClass(recordViewForm,'formHide');
            $A.util.removeClass(recordEditForm,'formHide');
            //Changing Button name and label
            btn.set('v.name','save');
            btn.set('v.label','Save');
            console.log('Record editing process ended');
        }else if(name=='save'){
            console.log('Record Saving Process Started')
            //Calling save contacts if button is save
            helper.saveContacts(component,event,helper);
        }
    }
})