package com.moodle.gradebook.bean;

import java.util.ArrayList;
import java.util.List;

public class Report {
    Subject subject;
    List<User> lecturers = new ArrayList<>();

    public Subject getSubject() {
        return subject;
    }

    public void setSubject(Subject subject) {
        this.subject = subject;
    }

    public List<User> getLecturers() {
        return lecturers;
    }

    public void setLecturers(List<User> lecturers) {
        this.lecturers = lecturers;
    }
}
