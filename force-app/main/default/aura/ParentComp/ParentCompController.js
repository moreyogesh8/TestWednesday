({
	doClick : function(component, event, helper) {
		var childComp = component.find('ChildComponent');
        childComp.child('Invoking Child COmponent Method From Parent','Second Parameter');
	},
    doHandle : function(component, event, helper){
        console.log('Inside PArent - directly calling parent controller method fromchild');
    }
})