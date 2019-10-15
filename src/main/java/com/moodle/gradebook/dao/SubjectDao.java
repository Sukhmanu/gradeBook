package com.moodle.gradebook.dao;

import com.moodle.gradebook.bean.Subject;
import com.moodle.gradebook.bean.User;
import com.moodle.gradebook.service.UserService;
import com.moodle.gradebook.util.DatabaseManager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class SubjectDao {
    UserService userService = new UserService();

    Connection conn = null;
    PreparedStatement st = null;

    public Subject saveSubject(Subject subject){
        String generatedColumns[] = { "id" };
        try{
            conn = DatabaseManager.getConnection();
            st = conn.prepareStatement("INSERT INTO subject (code, title, detail, summary) VALUES (?,?,?,?)", generatedColumns);
            st.setString(1, subject.getCode());
            st.setString(2, subject.getTitle());
            st.setString(3, subject.getDetail());
            st.setString(4, subject.getSummary());

            int affectedRows  = st.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Failed to create subject!!!");
            }

            ResultSet rs = st.getGeneratedKeys();
            if (rs.next()) {
                int id = rs.getInt(1);
                subject = getSubjectById(id);
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
        return subject;
    }

    public Subject updateSubject(Subject subject){
        String generatedColumns[] = { "id" };
        try{
            conn = DatabaseManager.getConnection();
            st = conn.prepareStatement("UPDATE subject SET code = ?, title = ?, detail = ?, summary = ? where id = ?");
            st.setString(1, subject.getCode());
            st.setString(2, subject.getTitle());
            st.setString(3, subject.getDetail());
            st.setString(4, subject.getSummary());
            st.setInt(5, subject.getId());

            int affectedRows  = st.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Failed to update subject!!!");
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
        return subject;
    }

    public Subject getSubjectById(int id){
        Subject subject = new Subject();
        try{
            conn = DatabaseManager.getConnection();
            st = conn.prepareStatement("SELECT id, code, title, detail, summary FROM subject where id = ?");
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();

            if(rs.next()){
                subject.setId(rs.getInt("id"));
                subject.setCode(rs.getString("code"));
                subject.setTitle(rs.getString("title"));
                subject.setDetail(rs.getString("detail"));
                subject.setSummary(rs.getString("summary"));
            }
            rs.close();
            conn.close();
            st.close();
        } catch (Exception e){
            e.printStackTrace();
        }
        return subject;
    }

    public List<Subject> getAllSubjects(){
        List<Subject> subjects = new ArrayList<>();

        try{
            conn = DatabaseManager.getConnection();
            st = conn.prepareStatement("SELECT id, code, title, detail, summary FROM subject");
            //st.setString(1, type);
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


    public List<Subject> getSubjectsByUser(User user){
        List<Subject> subjects = new ArrayList<>();

        try{
            conn = DatabaseManager.getConnection();
            st = conn.prepareStatement("SELECT s.id, s.code, s.title, s.detail, s.summary " +
                    "FROM subject s inner join user_subject us on us.subject_id = s.id where us.user_id = ? ");
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

    /**
     * getUsersBySubject method will return all subjects users(lecturers as well students)
     * */
    public List<User> getUsersBySubject(Subject subject){
        List<User> users = new ArrayList<>();

        try{
            conn = DatabaseManager.getConnection();
            st = conn.prepareStatement("SELECT user_id FROM user_subject where subject_id = ?");
            st.setInt(1, subject.getId());
            ResultSet rs = st.executeQuery();

            while(rs.next()){
                User user = userService.getUser(rs.getInt("user_id"));
                users.add(user);
            }
            rs.close();
            conn.close();
            st.close();
        } catch (Exception e){
            e.printStackTrace();
        }
        return users;
    }

    public void addUser(Subject subject, User user){
        try{
            conn = DatabaseManager.getConnection();
            st = conn.prepareStatement("INSERT INTO user_subject (user_id, subject_id) VALUES (?,?)");
            st.setInt(1, user.getId());
            st.setInt(2, subject.getId());

            int affectedRows  = st.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Failed to add user to an subject!!!");
            }

            st.close();
            conn.close();
        } catch (Exception e){
            e.printStackTrace();
        } finally {

        }
    }

    public boolean removeUser(Subject subject, User user){
        try{
            conn = DatabaseManager.getConnection();
            st = conn.prepareStatement("DELETE from user_subject where user_id = ? and subject_id = ?");
            st.setInt(1, user.getId());
            st.setInt(2, subject.getId());
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

    public boolean removeAllStudent(Subject subject) {
        return removeAllUsersByType(subject, User.STUDENT);
    }

    public boolean removeAllLecturer(Subject subject) {
        return removeAllUsersByType(subject, User.LEACTURER);
    }

    public boolean removeAllUsersByType(Subject subject, String type){
        try{
            conn = DatabaseManager.getConnection();
            st = conn.prepareStatement("DELETE us from user_subject us inner join user u on u.id = us.user_id where u.type = ? and subject_id = ?");
            st.setString(1, type);
            st.setInt(2, subject.getId());
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

    public List<User> getStudentsWithMarks(Subject subject){
        List<User> users = new ArrayList<>();

        try{
            conn = DatabaseManager.getConnection();
            st = conn.prepareStatement("SELECT u.id, u.rollNo, u.fName, u.lName, u.email, u.password, u.type, u.city, u.country, u.active " +
                    ", sum(COALESCE(sb.marks, 0)) obtained_marks, sum(COALESCE(a.max_grade, 0)) total_marks "  +
                    "FROM user_subject us" +
                    " LEFT JOIN user u ON u.id = us.user_id" +
                    " LEFT JOIN assignment a ON a.subject_id = us.subject_id" +
                    " LEFT JOIN submission sb ON sb.assignment_id = a.id AND sb.submitted_by = u.id" +
                    "   where us.subject_id = ? and u.type = 'student' GROUP BY us.subject_id , u.id");
            st.setInt(1, subject.getId());
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
                user.setObtainMarks(rs.getFloat("obtained_marks"));
                user.setTotalMarks(rs.getFloat("total_marks"));

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

    public List<Subject> getSubjectsWithMarks(User student){
        List<Subject> subjects = new ArrayList<>();

        try{
            conn = DatabaseManager.getConnection();
            st = conn.prepareStatement("SELECT s.id, s.code, s.title, s.detail, s.summary " +
                    ", sum(COALESCE(sb.marks, 0)) obtained_marks,sum(COALESCE(a.max_grade, 0)) total_marks" +
                    " FROM  subject s" +
                    "  left JOIN  user_subject us ON us.subject_id = s.id " +
                    "  left JOIN  assignment a ON a.subject_id = s.id" +
                    "  left JOIN  submission sb ON sb.assignment_id = a.id and us.user_id = sb.submitted_by" +
                    "    where us.user_id = ?  GROUP BY us.subject_id, us.user_id");
            st.setInt(1, student.getId());
            ResultSet rs = st.executeQuery();

            while(rs.next()){
                Subject subject = new Subject();
                subject.setId(rs.getInt("id"));
                subject.setCode(rs.getString("code"));
                subject.setTitle(rs.getString("title"));
                subject.setDetail(rs.getString("detail"));
                subject.setSummary(rs.getString("summary"));;
                subject.setObtainMarks(rs.getFloat("obtained_marks"));
                subject.setTotalMarks(rs.getFloat("total_marks"));

                subjects.add(subject);
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
        return subjects;
    }
}



