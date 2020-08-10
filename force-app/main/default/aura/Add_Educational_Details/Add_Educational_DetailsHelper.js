({
	helperRectifySequence : function(component,event) {
		var indexNo = component.get("v.indexNo");
        var New = parseInt(indexNo) +1;
        console.log("New Value - "+New);
        component.set("v.sequenceNo",New);
	}
})