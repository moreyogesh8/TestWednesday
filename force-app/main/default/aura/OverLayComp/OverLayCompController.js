({
	showModal : function(component, event, helper) {
		console.log('Inside ShowModal');	
        component.find('overlaycomp').showCustomModal({
            header: "Application Confirmation",
            body: 'This is Test',
            footer: 'Footer Test',
            showCloseButton: true,
            closeCallback: function() {
            	alert('You closed the alert!');
            }    
         });
	},
    donavigate : function(component, event, helper){
    	console.log('Inside donavigate');    
        var pagereference = component.find('navservice');
        var navigatePage = {
             type: "standard__component",
            attributes: {
                componentName: "c:BeerExplorer" 
            },
            state: { 
                "c__myAttr": "foo" 
            }
        };
        pagereference.navigate(navigatePage);
    },
    handleLoad : function(component, event, helper){
    	console.log('Inside handleload');        
    },
    handleSubmit : function(component, event, helper){
        console.log('Inside handlesubmit');   
        event.preventDefault();
        const fields = event.getParam('fields');
        fields.LastName = 'My Custom Last Name';
        component.find('myRecordForm').submit(fields);
    },
    handleSuccess : function(component, event, helper){
        console.log('Inside handlesuccess');    
    },
    doShow : function(component, event, helper){
        console.log('Inside doshow');
    	$A.createComponent("lightning:button",
                           {
                               "value" : "Press Me",
                               "label" : "Press Me",
                               "onclick" : component.getReference("c.handleSubmit")
                           },function(newbutton,status,errorMessage){
                               console.log('status666662 ----'+status);
                               if(status === "SUCCESS"){
                               		var body = component.get('v.body');
                                   	body.push(newbutton);
                                   	component.set("v.body",body);
                               }else if(status === "INCOMPLETE"){
                                   console.log('No Response from server');
                               }else if(status === "ERROR"){
                                   console.log('Error Message - '+errorMessage);
                               }
                           });    
    },
})