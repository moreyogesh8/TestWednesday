<aura:application >
	
	<!-- Aura Attributes -->
    <aura:attribute name="appContacts" type="Contact[]" />
    <aura:attribute name="showTable" type="boolean" />
    
    <aura:handler name="ContactSearchComplete" event="c:contactSearchCompleteEvent" action="{!c.handleSearchEvent}" />
    <!-- Search Component -->
    <c:contactSearch />
    
    <!-- Contact Table -->
    <aura:if isTrue="{!v.showTable}">
    	<div>
            <c:contactTable aura:id="contactList" contacts="{!v.appContacts}" />
        </div>	
    </aura:if>

</aura:application>