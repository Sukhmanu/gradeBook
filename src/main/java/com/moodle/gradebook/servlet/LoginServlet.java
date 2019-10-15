package com.moodle.gradebook.servlet;

import com.moodle.gradebook.bean.User;
import com.moodle.gradebook.service.SessionService;
import com.moodle.gradebook.service.UserService;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "LoginServlet", value = "/login")
public class LoginServlet extends HttpServlet {
    UserService userService = new UserService();
    SessionService sessionService = new SessionService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String pass = request.getParameter("pass");
        User user = userService.getUserByEmailAndPass(email, pass);

        if(user != null){
            sessionService.addLoginUser(request, user);

            if(user.getType().equalsIgnoreCase("ADMIN")){
                response.sendRedirect("admin");
                return;
            } else if(user.getType().equalsIgnoreCase(User.LEACTURER)){
                response.sendRedirect("lecturer");
                return;
            }else if(user.getType().equalsIgnoreCase(User.STUDENT)){
                response.sendRedirect("student");
                return;
            }
        }

        RequestDispatcher rd = request.getRequestDispatcher("views/login.jsp");
        rd.forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        sessionService.logoutUser(request);
        request.setAttribute("logout", true);
        RequestDispatcher rd = request.getRequestDispatcher("views/login.jsp");
        rd.forward(request, response);
    }
}
