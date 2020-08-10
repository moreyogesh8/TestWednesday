({
	doOrder : function(component, event, helper) {
		console.log('Inside doOrder');	
        var pagereference = component.find("navservice");
        var navigatePage = {
             type : "standard__component",
            attributes : {
                componentName: "c:CreateBeerOrder" 
            },
            state : { 
                beerId: component.get('v.beerId')
            }
        };
        pagereference.navigate(navigatePage);
	},
})