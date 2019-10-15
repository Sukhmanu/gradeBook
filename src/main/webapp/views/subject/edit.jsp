<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="list" uri="http://listFun"%>

<t:template>
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb pb-2 pt-2 m-0 bg-transparent">
            <li class="breadcrumb-item"><a href="${currentUser.type}?action=home">Home</a></li>
            <li class="breadcrumb-item active"><a href="subject?action=show&id=${subject.id}">${subject.title}</a></li>
                <%--<a href="subject?action=show&id=${subject.id}">${subject.title}</a>--%>
        </ol>
    </nav>
    <div class="card border border-primary m-2">
        <h5 class="card-header h3 shadow-sm rounded">
            <span class="d-inline-block fa fa-book"></span>
            Edit Subject </h5>


        <div class="card-body rounded bg-light p-4 m-1">
            <form action="subject?action=update" method="post">
                <input type="hidden" name="id"  value="${subject.id}">
                <div class="form-group row required">
                    <label for="title" class="col-sm-2 col-form-label">Title</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="title" name="title" value="${subject.title}" required>
                    </div>
                </div>
                <div class="form-group row required">
                    <label for="code" class="col-sm-2 col-form-label">Code</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="code" name="code" value="${subject.code}" required>
                    </div>
                </div>
                <div class="form-group row required">
                    <label for="summary" class="col-sm-2 col-form-label">Summary</label>
                    <div class="col-sm-10">
                    <textarea class="form-control" rows="5" id="summary" name="summary" required>${subject.summary}
                    </textarea>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="detail" class="col-sm-2 col-form-label">Detail</label>
                    <div class="col-sm-10">
                    <textarea class="form-control"  rows="7" id="detail" name="detail" >${subject.detail}
                    </textarea>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="students" class="col-sm-2 col-form-label">Enroll</label>
                    <div class="col-sm-10">
                        <select class="form-control selectpicker" id="students" name="students" multiple>
                            <c:forEach items="${students}" var="student">

                                <option value="${student.id}"
                                        <c:if test="${list:contains(subject.getStudents(),student )}"> selected </c:if> >
                                        ${student.rollNo} - ${student.fName} ${student.lName}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="lecturers" class="col-sm-2 col-form-label">Lecturers</label>
                    <div class="col-sm-10">
                        <select class="form-control selectpicker" id="lecturers" name="lecturers" multiple>
                            <c:forEach items="${lecturers}" var="lecturer">
                                <option value="${lecturer.id}"
                                        <c:if test="${list:contains(subject.getLecturers(),lecturer )}"> selected </c:if> >
                                        ${lecturer.fName} ${lecturer.fName}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="form-group row">
                    <div class="col-sm-10">
                        <button type="submit" class="btn btn-primary">Update</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</t:template>