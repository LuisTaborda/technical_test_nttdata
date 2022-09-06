public virtual class TaskRepository {

    virtual public List<Task> findByLast90DaysLinkedToAccount(Set<Id> accountsIds){
        List<Task> tasks = [SELECT Id FROM task WHERE WhatId IN :accountsIds AND (CreatedDate > :date.today().addDays(-90) AND CreatedDate < :date.today())];
        return tasks;
    }

}