trigger AccountTrigger on account (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    new AccountTH().run();
}