trigger ControlQuotes on Opportunity (before delete) {
    System.debug('Testing'+Trigger.oldMap.keySet());
    For(Quote q : [Select Opportunity.Name From Quote
                   Where Opportunity.Id IN : Trigger.oldMap.keySet()]){
                       System.debug(q.Opportunity.Name);
                       Trigger.oldMap.get(q.Opportunity.Id).addError('Can not delete opportunity with a quote');
                   }
}