<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>

<t:template>
    <style type="text/css">
        .table-dark, .table-dark > th, .table-dark > td {
            background-color: black;
        }
    </style>
    <div class="card border border-primary m-2">
        <h5 class="card-header h3 shadow-sm rounded">
            <span class="fa fa-graduation-cap"></span>
            Grades </h5>

        <div class="card-body rounded bg-light p-0 m-1">

            <table class="table table-bordered rounded m-0">
                <thead>
                <tr class="table-dark">
                    <th scope="col">Grade</th>
                    <th scope="col">Definition</th>
                    <th scope="col">Mark range</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach  items="${grades}" var="grade">
                    <tr>
                        <th scope="row">${grade.gradeCode}</th>
                        <td>${grade.definition}</td>
                        <td>${grade.minMark} - ${grade.maxMark}%</td>
                    </tr>
                </c:forEach>

                </tbody>
            </table>
        </div>
    </div>
</t:template>