package com.moodle.gradebook.servlet;

import com.moodle.gradebook.bean.Grade;
import com.moodle.gradebook.bean.Subject;
import com.moodle.gradebook.bean.User;
import com.moodle.gradebook.service.*;
import com.moodle.gradebook.util.ListUtil;
import com.moodle.gradebook.util.Param;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "ReportServlet", value = "/report")
public class ReportServlet extends HttpServlet {
    SubjectService subjectService = new SubjectService();
    SessionService sessionService = new SessionService();
    UserService userService = new UserService();
    GradeService gradeService = new GradeService();
    ReportService reportService = new ReportService();
    User currentUser = null;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        currentUser = sessionService.currentUser(request);
        Param param = new Param(request);
        List<Integer> lecturerIds = param.getIntegers("lecturers");
        int subjectId = param.getInt("subject_id");
        Subject subject = subjectService.getSubject(subjectId);

        List<User> lectures = new ArrayList<>();
        //fetch all lecturers from database
        for (Integer lecturerId : lecturerIds){
            User lecturer = userService.getUser(lecturerId);
            lectures.add(lecturer);
        }
        reportService.shareSubjectReport(subject, lectures);

        PrintWriter out = response.getWriter();
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        out.print("{status:updated}");
        out.flush();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        currentUser = sessionService.currentUser(request);
        String view = "barGraph.jsp";
        Param param = new Param(request);

        String type = param.getString("type");
        int shared = param.getInt("shared");
        request.setAttribute("shared", shared);

        if(User.STUDENT.equals(currentUser.getType()))
            type = "student";
        switch (type){
            case "subject":
                Subject subject = subjectService.getSubject(param.getInt("id"));
                List<User> students = gradeService.getStudentsGrades(subject);
                List<Grade> grades = gradeService.getGradesWithCount(subject);
                List<User> lecturers = userService.getUsers(User.LEACTURER);
                List<User> reportSharedWith =  reportService.reportSharedWith(subject);
                request.setAttribute("students", students);
                request.setAttribute("grades", grades);
                request.setAttribute("subject", subject);
                request.setAttribute("reportSharedWith", reportSharedWith);
                //can't share report to itself
                lecturers.remove(currentUser);
                request.setAttribute("lecturers", lecturers);
                view = "subjectReport.jsp";
                break;
            case "list":
                List<Subject> subjects = subjectService.getSubjectByUser(currentUser);
                List<Subject> sharedReports = reportService.sharedReports(currentUser);
                request.setAttribute("subjects", subjects);
                request.setAttribute("sharedReports", sharedReports);
                view = "list.jsp";
                break;
            case "student":
                User student = userService.getUser(param.getInt("id"));
                if(User.STUDENT.equals(currentUser.getType()))
                    student = currentUser;

                subjects = gradeService.getSubjectsWithMarks(student);
                request.setAttribute("subjects", subjects);
                request.setAttribute("student", student);
                view = "studentReport.jsp";

        }

        RequestDispatcher rd = request.getRequestDispatcher("views/report/" + view);
        rd.forward(request, response);
    }
}
