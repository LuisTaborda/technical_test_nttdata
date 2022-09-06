/**
 * @author Luis Gustavo Taborda - NTT DATA
 */
public with sharing class AccountService {

    private Id partnerRecordTypeId;
    private Id finalCostumerRecordTypeId;
    private TaskRepository taskRepository;
    private OpportunityRepository opportunityRepository;
    private AccountRepository accountRepository;

    public AccountService(){
        partnerRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Parceiro').getRecordTypeId();
        finalCostumerRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Consumidor Final').getRecordTypeId();
        taskRepository = new TaskRepository();
        opportunityRepository = new OpportunityRepository();
        accountRepository = new AccountRepository();
    }

    public boolean isPartner(String recordTypeId){
        return partnerRecordTypeId.equals(recordTypeId);
    }
    
    public boolean isFinalCostumer(String recordTypeId){
        return finalCostumerRecordTypeId.equals(recordTypeId);
    }

    public void inactiveAccounts(){

        Map<Id, Account> accounts = accountRepository.findByInactive();
        
        keepAccountsByTasksLast90Days(accounts);
        keepAccountsByOpportunitiesNegotiation(accounts);
        keepAccountsByOpportunitiesWonLast120Days(accounts);
        
        for(Account account : accounts.values()){
            account.inactive__c = true;
        }
        
        update accounts.values();
    }

    private void keepAccountsByTasksLast90Days(Map<Id, Account> accounts){

        for(Task task : taskRepository.findByLast90DaysLinkedToAccount(accounts.keySet())){
            accounts.remove(task.whatId);
        }

    }

    private void keepAccountsByOpportunitiesWonLast120Days(Map<Id, Account> accounts){

        for(Opportunity opportinity : opportunityRepository.findByWonLast120DaysLinkedToAccount(accounts.keySet())){
            accounts.remove(opportinity.accountId);
        }

    }
   
    private void keepAccountsByOpportunitiesNegotiation(Map<Id, Account> accounts){

        for(Opportunity opportinity : opportunityRepository.findByNegotiationLinkedToAccount(accounts.keySet())){
            accounts.remove(opportinity.accountId);
        }

    }
}