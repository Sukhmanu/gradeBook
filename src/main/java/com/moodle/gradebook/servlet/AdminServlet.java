package com.moodle.gradebook.servlet;

import com.moodle.gradebook.bean.User;
import com.moodle.gradebook.dao.UserDao;
import com.moodle.gradebook.service.SessionService;
import com.moodle.gradebook.service.UserService;

import javax.annotation.Resource;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "AdminServlet", value = "/admin", initParams = {
    @WebInitParam(name = "action", value = "users"),
    @WebInitParam(name = "type", value = "student")
    })
public class AdminServlet extends HttpServlet {
    UserService userService = new UserService();
    SessionService sessionService = new SessionService();
    User currentUser = null;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        currentUser = sessionService.currentUser(request);
        int rollNo = Integer.valueOf(request.getParameter("rollNo"));
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String pass = request.getParameter("pass");
        String city = request.getParameter("city");
        String country = request.getParameter("country");
        String type = request.getParameter("type");
        String action = request.getParameter("operation");

        User user = new User();
        user.setRollNo(rollNo);
        user.setfName(firstName);
        user.setlName(lastName);
        user.setEmail(email);
        user.setPassword(pass);
        user.setCity(city);
        user.setCountry(country);
        user.setType(type);
        user.setActive(true);

        if(action != null && action.equals("update")){
            int id = Integer.valueOf(request.getParameter("id"));
            user.setId(id);
            user = userService.updateUser(user);
        } else {
            user = userService.save(user);
        }

        request.setAttribute("user", user);
        String view = "views/student/show.jsp";
        if(user.isLecturer())
            view = "views/lecturer/show.jsp";

        request.setAttribute("servlet", "admin");
        RequestDispatcher rd = request.getRequestDispatcher(view);
        rd.forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        currentUser = sessionService.currentUser(request);
        String view = "views/admin/home.jsp";
        String action = request.getParameter("action");
        String type = request.getParameter("type");
        if(type == null)
            type = User.STUDENT;
        if(action == null)
            action = "users";

        switch (action) {
            case "home":
                view = "views/lecturer/profile.jsp";
                request.setAttribute("user", currentUser);
                break;
            case "users":
                view = usersList(request, response);
                break;
            case "subjects":
                //view = subjectsList(request, response);
                break;
            case "create":
                if(type != null && type.equals(User.LEACTURER))
                    view = "views/lecturer/create.jsp";
                else
                    view = "views/student/create.jsp";
                break;
            case "show":
                User user = getUser(request, response);
                if(user != null && user.isLecturer())
                    view = "views/lecturer/show.jsp";
                else
                    view = "views/student/show.jsp";
                break;
            case "edit":
                user = getUser(request, response);
                if(user != null && user.isLecturer())
                    view = "views/lecturer/edit.jsp";
                else
                    view = "views/student/edit.jsp";
                break;
            case "delete":
                int id = Integer.valueOf(request.getParameter("id"));
                user = userService.getUser(id);
                userService.deleteUser(id);

                List<User> users = userService.getUsers(user.getType());
                request.setAttribute("users", users);
                request.setAttribute("type", user.getType());
                view = "views/admin/users.jsp";
                break;
            case "grade":
                view = "views/lecturer/grade.jsp";
                break;
            default:

                break;
        }
        request.setAttribute("servlet", "admin");
        RequestDispatcher rd = request.getRequestDispatcher(view);
        rd.forward(request, response);
    }

    private User getUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        int id = Integer.valueOf(request.getParameter("id"));
        User user = userService.getUser(id);
        request.setAttribute("user", user);
        return user;
    }
    private String usersList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        String type = request.getParameter("type");
        if(type == null)
            type = User.STUDENT;
        List<User> users = userService.getUsers(type);

        request.setAttribute("users", users);
        request.setAttribute("type", type);
        return "views/admin/users.jsp";
    }
}
