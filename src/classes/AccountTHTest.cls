/**
 * @author Luis Gustavo Taborda - NTT DATA
 */
@isTest
public with sharing class AccountTHTest {

    @isTest
    public static void givenAccountPartnerValidWhenInsertRecordThenAOpportunityIsCreatedToo(){
        Account account = AccountFixtureFactory.createAccountPartner();

        Test.startTest();

        Opportunity opp = [SELECT Id, Name, StageName, CloseDate FROM Opportunity WHERE Name = :account.Name + ' - opp Parceiro' limit 1];

        Test.stopTest();

        System.assert(opp.id != null, 'no opportunity returned');
        System.assertEquals(account.Name + ' - opp Parceiro', opp.Name, 'name opportunity not expected');
        System.assertEquals('Qualification', opp.StageName, 'stage name value not expected');
        System.assertEquals(date.today().addDays(30), opp.CloseDate, 'date not expected');
    }

    @isTest
    public static void givenAccountNumberInvalidWhenInsertRecordThenReturnException(){
        try{
            Test.startTest();
            Account account = AccountFixtureFactory.createAccountInvalidAccountNumber();
            Test.stopTest();
        }
        catch(Exception ex){
            System.assert(ex.getMessage().contains('Número do cliente é inválido'));
        }

    }
    
    @isTest
    public static void givenAccountWithoutAccountNumberdWhenInsertRecordThenReturnException(){
        try{
            Test.startTest();
            Account account = AccountFixtureFactory.createAccount();
            Test.stopTest();
        }
        catch(Exception ex){
            System.assert(ex.getMessage().contains('Necessário inserir número do cliente'));
        }

    }

    @isTest
    public static void givenAccountFinalCostumerWhenInsertRecordThenATaskIsCreatedToo(){
        Account account = AccountFixtureFactory.createAccountFinalCostumer();

        Test.startTest();

        Task task = [SELECT Id, Subject, WhatId, Status, Priority FROM Task limit 1];

        Test.stopTest();

        System.assert(task.id != null, 'Id is null');
        System.assertEquals('Consumidor Final',task.Subject, 'subject not expected');
        System.assertEquals('Not Started', task.Status, 'stage name value not expected');
        System.assertEquals('Normal', task.Priority, 'priority value not expected');
    }

    @isTest
    public static void givenAccountPartnerValidWhenUpdateRecordThenAOpportunityIsCreatedToo(){
        Account account = AccountFixtureFactory.createAccountPartner();
        account.Name = 'Test Update';
        update account;
        
        Test.startTest();

        Opportunity opp = [SELECT Id, Name, StageName, CloseDate FROM Opportunity WHERE Name = :account.Name + ' - opp Parceiro' limit 1];

        Test.stopTest();

        System.assert(opp.id != null, 'no opportunity returned');
        System.assertEquals(account.Name + ' - opp Parceiro', opp.Name, 'name opportunity not expected');
        System.assertEquals('Qualification', opp.StageName, 'stage name value not expected');
        System.assertEquals(date.today().addDays(30), opp.CloseDate, 'date not expected');
    }

    @isTest
    public static void givenLotAccountsWhenInsertThenReturningSuccess(){
        boolean success = true;
        try{
            List<Account> accounts = new List<Account>();
            for(Integer i = 0 ; i < 1000 ; i++){
                accounts.add(AccountFixtureFactory.newAccount());
            }
            Test.startTest();
            AccountFixtureFactory.createAccounts(accounts);
            Test.stopTest();
        }
        catch (Exception ex){
            success = false;
        }
        System.assert(success);
    }
}