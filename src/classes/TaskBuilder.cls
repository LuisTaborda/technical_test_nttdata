/**
 * @author Luis Gustavo Taborda - NTT DATA
 */
public class TaskBuilder {
    private Task task;

    public TaskBuilder(){
        this.task = new Task();
    }

    public Task build(){
        return this.task;
    }

    public TaskBuilder withSubject(String subject){
        this.task.subject = subject;
        return this;
    }

    public TaskBuilder withWhatId(Id whatId){
        this.task.WhatId = whatId;
        return this;
    }

    public TaskBuilder withStatus(String status){
        this.task.Status = status;
        return this;
    }

    public TaskBuilder withPriority(String priority){
        this.task.Priority = priority;
        return this;
    }
}