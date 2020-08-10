({
	handleChild : function(component, event, helper) {
		var params = event.getParam('arguments');
        if(params){
            var param1 = params.param1;
            console.log('Value of param1 --- '+param1);
            var param2 = params.param2;
            console.log("Value of param2---- "+param2);
            component.set("v.value1",param1);
            component.set("v.value2",param2);
        }
	}
})