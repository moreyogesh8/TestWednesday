({
	dosave : function(component, event, helper) {
        console.log('CreateContact:: '+component.get('v.CreateContact'));
        console.log('account id::'+component.get('v.accountId'));
        var action = component.get('c.createContact');
        var contc = component.get('v.CreateContact');
        
        var validContact = component.find('contactForm').reduce(function(validSoFar, inputCmp){
            inputCmp.showHelpMessageIfInvalid();
            inputCmp.set('v.validity',{valid:false,badInput:true});
            return validSoFar && inputCmp.get('v.validity').valid;
        }, true);
        
        if(validContact){
            console.log('Input values are correct');
            action.setParams({
            AccountId : component.get('v.accountId'),
            con : component.get('v.CreateContact')
        	});
            console.log('All Set Debug');
            action.setCallback(this, function(response){
                console.log('All Set Debug 1');
                var state = response.getState();
                console.log('State :: '+state);
                if(state === 'SUCCESS'){
                    var responsevalue = response.getReturnValue();
                    //console.log('responsevalue 111:: ',responsevalue);
                    
                    //Component Event Code Starts Here
                    var componentEvent = component.getEvent('quickContact');
                    componentEvent.setParams({
                        ContactRecord : responsevalue    
                    });
                    componentEvent.fire();
                    //Component Event Code Ends Here
                    
                }else if(state === 'INCOMPLETE'){
                    
                }else if(state === 'ERROR'){
                    var errors = response.getError();   //Array of Error 
                    console.log('Error: ', errors[0].duplicateResults);
                    console.log('Error: ', errors[0].fieldErrors);
                    console.log('Error: ', errors[0].pageErrors[0].message);
                    /*component.set('v.errorMes',errors[0].pageErrors[0].message);*/
                    if(errors || errors[0].message){
                        
                    }
                }
            },'ALL');
            $A.enqueueAction(action);    
        }else{
            console.log('Please enter correct values');
        }        
    }
})