({
	doAdd : function(component, event, helper) {
		//console.log('Inside doAdd');
        var num1 = component.get("v.input1");
        var num2 = component.get("v.input2");
        console.log(parseInt(num1)+parseInt(num2));
        component.set("v.result",parseInt(num1)+parseInt(num2));
	},
    doSubstract : function(component, event, helper){
        //console.log('Inside doSubstract');
        var num1 = component.get("v.input1");
        var num2 = component.get("v.input2");
        console.log(parseInt(num1)-parseInt(num2));
        //var result = parseInt(num1)-parseInt(num2);
        component.set("v.result",parseInt(num1)-parseInt(num2));
    },
    domultiply : function(component, event, helper){
        //console.log('Inside domultiply');
        var num1 = component.get("v.input1");
        var num2 = component.get("v.input2");
        console.log(parseInt(num1)*parseInt(num2));
        component.set("v.result",parseInt(num1)*parseInt(num2));
    },
    doDivide : function(component, event, helper){
        //console.log('Inside doDivide');
        var num1 = component.get("v.input1");
        var num2 = component.get("v.input2");
        console.log(parseInt(num1)/parseInt(num2));
        component.set("v.result",parseInt(num1)/parseInt(num2));
    }
})