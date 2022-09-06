/**
 * @author Luis Gustavo Taborda - NTT DATA
 */
public class AccountCleaningInactiveSchedule implements Schedulable{

    private final String JOB_NAME = 'Limpeza de contas inativas';
    private AccountService accountService;

    public AccountCleaningInactiveSchedule() {
        accountService = new AccountService();
    }

    public void execute(SchedulableContext context) {
        System.debug('Job AccountCleaningInactive Execute');
        accountService.inactiveAccounts();
    }

    public void start() {
        abort();
        System.debug('Job AccountCleaningInactive init');
        System.schedule(JOB_NAME + ' - 00:00', '0 0 0 ? * MON-FRI	', new AccountCleaningInactiveSchedule());
        System.schedule(JOB_NAME + ' - 06:00', '0 0 6 ? * MON-FRI	', new AccountCleaningInactiveSchedule());
        System.schedule(JOB_NAME + ' - 12:00', '0 0 12 ? * MON-FRI	', new AccountCleaningInactiveSchedule());
        System.schedule(JOB_NAME + ' - 18:00', '0 0 18 ? * MON-FRI	', new AccountCleaningInactiveSchedule());


    }
    
    public void abort() {
        List<CronTrigger> job = [SELECT Id FROM CronTrigger WHERE CronJobDetail.Name LIKE :'%'+JOB_NAME+'%'];

        if (job.size() != 0) {
            for(Integer i = 0 ; i < job.size() ; i++){
                System.abortJob(job.get(i).Id);
            }
        }
    
    }
}