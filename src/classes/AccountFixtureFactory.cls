/**
 * @author Luis Gustavo Taborda - NTT DATA
 */
@isTest
public class AccountFixtureFactory {

    static Map<String, RecordTypeInfo> recordTypes = SObjectType.Account.getRecordTypeInfosByDeveloperName();

    public static Account newAccountPartner(){

        return new Account(
            Name = 'Account Test',
            AccountNumber = '01234567899',
            Type = 'CPF',
            recordTypeId = recordTypes.get('Partner').getRecordTypeId()
        );
    }

    public static Account createAccountPartner(){
        Account account = newAccountPartner();
        insert account;
        return account;
    }

    public static Account newAccountInvalidAccountNumber(){

        return new Account(
            Name = 'Account Test',
            AccountNumber = '012345678999',
            Type = 'CPF',
            recordTypeId = recordTypes.get('Partner').getRecordTypeId()
        );
    }

    public static Account createAccountInvalidAccountNumber(){
        Account account = newAccountInvalidAccountNumber();
        insert account;
        return account;
    }

    public static Account newAccountFinalCostumer(){

        return new Account(
            Name = 'Account Test',
            AccountNumber = '01234567899',
            Type = 'CPF',
            recordTypeId = recordTypes.get('FinalCostumer').getRecordTypeId()
        );
    }

    public static Account createAccountFinalCostumer(){
        Account account = newAccountFinalCostumer();
        insert account;
        return account;
    }

    public static Account newAccount(){
        return new Account(
            Name = 'Account Test'
        );
    }

    public static Account createAccount(){
        Account account = newAccount();
        insert account;
        return account;
    }
}