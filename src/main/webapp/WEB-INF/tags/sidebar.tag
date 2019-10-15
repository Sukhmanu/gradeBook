<%@tag description="Simple Wrapper Tag" pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<c:set var="ctx" value="admin?action="/>
<c:set var="listClass" value="list-group-item list-group-item-action bg-light"/>
<%@ tag import="com.moodle.gradebook.bean.User" %>

<!-- Sidebar -->
<div class="bg-light border-right" id="sidebar-wrapper">
    <div class="sidebar-heading">${currentUser.type}</div>
    <div class="list-group list-group-flush">
        <a href="${currentUser.type}?action=home" class="${listClass}">Home</a>
        <c:if test="${currentUser.type eq User.ADMIN}">
            <a href="${ctx}users&type=student" class="${listClass}">Students</a>
        </c:if>
        <c:if test="${currentUser.type eq User.ADMIN}">
            <a href="${ctx}users&type=lecturer" class="${listClass}">Lecturers</a>
        </c:if>
        <a href="subject?action=list" class="${listClass}">Subjects</a>
        <c:if test="${currentUser.type ne User.ADMIN}">
            <a href="report?type=list" class="${listClass}">Reports</a>
        </c:if>
        <a href="grade" class="${listClass}">Grade</a>
        <c:if test="${currentUser.type eq User.LEACTURER or currentUser.type eq User.STUDENT}">
            <a href="${currentUser.type}?action=reset" class="${listClass}">Change Password</a>
        </c:if>
        <a href="login?action=logout" class="${listClass}">Logout</a>
    </div>
</div>