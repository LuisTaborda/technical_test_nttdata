public class AccountRepository {
    
    virtual public Map<Id, Account> findByInactive(){
        Map<Id, Account> accounts = new Map<Id, Account>([SELECT Id, Inactive__c FROM Account WHERE Inactive__c = false]);
        return accounts;
    }
}