({
	compEvet : function(component, event, helper) {
		console.log('Within compEvent');	
        var searchtext = component.find("SearchInput");
        var actualText = searchtext.get("v.value");
        var componentEvent = component.getEvent('beerSearchEvent'); 
        componentEvent.setParams({
            searchText : actualText
        });
        componentEvent.fire();
        console.log('Event Fire');
	},
})