package com.moodle.gradebook.bean;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

public class Subject {

    int id;
    String code;
    String title;
    String detail;
    String summary;
    List<User> students = new ArrayList<>();
    List<User> lecturers = new ArrayList<>();
    List<Assignment> assignments = new ArrayList<>();
    // temporary variable to store obtained total marks in a subject
    float obtainMarks;
    // temporary variable to store total Marks in a subject
    float totalMarks;
    // temporary variable to store obtain grade in a subject
    String grade;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail;
    }

    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }

    public List<User> getStudents() {
        return students;
    }

    public void setStudents(List<User> students) {
        this.students = students;
    }

    public void addStudent(User student) {
        this.students.add(student);
    }

    public List<User> getLecturers() {
        return lecturers;
    }

    public void setLecturers(List<User> lecturers) {
        this.lecturers = lecturers;
    }

    public void addLecturer(User lecturer) {
        this.lecturers.add(lecturer);
    }

    public List<Assignment> getAssignments() {
        return assignments;
    }

    public void setAssignments(List<Assignment> assignments) {
        this.assignments = assignments;
    }

    public float getObtainMarks() {
        return obtainMarks;
    }

    public void setObtainMarks(float obtainMarks) {
        this.obtainMarks = obtainMarks;
    }

    public float getTotalMarks() {
        return totalMarks;
    }

    public void setTotalMarks(float totalMarks) {
        this.totalMarks = totalMarks;
    }

    public String getGrade() {
        return grade;
    }

    public void setGrade(String grade) {
        this.grade = grade;
    }

    public float getPercentage(){
        //prevent divide by zero
        if(totalMarks == 0.0)
            return 0;

        return obtainMarks / totalMarks * 100;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Subject subject = (Subject) o;
        return id == subject.id;
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }
}
