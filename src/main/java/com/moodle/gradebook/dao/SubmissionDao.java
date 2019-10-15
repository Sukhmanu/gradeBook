package com.moodle.gradebook.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.moodle.gradebook.bean.Assignment;
import com.moodle.gradebook.bean.Submission;
import com.moodle.gradebook.bean.User;
import com.moodle.gradebook.util.DatabaseManager;
import com.moodle.gradebook.util.DateConverter;

public class SubmissionDao {
	Connection conn = null;
    PreparedStatement st = null;
    
    public Submission saveSubmission(Submission submission){
    	 String generatedColumns[] = { "id" };
        try{
        	
            conn = DatabaseManager.getConnection();
            st = conn.prepareStatement("INSERT INTO submission (submission_date, submitted_by, submitted_to, assignment_id, marks, comments, status) VALUES (?,?,?,?,?,?,?)"
            		, generatedColumns);
            st.setDate(1, DateConverter.convert(submission.getSubmissionDate()));
            st.setInt(2, submission.getSubmittedBy().getId());
            st.setInt(3, submission.getSubmittedTo().getId());
            st.setInt(4, submission.getAssignment().getId());
            st.setFloat(5, submission.getMarks());
            st.setString(6, submission.getComments());
            st.setString(7, submission.getStatus());

            int affectedRows  = st.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Failed to create submission!!!");
            }

            ResultSet rs = st.getGeneratedKeys();
            if (rs.next()) {
                int id = rs.getInt(1);
                submission.setId(id);
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
        return submission;
    }

    public Submission updateSubmission(Submission submission){
        try{
            conn = DatabaseManager.getConnection();
            st = conn.prepareStatement("UPDATE submission SET marks = ?, comments = ?, status = ? where id = ?");
            st.setFloat(1, submission.getMarks());
            st.setString(2, submission.getComments());
            st.setString(3, submission.getStatus());
            st.setInt(4, submission.getId());

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
        return submission;
    }

    public Submission getSubmissionByAssignmentAndStudent(Assignment assignment, User student){
        Submission submission = null;
        try{
            conn = DatabaseManager.getConnection();
            st = conn.prepareStatement("SELECT id, submission_date, submitted_by, submitted_to, assignment_id, marks, comments, status FROM submission" +
                    " where assignment_id = ? and submitted_by = ?");
            st.setInt(1, assignment.getId());
            st.setInt(2, student.getId());
            ResultSet rs = st.executeQuery();

            if(rs.next()){
                submission = new Submission();
                submission.setId(rs.getInt("id"));
                submission.setSubmissionDate(rs.getDate("submission_date"));
                submission.setSubmittedBy(student);
                User lecturer = new User();
                lecturer.setId(rs.getInt("submitted_to"));
                submission.setSubmittedTo(lecturer);
                submission.setAssignment(assignment);
                submission.setMarks(rs.getFloat("marks"));
                submission.setComments(rs.getString("comments"));
                submission.setStatus(rs.getString("status"));
            }
            rs.close();
        } catch (Exception e){
            try {
                st.close();
                conn.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        return submission;
    }

}
