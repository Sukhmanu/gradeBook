package com.moodle.gradebook.dao;

import com.moodle.gradebook.bean.Subject;
import com.moodle.gradebook.bean.User;
import com.moodle.gradebook.util.DatabaseManager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ReportDao {
    Connection conn = null;
    PreparedStatement st = null;

    public void shareSubjectReport(Subject subject, User lecturer){
        try{
            conn = DatabaseManager.getConnection();
            st = conn.prepareStatement("INSERT INTO shared_report (subject_id, lecturer_id) VALUES (?,?)");
            st.setInt(1, subject.getId());
            st.setInt(2, lecturer.getId());
            int affectedRows  = st.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Failed share report!!!");
            }

            st.close();
            conn.close();
        } catch (Exception e){
            e.printStackTrace();
        } finally {

        }
    }

    public void deleteSharedReport(Subject subject){
        try{
            conn = DatabaseManager.getConnection();
            st = conn.prepareStatement("DELETE FROM shared_report WHERE subject_id = ?");
            st.setInt(1, subject.getId());
            st.executeUpdate();

            st.close();
            conn.close();
        } catch (Exception e){
            e.printStackTrace();
        } finally {

        }
    }

    public List<User> reportSharedWith(Subject subject){
        List<User> users = new ArrayList<>();

        try{
            conn = DatabaseManager.getConnection();
            st = conn.prepareStatement("SELECT u.id, u.rollNo, u.fName, u.lName, u.email, u.password, u.type, u.city, u.country, u.active" +
                    " FROM user u inner join shared_report sr on sr.lecturer_id = u.id" +
                    " where u.type = ? and sr.subject_id = ? order by u.fName, u.lName");
            st.setString(1, User.LEACTURER);
            st.setInt(2, subject.getId());
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

    public List<Subject> sharedReports(User user){
        List<Subject> subjects = new ArrayList<>();

        try{
            conn = DatabaseManager.getConnection();
            st = conn.prepareStatement("SELECT s.id, s.code, s.title, s.detail, s.summary " +
                    "FROM subject s" +
                    "  inner join shared_report sr on sr.subject_id = s.id" +
                    " where sr.lecturer_id = ? ");
            st.setInt(1, user.getId());
            ResultSet rs = st.executeQuery();

            while(rs.next()){
                Subject subject = new Subject();
                subject.setId(rs.getInt("id"));
                subject.setCode(rs.getString("code"));
                subject.setTitle(rs.getString("title"));
                subject.setDetail(rs.getString("detail"));
                subject.setSummary(rs.getString("summary"));

                subjects.add(subject);
            }
            rs.close();
            conn.close();
            st.close();
        } catch (Exception e){
            e.printStackTrace();
        }
        return subjects;
    }


}
