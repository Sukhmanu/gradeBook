package com.moodle.gradebook.service;

import com.moodle.gradebook.bean.User;
import com.moodle.gradebook.dao.UserDao;

import java.util.List;

public class UserService {
    UserDao userDao = new UserDao();

    public User save(User user){
        return userDao.saveUser(user);
    }

    public List<User> getUsers(String type){
        return userDao.getUsersByType(type);
    }

    public User getUser(int id){
        return userDao.getUserById(id);
    }

    public User updateUser(User user){
        return userDao.updateUser(user);
    }

    public boolean deleteUser(int id){
        return userDao.deleteUser(id);
    }

    public User getUserByEmailAndPass(String email, String pass){
        return userDao.getUserByEmailAndPass(email, pass);
    }
}
