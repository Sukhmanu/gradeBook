package com.moodle.gradebook.service;

import com.moodle.gradebook.bean.Subject;
import com.moodle.gradebook.bean.User;
import com.moodle.gradebook.dao.AssignmentDao;
import com.moodle.gradebook.dao.SubjectDao;

import java.util.List;

public class SubjectService {
    SubjectDao subjectDao = new SubjectDao();
    AssignmentDao assignmentDao = new AssignmentDao();

    public Subject save(Subject subject){
        return subjectDao.saveSubject(subject);
    }

    public List<Subject> getSubjects(){
        return subjectDao.getAllSubjects();
    }

    public List<Subject> getSubjectByUser(User lecturer){
        return subjectDao.getSubjectsByUser(lecturer);
    }

    public Subject getSubject(int id){
        Subject subject = subjectDao.getSubjectById(id);

        //fetch student and lecturer from database
        if(subject != null){
            List<User> users = subjectDao.getUsersBySubject(subject);
            for(User user: users){
                if(user.getType().equals(User.LEACTURER))
                    subject.addLecturer(user);
                else if(user.getType().equals(User.STUDENT))
                    subject.addStudent(user);
            }
            subject.setAssignments(assignmentDao.getAssignmentsBySubject(subject));
        }
        return subject;
    }

    public Subject updateSubject(Subject subject){
        SubjectService subjectService = new SubjectService();
        subject = subjectDao.updateSubject(subject);
        subjectService.addOrRemoveLecturers(subject);
        subjectService.addOrRemoveStudents(subject);

        return subject;
    }

    public boolean deleteSubject(int id){
        return  true;
    }

    public void addOrRemoveStudents(Subject subject){
        List<User> latestStudents = subject.getStudents();
        subjectDao.removeAllStudent(subject);

        for (User student : latestStudents){
            subjectDao.addUser(subject, student);
        }

    }

    public void addOrRemoveLecturers(Subject subject){
        List<User> latestLecturers = subject.getLecturers();
        subjectDao.removeAllLecturer(subject);

        for (User lecturer : latestLecturers){
            subjectDao.addUser(subject, lecturer);
        }
    }
}
