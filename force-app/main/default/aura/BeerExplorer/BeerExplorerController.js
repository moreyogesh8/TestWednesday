({
	handleBeerSearchEvent : function(component, event, helper) {
        var searchText = event.getParam('searchText');
        console.log('searchText :: '+searchText);	
        var action = component.get('c.searchBeer');
        action.setParams({
            searchText : searchText   
        });
        action.setCallback(this,function(response){
        	var state = response.getState();
            if(state === 'SUCCESS'){
                var responseValue = response.getReturnValue();
                console.log('Return Value',responseValue);
                component.set('v.beerlist',responseValue);
            }
        });
        $A.enqueueAction(action);
	},
})