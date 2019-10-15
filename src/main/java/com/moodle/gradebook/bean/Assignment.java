package com.moodle.gradebook.bean;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Objects;

public class Assignment {
    int id;
    String name;
    String description;
    Date dueDate;
    float passingGrade;
    float maxGrade;
    Subject subject;
    boolean hurdle;
    List<Submission> submissions = new ArrayList<>();

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getDueDate() {
        return dueDate;
    }

    public void setDueDate(Date dueDate) {
        this.dueDate = dueDate;
    }

    public float getPassingGrade() {
        return passingGrade;
    }

    public void setPassingGrade(float passingGrade) {
        this.passingGrade = passingGrade;
    }

    public float getMaxGrade() {
        return maxGrade;
    }

    public void setMaxGrade(float maxGrade) {
        this.maxGrade = maxGrade;
    }

    public boolean isHurdle() {
        return hurdle;
    }

    public void setHurdle(boolean hurdle) {
        this.hurdle = hurdle;
    }

    public Subject getSubject() {
        return subject;
    }

    public void setSubject(Subject subject) {
        this.subject = subject;
    }

    public List<Submission> getSubmissions() {
        return submissions;
    }

    public void setSubmissions(List<Submission> submissions) {
        this.submissions = submissions;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Assignment that = (Assignment) o;
        return id == that.id;
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }
}
