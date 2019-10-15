package com.moodle.gradebook.bean;

import java.util.Objects;

public class User {
    public static final String STUDENT = "student";
    public static final String LEACTURER = "lecturer";
    public static final String ADMIN = "admin";

    int id;
    int rollNo;
    String fName;
    String lName;
    String email;
    String password;
    String type;
    String city;
    String country;
    boolean active;
    // temporary variable used to store current submission temporary for an individual assigment
    Submission submission;
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

    public int getRollNo() {
        return rollNo;
    }

    public void setRollNo(int rollNo) {
        this.rollNo = rollNo;
    }

    public String getfName() {
        return fName;
    }

    public void setfName(String fName) {
        this.fName = fName;
    }

    public String getlName() {
        return lName;
    }

    public void setlName(String lName) {
        this.lName = lName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public boolean isLecturer(){
        return type.equals(LEACTURER);
    }

    public boolean isStudent(){
        return type.equals(STUDENT);
    }

    public Submission getSubmission() {
        return submission;
    }

    public void setSubmission(Submission submission) {
        this.submission = submission;
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
        User user = (User) o;
        return id == user.id;
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }
}
