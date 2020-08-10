({
	doCreateMap : function(component, event, helper) {
		console.log('Inside create Map');
    	var mapVar= [];
    	for(var i=0; i<10; i++){
            mapVar.push({
                key:i,
                value:'Test'+i
            });
		}	
        console.log('Map :: '+mapVar);
 		component.set("v.mapVar",mapVar);
	}
})