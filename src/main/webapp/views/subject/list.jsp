<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ page import="com.moodle.gradebook.bean.User" %>

<t:template>

    <div class="card border border-primary m-2">
        <h5 class="card-header h3 shadow-sm rounded">
            <span class="d-inline-block fa fa-book"></span>
            Subject List
            <c:if test="${currentUser.type eq User.ADMIN}">
                <a class="btn border-0 p-0 bg-transparent text-dark float-right text-cap"
                   style="margin-top: 8px;" href="subject?action=create">
                    <li class="fa fa-plus-square fa-2x"></li>
                </a>
            </c:if>
        </h5>


        <div class="card-body rounded m-1 p-1">

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
        </div>
    </div>
</t:template>