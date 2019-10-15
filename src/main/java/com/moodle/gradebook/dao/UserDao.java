package com.moodle.gradebook.dao;

import com.moodle.gradebook.bean.User;
import com.moodle.gradebook.util.DatabaseManager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserDao {
    Connection conn = null;
    PreparedStatement st = null;

    public User saveUser(User user){
        String generatedColumns[] = { "id" };
        try{
            conn = DatabaseManager.getConnection();
            st = conn.prepareStatement("INSERT INTO user (rollNo, fName, lName, email, password, type, city, country, active)" +
                    " VALUES (?,?,?,?,?,?,?,?,?)", generatedColumns);
            st.setInt(1, user.getRollNo());
            st.setString(2, user.getfName());
            st.setString(3, user.getlName());
            st.setString(4, user.getEmail());
            st.setString(5, user.getPassword());
            st.setString(6, user.getType());
            st.setString(7, user.getCity());
            st.setString(8, user.getCountry());
            st.setBoolean(9, true);

            int affectedRows  = st.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Failed to create User!!!");
            }

            ResultSet rs = st.getGeneratedKeys();
            if (rs.next()) {
                int id = rs.getInt(1);
                user = getUserById(id);
                rs.close();
            }
        } catch (Exception e){
            e.printStackTrace();
        } finally {
            try {
                st.close();
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return user;
    }

    public User updateUser(User user){
        try{
            conn = DatabaseManager.getConnection();
            st = conn.prepareStatement("UPDATE user SET rollNo = ?, fName = ?, lName = ?, email = ?, password = ?, type = ?, city = ?, country = ?, active = ? where id = ?");
            st.setInt(1, user.getRollNo());
            st.setString(2, user.getfName());
            st.setString(3, user.getlName());
            st.setString(4, user.getEmail());
            st.setString(5, user.getPassword());
            st.setString(6, user.getType());
            st.setString(7, user.getCity());
            st.setString(8, user.getCountry());
            st.setBoolean(9, true);
            st.setInt(10, user.getId());

            st.execute();
        } catch (Exception e){
            e.printStackTrace();
        } finally {
            try {
                st.close();
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return user;
    }

    public User getUserById(int id){
        User user = new User();

        try{
            conn = DatabaseManager.getConnection();
            st = conn.prepareStatement("SELECT id, rollNo, fName, lName, email, password, type, city, country, active FROM user where id = ?");
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if(rs.next()){
                user.setId(rs.getInt("id"));
                user.setRollNo(rs.getInt("rollNo"));
                user.setfName(rs.getString("fName"));
                user.setlName(rs.getString("lName"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setPassword(rs.getString("password"));
                user.setType(rs.getString("type"));
                user.setCity(rs.getString("city"));
                user.setCountry(rs.getString("country"));
                user.setActive(rs.getBoolean("active"));
            }
            rs.close();
        } catch (Exception e){
            e.printStackTrace();
        } finally {
            try {
                st.close();
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return user;
    }

    public List<User> getUsersByType(String type){
        List<User> users = new ArrayList<>();

        try{
            conn = DatabaseManager.getConnection();
            st = conn.prepareStatement("SELECT id, rollNo, fName, lName, email, password, type, city, country, active FROM user where type = ? order by fName, lName");
            st.setString(1, type);
            ResultSet rs = st.executeQuery();

            while(rs.next()){
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setRollNo(rs.getInt("rollNo"));
                user.setfName(rs.getString("fName"));
                user.setlName(rs.getString("lName"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setPassword(rs.getString("password"));
                user.setType(rs.getString("type"));
                user.setCity(rs.getString("city"));
                user.setCountry(rs.getString("country"));
                user.setActive(rs.getBoolean("active"));

                users.add(user);
            }
            rs.close();
        } catch (Exception e){
            e.printStackTrace();
        } finally {
            try {
                st.close();
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return users;
    }

    public boolean deleteUser(int id){
        try{
            conn = DatabaseManager.getConnection();
            st = conn.prepareStatement("DELETE from shared_report where lecturer_id = ?");
            st.setInt(1, id);
            st.execute();
            st = conn.prepareStatement("DELETE from user_subject where user_id = ?");
            st.setInt(1, id);
            st.execute();
            st = conn.prepareStatement("DELETE from submission where submitted_by = ?");
            st.setInt(1, id);
            st.execute();
            st = conn.prepareStatement("DELETE from submission where submitted_to = ?");
            st.setInt(1, id);
            st.execute();
            
            st = conn.prepareStatement("DELETE from user where id = ?");
            st.setInt(1, id);
            st.execute();
            
        } catch (Exception e){
            e.printStackTrace();
        } finally {
            try {
                st.close();
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return true;
    }

    public User getUserByEmailAndPass(String email, String pass){
        User user = null;

        try{
            conn = DatabaseManager.getConnection();
            st = conn.prepareStatement("SELECT id, rollNo, fName, lName, email, password, type, city, country, active FROM user where email = ? and password = ?");
            st.setString(1, email);
            st.setString(2, pass);
            ResultSet rs = st.executeQuery();
            if(rs.next()){
                user = new User();
                user.setId(rs.getInt("id"));
                user.setRollNo(rs.getInt("rollNo"));
                user.setfName(rs.getString("fName"));
                user.setlName(rs.getString("lName"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setPassword(rs.getString("password"));
                user.setType(rs.getString("type"));
                user.setCity(rs.getString("city"));
                user.setCountry(rs.getString("country"));
                user.setActive(rs.getBoolean("active"));
            }
            rs.close();
        } catch (Exception e){
            e.printStackTrace();
        } finally {
            try {
                st.close();
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return user;
    }
}
