/**
 * @author Luis Gustavo Taborda - NTT DATA
 */
public with sharing class AccountService {

    private Id partnerRecordTypeId;
    private Id finalCostumerRecordTypeId;

    public AccountService(){
        partnerRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Parceiro').getRecordTypeId();
        finalCostumerRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Consumidor Final').getRecordTypeId();
    }

    public boolean isPartner(String recordTypeId){
        return partnerRecordTypeId.equals(recordTypeId);
    }
    
    public boolean isFinalCostumer(String recordTypeId){
        return finalCostumerRecordTypeId.equals(recordTypeId);
    }
}