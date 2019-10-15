package com.moodle.gradebook.servlet;

import com.moodle.gradebook.bean.Grade;
import com.moodle.gradebook.bean.User;
import com.moodle.gradebook.service.GradeService;
import com.moodle.gradebook.service.SessionService;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "GradeServlet", value = "/grade")
public class GradeServlet extends HttpServlet {
    SessionService sessionService = new SessionService();
    GradeService gradeService = new GradeService();
    User currentUser = null;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        currentUser = sessionService.currentUser(request);
        List<Grade> grades = gradeService.getGrades();

        request.setAttribute("grades", grades);
        RequestDispatcher rd = request.getRequestDispatcher("views/grade/show.jsp");
        rd.forward(request, response);
    }
}
