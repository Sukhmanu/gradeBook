package com.moodle.gradebook.service;

import com.moodle.gradebook.bean.User;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class SessionService {

    public User currentUser(HttpServletRequest request){
        HttpSession session=request.getSession(false);
        User user = null;
        try {
            user = (User) session.getAttribute("loggedUser");
            request.setAttribute("currentUser", user);
        }catch (NullPointerException np){
            return null;
        }
        return user;
    }

    public void addLoginUser(HttpServletRequest request, User user){
        HttpSession session=request.getSession();
        session.setAttribute("loggedUser",user);
    }

    public void logoutUser(HttpServletRequest request){
        HttpSession session=request.getSession();
        session.removeAttribute("loggedUser");
    }

    public boolean isUserLoggedIn(HttpServletRequest request){
        User user = currentUser(request);

        if(user != null){
            return false;
        } else {
            return true;
        }
    }
}
