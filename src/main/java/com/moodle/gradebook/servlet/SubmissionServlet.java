package com.moodle.gradebook.servlet;

import com.google.gson.Gson;
import com.moodle.gradebook.bean.Assignment;
import com.moodle.gradebook.bean.Submission;
import com.moodle.gradebook.bean.User;
import com.moodle.gradebook.service.AssignmentService;
import com.moodle.gradebook.service.SessionService;
import com.moodle.gradebook.service.SubmissionService;
import com.moodle.gradebook.service.UserService;
import com.moodle.gradebook.util.Param;

import javax.jws.soap.SOAPBinding;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "SubmissionServlet", value = "/submission")
public class SubmissionServlet extends HttpServlet {
    SessionService sessionService = new SessionService();
    UserService userService = new UserService();
    AssignmentService assignmentService = new AssignmentService();
    SubmissionService submissionService = new SubmissionService();
    User currentUser = null;
    private Gson gson = new Gson();

    /** doPost method will fetch all the values from HTTP POST request
     *   and updates or save the student's submission for a particular assigment
     **/
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //fetch current logged-in user object from the session
        currentUser = sessionService.currentUser(request);
        Param params = new Param(request);
        //fetch studentIds from the HTTP request
        int assignmentId = params.getInt("assignmentId");
        //fetch studentIds from the HTTP request
        List<Integer> studentIds = params.getIntegers("studentIds");

        Assignment assignment = assignmentService.getAssignmentById(assignmentId);
        List<User> students = new ArrayList<>();
        //iterate and fetch submission data from HTTP POST request for each student
        for (int studentId:studentIds){
            //find a student from the database by its id
            User student = userService.getUser(studentId);
            if(student != null){
                String ctx = "student["+student.getId()+"].";

                Submission newSubmission = new Submission();
                newSubmission.setAssignment(assignment);
                newSubmission.setSubmittedBy(student);
                newSubmission.setStatus(params.getString(ctx + "status"));
                newSubmission.setMarks(params.getFloat(ctx + "marks"));
                if(currentUser.getType().equals(User.LEACTURER))
                    newSubmission.setSubmittedTo(currentUser);

                // try to find a submission from the database
                Submission submission = submissionService.getSubmission(assignment, student);
                 /*if no submission is found then create a new submission and save it in database
                 else update submission */
                if(submission == null){
                    submissionService.save(newSubmission);
                } else{
                    int submissionId = params.getInt(ctx + "submissionId");
                    newSubmission.setId(submissionId);
                    submissionService.update(newSubmission);
                }
            }
        }

        //String assignmentJsonString = this.gson.toJson(assignment);
        PrintWriter out = response.getWriter();
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        //out.print(assignmentJsonString);
        out.print("{hello}");
        out.flush();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
