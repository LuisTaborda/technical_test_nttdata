public class OpportunityRepository {

    virtual public List<Opportunity> findByWonLast120DaysLinkedToAccount(Set<Id> accountsIds){
        List<Opportunity> opportunities = [SELECT Id, AccountId FROM Opportunity WHERE AccountId IN :accountsIds AND ( CreatedDate > :date.today().addDays(-120) AND CreatedDate < :date.today() ) AND StageName = :'Closed Won'];
        return opportunities;
    }

    virtual public List<Opportunity> findByNegotiationLinkedToAccount(Set<Id> accountsIds){
        List<Opportunity> opportunities = [SELECT Id, AccountId FROM Opportunity WHERE AccountId IN :accountsIds AND StageName = :'Negotiation/Review'];
        return opportunities;
    }

}