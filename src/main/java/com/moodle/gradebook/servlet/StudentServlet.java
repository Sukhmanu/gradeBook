package com.moodle.gradebook.servlet;

import com.moodle.gradebook.bean.Subject;
import com.moodle.gradebook.bean.User;
import com.moodle.gradebook.service.SessionService;
import com.moodle.gradebook.service.SubjectService;
import com.moodle.gradebook.service.UserService;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "StudentServlet", value = "/student")
public class StudentServlet extends HttpServlet {
    SessionService sessionService = new SessionService();
    UserService userService = new UserService();
    SubjectService subjectService = new SubjectService();
    User currentUser = null;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String view = "views/student/profile.jsp";
        currentUser = sessionService.currentUser(request);
        String action = request.getParameter("action");

        if("reset".equals(action)){
            String oldPass = request.getParameter("oldPass");
            String newPass = request.getParameter("newPass");

            User foundUser = userService.getUserByEmailAndPass(currentUser.getEmail(), oldPass);
            if(foundUser != null){
                foundUser.setPassword(newPass);
                userService.updateUser(foundUser);
                request.setAttribute("flashMsg", "Password successfully reset");
            } else {
            	view = "views/student/reset.jsp";
            	request.setAttribute("err_msg", "ERROR: You have entered wrong password.");
            }
        }

        request.setAttribute("servlet", "student");
        request.setAttribute("user", currentUser);

        RequestDispatcher rd = request.getRequestDispatcher(view);
        rd.forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String view, action = request.getParameter("action");
        currentUser = sessionService.currentUser(request);
        if(action == null)
            action = "profile";

        switch (action){
            case "reset":
                view = "views/student/reset.jsp";
                break;
            case "profile":
            default:
                List<Subject> subjects = subjectService.getSubjectByUser(currentUser);

                request.setAttribute("user", currentUser);
                request.setAttribute("subjects", subjects);
                view = "views/student/profile.jsp";
        }

        request.setAttribute("servlet", "student");
        RequestDispatcher rd = request.getRequestDispatcher(view);
        rd.forward(request, response);
    }
}
