({
    doInit : function(component, event, helper){
        //console.log("This text is from init method defined in child component111111");
        //component.set("v.InstituteName","CSIBER");
        //component.set("v.CourseName","MS");
        //component.set("v.DurationOfCourse","2");
        helper.helperRectifySequence(component,event);
    },
    
    deleteDetails : function(component, event, helper) {
		//console.log("In deleteDetails function");	
        var NewEducationDetailsList = component.get("v.EducationalDetailListInnerComponent");
        var currentIndex = component.get("v.indexNo");
        if(currentIndex > -1)
            NewEducationDetailsList.splice(currentIndex,1);
        component.set("v.EducationalDetailListInnerComponent",NewEducationDetailsList);
	},
    
    saveEduDetails : function(component, event, helper){
   		console.log('Logg enabled in saveEduDetails functions');
        //CAll Apex Class Function with name saveEducationDetails
        var RegistrationRecordId = component.get("v.RegistrationRecordId");
        console.log("RegistrationRecordId"+RegistrationRecordId);
        var EduDetails = component.get("v.EduDetails");
        console.log("2"+EduDetails);
        component.set("v.EduDetails.udemyYogAnk__Registration_Form__c",RegistrationRecordId);
        console.log("1"+EduDetails.udemyYogAnk__Registration_Form__c);
        /*console.log("1"+EduDetails.Name);
        console.log("1"+EduDetails.Course_Name__c);
        console.log("1"+EduDetails.Course_Duration__c);
        console.log("1"+EduDetails.Overall_Score__c);*/
        
        var action = component.get("c.saveEducationDetails");
        action.setParams({EduDet : EduDetails});
        action.setCallback(this, function(response){
            console.log("Welcome to callback function");
            var state = response.getState();
            console.log(state);
            if(state === "SUCCESS"){
                //alert the user with the value returned from the server
                alert("From Server: "+ response.getReturnValue());
                var parentId = response.getReturnValue();
                //component.set("v.RegistrationRecordId",parentId);
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
    
    changeInIndexNo : function(component,event,helper){
        console.log("Test");
        helper.helperRectifySequence(component,event);
    }
})