public with sharing class CaseJqueryTableCnrlr {
 // A method that returns closed Case list
    public List<Case> getCaseList () {
        return [SELECT Id, CaseNumber, Status,
                            Priority, Account.Name,
                            Contact.Name
                        FROM Case
                        WHERE IsClosed = true];
    }
}