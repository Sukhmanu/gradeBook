package com.moodle.gradebook.dao;

import com.moodle.gradebook.bean.Assignment;
import com.moodle.gradebook.bean.Subject;
import com.moodle.gradebook.util.DatabaseManager;
import com.moodle.gradebook.util.DateConverter;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AssignmentDao {
    Connection conn = null;
    PreparedStatement st = null;

    public Assignment saveAssignment(Assignment assignment){
        String generatedColumns[] = { "id" };
        try{
            conn = DatabaseManager.getConnection();
            st = conn.prepareStatement("INSERT INTO assignment (name, description, due_date, max_grade, passing_grade, subject_id) VALUES (?,?,?,?,?,?)", generatedColumns);
            st.setString(1, assignment.getName());
            st.setString(2, assignment.getDescription());
            st.setDate(3, DateConverter.convert(assignment.getDueDate()));
            st.setFloat(4, assignment.getMaxGrade());
            st.setFloat(5, assignment.getPassingGrade());
            st.setInt(6, assignment.getSubject().getId());

            int affectedRows  = st.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Failed to create assignment!!!");
            }

            ResultSet rs = st.getGeneratedKeys();
            if (rs.next()) {
                int id = rs.getInt(1);
                assignment = getAssignmentById(id);
                rs.close();
            }
            st.close();
            conn.close();
        } catch (Exception e){
            e.printStackTrace();
        } finally {

        }
        return assignment;
    }

    public Assignment updateAssignment(Assignment assignment){
        try{
            conn = DatabaseManager.getConnection();
            st = conn.prepareStatement("UPDATE assignment SET name = ?, description = ?, due_date = ?, max_grade = ?, passing_grade = ? WHERE id = ?");
            st.setString(1, assignment.getName());
            st.setString(2, assignment.getDescription());
            st.setDate(3, (new java.sql.Date(assignment.getDueDate().getTime())));
            st.setFloat(4, assignment.getMaxGrade());
            st.setFloat(5, assignment.getPassingGrade());
            st.setInt(6, assignment.getId());

            int affectedRows  = st.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Failed to create assignment!!!");
            }

            st.close();
            conn.close();
        } catch (Exception e){
            e.printStackTrace();
        } finally {

        }
        return assignment;
    }

    public List<Assignment> getAssignmentsBySubject(Subject subject){
        List<Assignment> assignments = new ArrayList<>();

        try{
            conn = DatabaseManager.getConnection();
            st = conn.prepareStatement("SELECT id, name, description, due_date, max_grade, passing_grade, subject_id, hurdle " +
                    "FROM assignment where subject_id = ? ");
            st.setInt(1, subject.getId());
            ResultSet rs = st.executeQuery();

            while(rs.next()){
                Assignment assignment = new Assignment();
                assignment.setId(rs.getInt("id"));
                assignment.setName(rs.getString("name"));
                assignment.setDescription(rs.getString("description"));
                assignment.setDueDate(rs.getDate("due_date"));
                assignment.setMaxGrade(rs.getLong("max_grade"));
                assignment.setPassingGrade(rs.getLong("passing_grade"));
                assignment.setHurdle(rs.getBoolean("hurdle"));
                assignment.setSubject(subject);
                assignments.add(assignment);
            }
            rs.close();
            conn.close();
            st.close();
        } catch (Exception e){
            e.printStackTrace();
        }
        return assignments;
    }


    public Assignment getAssignmentById(int id){
        Assignment assignment = new Assignment();

        try{
            conn = DatabaseManager.getConnection();
            st = conn.prepareStatement("SELECT id, name, description, due_date, max_grade, passing_grade, subject_id, hurdle " +
                    "FROM assignment where id = ? ");
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();

            if(rs.next()){
                assignment.setId(rs.getInt("id"));
                assignment.setName(rs.getString("name"));
                assignment.setDescription(rs.getString("description"));
                assignment.setDueDate(rs.getDate("due_date"));
                assignment.setMaxGrade(rs.getLong("max_grade"));
                assignment.setPassingGrade(rs.getLong("passing_grade"));
                assignment.setHurdle(rs.getBoolean("hurdle"));
                Subject subject = new Subject();
                subject.setId(rs.getInt("subject_id"));
                assignment.setSubject(subject);
            }
            rs.close();
            conn.close();
            st.close();
        } catch (Exception e){
            e.printStackTrace();
        }
        return assignment;
    }

    public void removeAnyHurdle(Subject subject){
        try {
            conn = DatabaseManager.getConnection();
            st = conn.prepareStatement("update assignment set hurdle = ? where subject_id = ?");
            st.setBoolean(1, false);
            st.setInt(2, subject.getId());
            st.executeUpdate();
        } catch (Exception e){
            e.printStackTrace();
            try {
                st.close();
                conn.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }

    public void addHurdle(Assignment assignment){
        try {
            conn = DatabaseManager.getConnection();
            st = conn.prepareStatement("update assignment set hurdle = ? where id = ?");
            st.setBoolean(1, true);
            st.setInt(2, assignment.getId());
            st.executeUpdate();
        } catch (Exception e){
            e.printStackTrace();
            try {
                st.close();
                conn.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }
}
