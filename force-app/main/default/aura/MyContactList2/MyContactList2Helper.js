({
	//function to fetch data from server called in initial loading of Page
    fetchContacts : function(component, event, helper) {
		console.log('fetchContacts method starts executing');
        //Assign server method to action variable
        var action = component.get("c.getContactList");
        //Getting the account id from page
        var accountId = component.get("v.recordId");
        //Setting parameters for server method
        action.setParams({
            accountIds : accountId
        });
        //Callback function to get the response
        action.setCallback(this, function(response){
        	//Getting Response State
        	var state = response.getState();
            //Check if response state is success
            if(state === 'SUCCESS'){
                //Getting the list of Contacts from response and storing in js variable
                var contactList = response.getReturnValue();
                //Set the List attribute in Component with the value returned by function
                component.set('v.contactList',contactList);
            }else{
                //Show an alert if state is incomplete or error
                alert('Error in getting data');
            }
        });
        $A.enqueueAction(action);
	},
    
    //Function to update contacts on server
    saveContacts : function(component, event, controller){
        console.log('saveContacts method started execution');
        //Getting contactList from lightning component
        var contactList = component.get("v.contactList");
        //Getting recordViewForm and recordEditForm component
        var recordViewForm = component.find('recordViewForm');
        var recordEditForm = component.find('recordEditForm');
        console.log('Bth views added successfully');
        //Initializing toast event to show toast
        var toastEvent = $A.get('e.force:showToast');
        //Defining the action to save contactList
        var saveAction = component.get("c.saveContactList");
        //Setting parameter to be passed to apex controller method
        saveAction.setParams({ contactList : contactList });
        saveAction.setCallback(this,function(response){
           //Getting State from response
           var state =  response.getState();
            if(state === 'SUCCESS'){
                //Getting the response from server
                var dataMap = response.getReturnValue();
                //Checking if the status is success
                if(dataMap.status == 'success'){
                    //Remove form hide class from recordViewForm
                    $A.util.removeClass(recordViewForm,'formHide');
                    //Add form hide class to recordEditForm
                    $A.util.addClass(recordEditForm,'formHide');
                    //Getting the button element
                    var btn = event.getSource();
                    //Setting Label and Name of button back to edit
                    btn.set('v.name','edit');
                    btn.set('v.label','Edit');
                    //Setting success toast which is dismissable(vanish on timeout or clicking close button)
                    toastEvent.setParams({
                        'title':'Success!',
                        'type':'success',
                        'mode':'dismissable',		//Toast will disappear either by user action or after sometime 
                        'message':dataMap.message	//Success message
                    });
                    //Fire success toast event (Show Toast)
                    toastEvent.fire();
                }else if(dataMap.status == 'error'){
                    toastEvent.setParams({
                        'title':'Error!',
                        'type':'error',
                        'mode':'dismissable',
                        'message':dataMap.message	//Error message
                    });
                    toastEvent.fire();
            	}
            }else{
                alert('Error in getting data')
            }
        });
     	$A.enqueueAction(saveAction);        
    }
})