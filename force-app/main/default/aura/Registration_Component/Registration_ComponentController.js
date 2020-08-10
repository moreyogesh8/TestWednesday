({
	doSubmit : function(component, event, helper) {
		/*accessing value in attribute abc from component
        var initialABCValue = component.get("v.abc");
        if(initialABCValue == "true"){
            alert("value is true");
            //setting value of abc to flase
            component.set("v.abc","false");
        }
        else{
            alert("value is false");
            //setting value of abc to true
            component.set("v.abc","true");
        }*/
        //Call Apex function SaveRegistrationDetails to save data in Registration Form
        // Also we have to pass regForm as parameter
        var RegForm = component.get("v.RegForm");
        //console.log('RegForm -----> '+JSON.stringify(RegForm));
        //Create a one time use instance of the SaveRegistrationDetails action in the server-side Controller
        console.log("1");
        var action = component.get("c.saveRegistrationDetails");
        action.setParams({regForm : RegForm});
        
        console.log("2");
        //Create a callback that is executed after the server-side action returns
        action.setCallback(this, function(response){
            console.log("Welcome to callback function");
            var state = response.getState();
            console.log(state);
            if(state === "SUCCESS"){
                //alert the user with the value returned from the server
                //alert("From Server: "+ response.getReturnValue());
                component.set("v.isDataSubmitted",true);
                var parentId = response.getReturnValue();
                component.set("v.RegistrationRecordId",parentId);
                //Store/Save educational detail records as well
                //Somehow saveEduDetails method in ADD_Educational_Detail component
                
                
            }else if(state === "ERROR"){
                var errors = response.getError();
                if(errors){
                    if(errors[0] && errors[0].message){
                        console.log("Error message: "+errors[0].message);
                    }
                }else{
                    console.log("Unknown Error");
                }
            }
            
        });
        // $A.enqueueAction adds the server-side action to the queue and It is asynchronus call
        		$A.enqueueAction(action);
                console.log("CAll executed");
    },
    
    onClickCheckBox: function(component,event,helper){
        //Body of the function
        //called function defined in helper
        //helper.<functionNameInHelper>
        //console.log("This text is from controller resource");
        helper.onClickCheckBoxhelper1(component,event);
        
    },
    addDetails: function(component,event,helper){
        console.log("within add details function");
        var CurrentEducationDetailsList = component.get("v.EducationDetailsList");
        var currentSize = parseInt((CurrentEducationDetailsList.length));
        console.log(currentSize);
        var newSize = parseInt((currentSize)+1);
        CurrentEducationDetailsList.push(newSize);
        component.set("v.EducationDetailsList",CurrentEducationDetailsList);
    }
})