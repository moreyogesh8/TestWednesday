({
	showinfo : function(component, event, helper) {
		
        var eventSource = event.getSource();
        //component.set('v.beerId',eventSource.get('v.name.Id'));
        console.log('Within Showinfo function'+JSON.stringify(eventSource.get('v.name')));
        $A.createComponent("c:BeerDetails",
                           {
                               "beerId" : eventSource.get('v.name.Id')
                           },function(beerDetails,status,errorMessage){
                               console.log('status666662 ----'+status);
                               if(status === "SUCCESS"){
                               		component.find('overlaycomp').showCustomModal({
                                    header: "Beer Details",
                                    body: beerDetails,
                                    footer: 'Footer Test',
                                    showCloseButton: true,
                                    closeCallback: function() {
                                        
                                    }    
                                 });		
                               }else if(status === "INCOMPLETE"){
                                   console.log('No Response from server');
                               }else if(status === "ERROR"){
                                   console.log('Error Message - '+errorMessage);
                               }
                           });  
	}
})