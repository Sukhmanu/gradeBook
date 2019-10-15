package com.moodle.gradebook.service;

import com.moodle.gradebook.bean.Grade;
import com.moodle.gradebook.bean.Subject;
import com.moodle.gradebook.bean.User;
import com.moodle.gradebook.dao.GradeDao;
import com.moodle.gradebook.dao.SubjectDao;

import java.util.List;

public class GradeService {
    GradeDao gradeDao = new GradeDao();
    SubjectDao subjectDao = new SubjectDao();

    public List<Grade> getGrades(){
        return gradeDao.getGrades();
    }

    public List<User> getStudentsGrades(Subject subject){
        List<User> users = subjectDao.getStudentsWithMarks(subject);

        //calculate the grade of user
        for(User user : users){
            user.setGrade(getGrade(user.getPercentage()));
        }

        return users;
    }

    public List<Grade> getGradesWithCount(Subject sub){
        List<User> students = getStudentsGrades(sub);
        List<Grade> grades = getGrades();

        for (Grade grade : grades){
            for (User student : students)
                if(grade.getGradeCode().equals(student.getGrade())) {
                    int count = grade.getCount() + 1;
                    grade.setCount(count);
                }
        }

        return grades;
    }

    //this method will calculate the grade based on the passed percentage value and returns the grade code
    //if grade is not found then it will return's null value
    public String getGrade(float percentage){
        List<Grade> grades =  getGrades();

        for (Grade grade : grades){
            if(grade.getMinMark() <= percentage && grade.getMaxMark() >= percentage)
                return grade.getGradeCode();
        }
        System.out.println("ERROR: Grade not Found!!!");
        return null;
    }

    public List<Subject> getSubjectsWithMarks(User student){
        List<Subject> subjects = subjectDao.getSubjectsWithMarks(student);

        //calculate the grade of each subject
        for(Subject subject : subjects){
            subject.setGrade(getGrade(subject.getPercentage()));
        }

        return subjects;
    }
}
