package com.moodle.gradebook.servlet;

import com.moodle.gradebook.bean.Assignment;
import com.moodle.gradebook.bean.Subject;
import com.moodle.gradebook.bean.Submission;
import com.moodle.gradebook.bean.User;
import com.moodle.gradebook.service.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet(name = "AssignmentServlet", value = "/assignment")
public class AssignmentServlet extends HttpServlet {
    SubjectService subjectService = new SubjectService();
    AssignmentService assignmentService = new AssignmentService();
    SubmissionService submissionService = new SubmissionService();
    SessionService sessionService = new SessionService();
    User currentUser = null;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        currentUser = sessionService.currentUser(request);
        String action = request.getParameter("action");
        String name = request.getParameter("name");
        String desc = request.getParameter("desc");
        Double maxGrade = Double.parseDouble(request.getParameter("maxGrade"));
        Double passingGrade = Double.valueOf(request.getParameter("passingGrade"));

        String dueDateStr = request.getParameter("due");
        SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
        Date dueDate = null;
        try {
            dueDate = sdf.parse(dueDateStr);
        } catch (ParseException e) {
            e.printStackTrace();
        }

        Assignment assignment = new Assignment();
        assignment.setName(name);
        assignment.setDescription(desc);
        assignment.setMaxGrade(maxGrade.intValue());
        assignment.setPassingGrade(passingGrade.intValue());
        assignment.setDueDate(dueDate);

        int subjectId = Integer.valueOf(request.getParameter("subjectId"));
        Subject subject = subjectService.getSubject(subjectId);
        assignment.setSubject(subject);

        if("create".equalsIgnoreCase(action)) {
            assignment = assignmentService.save(assignment);
        } else {
            int id = Integer.valueOf(request.getParameter("subjectId"));
            assignment.setId(id);
            assignment = assignmentService.update(assignment);

        }

        request.setAttribute("assignment", assignment);
        RequestDispatcher rd = request.getRequestDispatcher("views/assignment/show.jsp");
        rd.forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        currentUser = sessionService.currentUser(request);
        String view = "show.jsp";
        String action = request.getParameter("action");

        switch (action) {
            case "create":
                int id = Integer.valueOf(request.getParameter("subjectId"));
                Subject subject = subjectService.getSubject(id);
                request.setAttribute("subject", subject);
                view = "create.jsp";
                break;
            case "show":
                id = Integer.valueOf(request.getParameter("id"));
                Assignment assignment = assignmentService.getAssignmentById(id);
                List<User> students = assignment.getSubject().getStudents();
                //iterate over the list of student and fetch individual students submission
                for (User student : students) {
                    Submission submission = submissionService.getSubmission(assignment, student);
                    //if submission is not found then create a empty submission object,
                    // otherwise it will jsp page will throw and error while checking for the submission
                    if(submission == null)
                        submission = new Submission();
                    //add the submission to the student object
                    student.setSubmission(submission);
                }
                request.setAttribute("assignment", assignment);
                request.setAttribute("students", students);
                view = "show.jsp";
                break;
            case "edit":
                id = Integer.valueOf(request.getParameter("id"));
                assignment = assignmentService.getAssignmentById(id);
                request.setAttribute("assignment", assignment);
                view = "edit.jsp";
                break;
            case "addHurdle":
                id = Integer.valueOf(request.getParameter("id"));
                assignment = assignmentService.getAssignmentById(id);
                assignmentService.addHurdle(assignment);
                PrintWriter out = response.getWriter();
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                out.print("{status:updated}");
                out.flush();
                return;
        }

        RequestDispatcher rd = request.getRequestDispatcher("views/assignment/"+view);
        rd.forward(request, response);
    }
}
