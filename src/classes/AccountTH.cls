/**
 * @author Luis Gustavo Taborda - NTT DATA
 */
public without sharing class AccountTH extends TriggerHandler{
    
    private List<Account> newAccounts;
	private Map<Id, Account> oldAccounts;
    private AccountService accountService;

    public AccountTH() {
        this((List<Account>) Trigger.new, (Map<Id, Account>) Trigger.oldMap);
  	}

	public AccountTH(List<Account> newAccounts, Map<Id, Account> oldAccounts) {
		this.newAccounts = newAccounts;
		this.oldAccounts = oldAccounts;
		this.accountService = new AccountService();
	}

    override
	public void beforeInsert() {
        validadeAccountNumber();
        createOppForPartner();
        createOppForFinalCostumer();
	}
    
	override
	public void beforeUpdate() {
        validadeAccountNumber();
        createOppForPartner();
        createOppForFinalCostumer();
	}

    private void validadeAccountNumber(){
        for (Account account : newAccounts) {

            if(account.accountNumber == null){
                throw new DmlException('Necessário inserir número do cliente');
            }

            if(!Utils.validateDocument(account.accountNumber)){
                throw new DmlException('Número do cliente é inválido');
            }
        }
    }

    private void createOppForPartner(){
        for (Account account : newAccounts) {
            Boolean isPartner = accountService.isPartner(account.recordTypeId);
            if(isPartner){
                Opportunity opp = new OpportunityBuilder()
                                .withName(account.Name + ' - opp Parceiro')
                                .withStageName('Qualification')
                                .withCloseDate(date.today().addDays(30))
                                .build();
                insert opp;
            } 
        }
    }
    
    private void createOppForFinalCostumer(){
        for (Account account : newAccounts) {
            Boolean isFinalCostumer = accountService.isFinalCostumer(account.recordTypeId);
            if(isFinalCostumer){
                Task task = new TaskBuilder()
                            .withSubject('Consumidor Final')
                            .withWhatId(account.Id)
                            .withStatus('Not Started')
                            .withPriority('Normal')
                            .build();
                insert task;
            } 
        }
    }
}