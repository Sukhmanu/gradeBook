package com.moodle.gradebook.service;

import com.moodle.gradebook.bean.Subject;
import com.moodle.gradebook.bean.User;
import com.moodle.gradebook.dao.ReportDao;

import java.util.List;

public class ReportService {
    ReportDao reportDao = new ReportDao();

    public void shareSubjectReport(Subject subject, User lecturer){
        reportDao.shareSubjectReport(subject, lecturer);
    }

    public void shareSubjectReport(Subject subject, List<User> lecturers){
        //first delete all shared report for a subject
        deleteSharedReport(subject);
        //then share report with the given users
        for(User lecturer : lecturers) {
            shareSubjectReport(subject, lecturer);
        }
    }

    public void deleteSharedReport(Subject subject){
        reportDao.deleteSharedReport(subject);
    }

    public List<User> reportSharedWith(Subject subject){
        return reportDao.reportSharedWith(subject);
    }

    public List<Subject> sharedReports(User user){
        return reportDao.sharedReports(user);
    }
}
