({
	// Your renderer method overrides go here
    render : function(component,helper){
        //Call Base render method
        var a = this.superRender();
        //Custom Rendering
        console.log("This text is from render function which gets executed when component is initiated");
        return a;
        
    },
    
    afterRender : function(component,helper){
      	// call Base afterRender method
      	this.superAfterRender();
      	// interact with Dom Elements  
      	console.log("This text should come after render() is over");
        console.log("This text is from after render function");
    },
    
    rerender : function(component,helper){
      // call Base rerender method
      this.superRerender();
      // Custom rendering
      console.log("this text is from rerender function which gets called on data change");  
    },
    
    unrender : function(component,helper){
        // call Base Unrender Method
        this.superUnrender();
        // Custom Unrendering
       console.log("This text is appear when Registration Component is destroyed");
    }
})