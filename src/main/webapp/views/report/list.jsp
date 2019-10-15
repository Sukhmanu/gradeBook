<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ page import="com.moodle.gradebook.bean.User" %>

<t:template>

    <div class="card border border-primary m-2">
        <h5 class="card-header h3 shadow-sm rounded">
            <span class="fa fa-table"></span>
            Reports
        </h5>
        <div class="card-body rounded m-1 p-1">
            <ul class="list-group">
                <c:forEach items="${subjects}" var="subject" varStatus="loop">
                    <a href="report?type=subject&id=${subject.id}" >
                        <li class="list-group-item d-flex justify-content-between
                                align-items-center list-group-item-action bg-light">
                                ${subject.title}
                            <span class="d-inline-block fa fa-table fa-2x"></span>
                        </li>
                    </a>
                </c:forEach>
            </ul>
        </div>
    </div>

    <div class="card border border-primary m-2">
        <h5 class="card-header h3 shadow-sm rounded">
            <span class="fa fa-table"></span>
            Shared Reports
        </h5>
        <div class="card-body rounded m-1 p-1">
            <ul class="list-group">
                <c:if test="${empty sharedReports}">
                    <li class="list-group-item d-flex justify-content-between
                                align-items-center list-group-item-action bg-light">
                        You do not have any Shared Report
                    </li>
                </c:if>
                <c:forEach items="${sharedReports}" var="subject" varStatus="loop">
                    <a href="report?type=subject&id=${subject.id}&shared=1" >
                        <li class="list-group-item d-flex justify-content-between
                                align-items-center list-group-item-action bg-light">
                                ${subject.title}
                            <span class="d-inline-block fa fa-table fa-2x"></span>
                        </li>
                    </a>
                </c:forEach>
            </ul>
        </div>
    </div>
</t:template>