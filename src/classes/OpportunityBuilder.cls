/**
 * @author Luis Gustavo Taborda - NTT DATA
 */
public class OpportunityBuilder {
    
    private Opportunity opp;

    public OpportunityBuilder(){
        this.opp = new Opportunity();
    }

    public Opportunity build(){
        return this.opp;
    }

    public OpportunityBuilder withName (String name){
        this.opp.Name = name;
        return this;
    }

    public OpportunityBuilder withCloseDate (Date closeDate){
        this.opp.CloseDate = closeDate;
        return this;
    }

    public OpportunityBuilder withStageName (String stageName){
        this.opp.StageName = stageName;
        return this;
    }

    public OpportunityBuilder withAccountId (String accountId){
        this.opp.AccountId = accountId;
        return this;
    }
    
}