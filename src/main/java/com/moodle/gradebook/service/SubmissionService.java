package com.moodle.gradebook.service;

import com.moodle.gradebook.bean.Assignment;
import com.moodle.gradebook.bean.Submission;
import com.moodle.gradebook.bean.User;
import com.moodle.gradebook.dao.SubmissionDao;

public class SubmissionService {
    SubmissionDao submissionDao = new SubmissionDao();
    public Submission save(Submission submission){
        return submissionDao.saveSubmission(submission);
    }

    public Submission getSubmission(Assignment assignment, User student){
        return submissionDao.getSubmissionByAssignmentAndStudent(assignment, student);
    }

    public Submission update(Submission submission){
        return submissionDao.updateSubmission(submission);
    }
}
