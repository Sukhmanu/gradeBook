package com.moodle.gradebook.servlet;

import com.moodle.gradebook.bean.Subject;
import com.moodle.gradebook.bean.User;
import com.moodle.gradebook.service.SessionService;
import com.moodle.gradebook.service.SubjectService;
import com.moodle.gradebook.service.UserService;
import com.moodle.gradebook.util.ListUtil;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "SubjectServlet", value = "/subject")
public class SubjectServlet extends HttpServlet {
    SubjectService subjectService = new SubjectService();
    UserService userService = new UserService();
    SessionService sessionService = new SessionService();
    User currentUser = null;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        currentUser = sessionService.currentUser(request);
        String action = request.getParameter("action");
        String code = request.getParameter("code");
        String title = request.getParameter("title");
        String detail = request.getParameter("detail");
        String summary = request.getParameter("summary");
        String[] studentsValues = request.getParameterValues("students");
        String[] lecturerValues = request.getParameterValues("lecturers");

        List<Integer> studentsIds = ListUtil.transform(studentsValues, Integer::parseInt);
        List<Integer> lecturerIds = ListUtil.transform(lecturerValues, Integer::parseInt);

        Subject subject = new Subject();
        subject.setCode(code);
        subject.setTitle(title);
        subject.setDetail(detail);
        subject.setSummary(summary);

        for(Integer stdId:studentsIds){
            User student = userService.getUser(stdId);
            if(student != null)
                subject.addStudent(student);
        }
        for(Integer id:lecturerIds){
            User lecturer = userService.getUser(id);
            if(lecturer != null)
                subject.addLecturer(lecturer);
        }

        if("update".equalsIgnoreCase(action)) {
            int id = Integer.valueOf(request.getParameter("id"));
            subject.setId(id);
            subject = subjectService.updateSubject(subject);
        } else {
            subject = subjectService.save(subject);
        }

        subject = subjectService.getSubject(subject.getId());
        request.setAttribute("subject", subject);
        request.setAttribute("students", subject.getStudents());
        request.setAttribute("lecturers", subject.getLecturers());
        RequestDispatcher rd = request.getRequestDispatcher("views/subject/show.jsp");
        rd.forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        currentUser = sessionService.currentUser(request);
        String view = "views/admin/home.jsp";
        String action = request.getParameter("action");

        switch (action) {
            case "create":
                view = "create.jsp";
                break;
            case "show":
                int id = Integer.valueOf(request.getParameter("id"));
                Subject subject = subjectService.getSubject(id);
                request.setAttribute("students", subject.getStudents());
                request.setAttribute("lecturers", subject.getLecturers());
                request.setAttribute("subject", subject);
                view = "show.jsp";
                break;
            case "edit":
                id = Integer.valueOf(request.getParameter("id"));
                subject = subjectService.getSubject(id);
                request.setAttribute("students", userService.getUsers(User.STUDENT));
                request.setAttribute("lecturers", userService.getUsers(User.LEACTURER));
                request.setAttribute("subject", subject);
                view = "edit.jsp";
                break;
            case "list":
            default:
                List<Subject> subjects = null;
                if(currentUser.getType().equals(User.LEACTURER))
                    subjects = subjectService.getSubjectByUser(currentUser);
                else
                    subjects = subjectService.getSubjects();
                request.setAttribute("subjects", subjects);
                view = "list.jsp";
        }

        RequestDispatcher rd = request.getRequestDispatcher("views/subject/"+view);
        rd.forward(request, response);
    }
}
