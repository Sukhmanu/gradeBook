package com.moodle.gradebook.service;

import com.moodle.gradebook.bean.Assignment;
import com.moodle.gradebook.bean.Subject;
import com.moodle.gradebook.dao.AssignmentDao;
import com.moodle.gradebook.dao.SubjectDao;

import java.util.List;

public class AssignmentService {
    AssignmentDao assignmentDao = new AssignmentDao();
    SubjectService subjectService = new SubjectService();

    public Assignment save(Assignment assignment){
        return assignmentDao.saveAssignment(assignment);
    }

    public List<Assignment> getAssignmentsBySubject(Subject subject){
        return assignmentDao.getAssignmentsBySubject(subject);
    }

    public  Assignment getAssignmentById(int id){
        Assignment assignment = assignmentDao.getAssignmentById(id);
        //fetch all values of subject from database
        Subject subject = subjectService.getSubject(assignment.getSubject().getId());
        assignment.setSubject(subject);
        return assignment;
    }

    public Assignment update(Assignment assignment){
        return assignmentDao.updateAssignment(assignment);
    }

    public void removeAnyHurdle(Subject subject){
        assignmentDao.removeAnyHurdle(subject);
    }

    public void addHurdle(Assignment assignment){
        // remove any hurdle from subjects assigment before adding it to new one
        // that will ensure that only one assignment will have a hurdle
        removeAnyHurdle(assignment.getSubject());
        // now add hurdle to an assignment
        assignmentDao.addHurdle(assignment);
    }
}
