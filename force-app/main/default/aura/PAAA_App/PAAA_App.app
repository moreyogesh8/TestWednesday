<aura:application extends="force:slds">
   <!-- <div>
    	<p>
        	This text is from application level markup.
        </p>
    </div>
	 Call the components 	
    <c:Welcome_to_Lightning />
    <c:Welcome_to_Lightning displayText="Text2" />
    <c:Welcome_to_Lightning displayText="Text3" />
    <c:Welcome_to_Lightning displayText="Text4" />-->
    <!-- <aura:attribute name="OpenRegistrationForm" type="Boolean" default="false" />
    <aura:attribute name="ButtonLabel" type="String" default="Open Registartion Form" />
    
    <lightning:button label="{!v.ButtonLabel}" onclick="{!c.openOrcloseRegistartionForm}"/>
    <aura:if isTrue="{!v.OpenRegistrationForm}">
    	<c:Registration_Component />
    </aura:if> 
	 <c:Add_Educational_Details /> --> 
     <c:Registration_Component /> 
    
</aura:application>