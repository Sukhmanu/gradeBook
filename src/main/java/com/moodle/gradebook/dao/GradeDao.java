package com.moodle.gradebook.dao;

import com.moodle.gradebook.bean.Grade;
import com.moodle.gradebook.bean.User;
import com.moodle.gradebook.util.DatabaseManager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class GradeDao {
    Connection conn = null;
    PreparedStatement st = null;

    public List<Grade> getGrades(){
         List<Grade> grades = new ArrayList<>();

        try{
            conn = DatabaseManager.getConnection();
            st = conn.prepareStatement("SELECT id, grade_code, definition, min_mark, max_mark FROM grade order by max_mark desc ");
            ResultSet rs = st.executeQuery();
            while(rs.next()){
                Grade grade = new Grade();
                grade.setId(rs.getInt("id"));
                grade.setGradeCode(rs.getString("grade_code"));
                grade.setDefinition(rs.getString("definition"));
                grade.setMinMark(rs.getInt("min_mark"));
                grade.setMaxMark(rs.getInt("max_mark"));
                grades.add(grade);
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
        return grades;
    }
}
