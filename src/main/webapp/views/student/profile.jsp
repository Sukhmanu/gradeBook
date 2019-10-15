<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<t:template>
    <div class="card border border-primary m-2">
        <h5 class="card-header h3 shadow-sm rounded">
            <span class="fa fa-user"></span>
            My Profile </h5>

        <div class="card-body bg-light rounded m-1 p-1">
            <form action="admin" method="post">
                <input type="hidden" name ="type" value="lecturer"/>
                <input type="hidden" name ="id" value="${user.id}"/>
                <input type="hidden" name ="operation" value="update"/>
                <div class="form-group row">
                    <label for="rollNo" class="col-sm-2 col-form-label">Student ID</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="rollNo" name ="rollNo" value="${user.rollNo}" disabled="disabled">
                    </div>
                </div>
                <div class="form-group row">
                    <label for="firstName" class="col-sm-2 col-form-label">First Name</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="firstName" name="firstName" value="${user.fName}" disabled="disabled">
                    </div>
                </div>
                <div class="form-group row">
                    <label for="lastName" class="col-sm-2 col-form-label">Last Name</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="lastName" name="lastName" value="${user.lName}" disabled="disabled">
                    </div>
                </div>
                <div class="form-group row">
                    <label for="email" class="col-sm-2 col-form-label">Email</label>
                    <div class="col-sm-10">
                        <input type="email" class="form-control" id="email" name="email" value="${user.email}" disabled="disabled">
                    </div>
                </div>
                    <%--<div class="form-group row">
                        <label for="inputPassword3" class="col-sm-2 col-form-label">Password</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="inputPassword3" name="pass" value="${user.password}" disabled="disabled">
                        </div>
                    </div>--%>
                <div class="form-group row">
                    <label for="city" class="col-sm-2 col-form-label">City/Town</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="city" name="city" value="${user.city}" disabled="disabled">
                    </div>
                </div>
                <div class="form-group row">
                    <label for="country" class="col-sm-2 col-form-label">Country</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="country" name="country" value="${user.country}" disabled="disabled">
                    </div>
                </div>
            </form>
        </div>
    </div>

    <div class="card border border-primary m-2">
        <h5 class="card-header h3 shadow-sm rounded">
            <span class="fa fa-book"></span>
            My Subjects </h5>

        <div class="card-body rounded m-1 p-1">
            <c:if test="${empty subjects}">
                <p class="card-text">You do not have any Subjects assigned. Please contact administrator  </p>
            </c:if>

                <%--<c:forEach items="${subjects}" var="subject">--%>
            <ul class="list-group">
                <c:forEach items="${subjects}" var="subject" varStatus="loop">
                    <a href="subject?action=show&id=${subject.id}" >
                        <li class="list-group-item d-flex justify-content-between
                                align-items-center list-group-item-action bg-light">
                                ${subject.title}
                            <span class="itemRightArrow"></span>
                        </li>
                    </a>
                </c:forEach>
            </ul>
                <%--</c:forEach>--%>
        </div>
    </div>
</t:template>