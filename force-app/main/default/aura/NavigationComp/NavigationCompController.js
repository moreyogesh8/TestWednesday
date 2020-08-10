({
	doinit : function(component, event, helper) {
        console.log('Execution begins for doinit function !!!!'); 
		var navService = component.find("navService");
        var pageReference = {
            type:'standard__objectPage',
            attributes:{
                objectApiName: 'Account',
                actionName: 'list'
            },
            state:{
                filterName: "00B7F0000029cTJUAY"
            }
        };
        component.set('v.pageReference',pageReference);
        //Set the URL on link or use the deafult if there's an error
        var defaultUrl="#";
        navService.generateUrl(pageReference)
        .then($A.getCallback(function(url){
            component.set("v.url", url ? url : defaultUrl);            
        }),$A.getCallback(function(error){
            component.set("v.url",defaultUrl);
        }));
        console.log('Execution ends for doinit function'); 
	},
    handleClick : function(component, event, helper) {
    	console.log('Execution begins for handleClick function');    
        var navService = component.find("navService");
        var pageReference = component.get("v.pageReference");
        event.preventDefault();
        navService.navigate(pageReference);
    },        
})