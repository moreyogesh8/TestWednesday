<aura:application extends="force:slds">
	<p>
    	This text is from Country (Application Level).
    </p>	
    <p>
        <c:State1 />
    </p>
    
    <aura:handler name="HighPriorityComplaintFromTownship1" event="c:ComponentEventWithComplaintMsg" action="{!c.handlingHPComplaints}" phase="capture" />
    <!--<p>
        <c:State2 />
    </p> -->
</aura:application>