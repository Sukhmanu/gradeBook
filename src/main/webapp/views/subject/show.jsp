<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="com.moodle.gradebook.bean.User" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<t:template>

    <nav aria-label="breadcrumb">
        <ol class="breadcrumb pb-2 pt-2 m-0 bg-transparent">
            <li class="breadcrumb-item"><a href="${currentUser.type}?action=home">Home</a></li>
            <li class="breadcrumb-item active">${subject.title}</li>
                <%--<a href="subject?action=show&id=${subject.id}">${subject.title}</a>--%>
        </ol>
    </nav>

    <div class="card border border-primary m-2">
        <h5 class="card-header h3 shadow-sm rounded">
            <span class="d-inline-block fa fa-book"></span>
            Subject Detail
                <%-- butons--%>
            <c:if test="${currentUser.type eq User.ADMIN}">
                <a class="btn border-0 p-0 bg-transparent text-dark float-right"
                   data-toggle="tooltip" data-original-title="Delete"
                   style="margin-top: 8px;" href="subject?action=delete&id=${subject.id}">
                    <li class="fa fa-trash fa-2x"></li>
                </a>
                <a class="btn border-0 p-0 bg-transparent text-dark float-right"
                   data-toggle="tooltip" data-original-title="Edit"
                   style="margin-top: 8px;margin-right: 10px;" href="subject?action=edit&id=${subject.id}">
                    <li class="fa fa-edit fa-2x"></li>
                </a>
            </c:if>
            <c:if test="${currentUser.type eq User.LEACTURER}">
                <a class="btn border-0 p-0 bg-transparent text-dark float-right"
                   data-toggle="tooltip" data-original-title="View Report"
                   style="margin-top: 8px;margin-right: 10px;" href="report?type=subject&id=${subject.id}">
                    <li class="fa fa-table fa-2x"></li>
                </a>
            </c:if>
        </h5>


        <div class="card-body rounded bg-light p-4 m-1">

            <form action="subject" method="post">
                <div class="form-group row">
                    <label for="title" class="col-sm-2 col-form-label">Title</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="title" name="title" disabled="disabled" value="${subject.title}">
                    </div>
                </div>
                <div class="form-group row">
                    <label for="code" class="col-sm-2 col-form-label">Code</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="code" name="code" disabled="disabled" value="${subject.code}">
                    </div>
                </div>
                <div class="form-group row">
                    <label for="summary" class="col-sm-2 col-form-label">Summary</label>
                    <div class="col-sm-10">
                    <textarea class="form-control" rows="5" id="summary" name="summary" disabled="disabled">${subject.summary}
                    </textarea>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="detail" class="col-sm-2 col-form-label">Detail</label>
                    <div class="col-sm-10">
                    <textarea class="form-control"  rows="7" id="detail" name="detail" disabled="disabled">${subject.detail}
                    </textarea>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <c:if test="${currentUser.type eq User.LEACTURER or currentUser.type eq User.STUDENT}">
        <div class="card border border-primary m-2">
            <h5 class="card-header h3 shadow-sm rounded">
                <span class="fa fa-bookmark"></span>
                Assignments
                <c:if test="${currentUser.type eq User.LEACTURER}">
                    <a class="btn border-0 p-0 bg-transparent text-dark float-right"
                       data-toggle="tooltip" data-original-title="Create new assignment"
                       style="margin-top: 8px;" href="assignment?action=create&subjectId=${subject.id}">
                        <li class="fa fa-plus-square fa-2x"></li>
                    </a>
                    <%--<a class="btn border-0 p-0 bg-transparent text-dark float-right" id="add_hurdle"
                       data-toggle="tooltip" data-original-title="Add Hurdle"
                       style="margin-top: 8px;margin-right: 10px;" href="#">
                        <li class="fa fa-edit fa-2x"></li>
                    </a>--%>
                </c:if>
            </h5>

            <c:if test="${empty subject.assignments}">
                <div class="card-body rounded bg-light p-4 m-1">
                        <%--<h5 class="card-title">Special title treatment</h5>--%>
                    <p class="card-text"><b>${subject.title}</b> do not have any Assigment. </p>
                    <c:if test="${currentUser.type eq User.LEACTURER}">
                        <a href="assignment?action=create&subjectId=${subject.id}" class="btn btn-primary">Create Assignment</a>
                    </c:if>
                </div>
            </c:if>

            <ul class="list-group show_hurdle" id="assignments" >
                <c:forEach items="${subject.assignments}" var="assignment" varStatus="loop">
                    <a href="assignment?action=show&id=${assignment.id}" >
                        <li class="list-group-item d-flex justify-content-between
                                align-items-center list-group-item-action bg-light ">
                                ${assignment.name}
                                 <c:if test="${currentUser.type eq User.LEACTURER}">
                            <div class="custom-control custom-radio d-inline-block hurdle_div" id="${assignment.id}_hd_div">
                                <input type="radio" name="hurdle" class="custom-control-input" id="${assignment.id}" value="${assignment.id}"
                                <c:if test="${assignment.hurdle eq true}"> checked</c:if> >
                                <label class="custom-control-label" for="${assignment.id}">Hurdle ?</label>
                            </div>
                            </c:if>
                            <span class="itemRightArrow" id="${assignment.id}_rightArrow"></span>
                        </li>
                    </a>
                </c:forEach>
            </ul>
        </div>
    </c:if>

    <c:if test="${currentUser.type ne User.STUDENT}">
        <div class="card border border-primary m-2">
            <h5 class="card-header h3 shadow-sm rounded">
                <span class="fa fa-users"></span>
                Participants </h5>
            <c:if test="${empty students}">
                <p class="card-text">You do not have any Participants assigned. Please contact administrator  </p>
            </c:if>

            <ul class="list-group">
                <c:forEach items="${students}" var="subject" varStatus="loop">
                    <a href="admin?action=show&id=${subject.id}" >
                        <li class="list-group-item d-flex justify-content-between
                                align-items-center list-group-item-action bg-light">
                                ${subject.fName}, ${subject.lName} - ${subject.email}
                            <span class="itemRightArrow"></span>
                        </li>
                    </a>
                </c:forEach>
            </ul>
        </div>
    </c:if>

    <c:if test="${currentUser.type eq User.ADMIN}">
        <div class="card border border-primary m-2">
            <h5 class="card-header h3 shadow-sm rounded">
                <span class="fa fa-users"></span>
                Lecturers </h5>
            <c:if test="${empty lecturers}">
                <p class="card-text">You do not have any Lecturers assigned. Please contact administrator  </p>
            </c:if>
            <ul class="list-group">
                <c:forEach items="${lecturers}" var="lecturer" varStatus="loop">
                    <a href="admin?action=show&id=${lecturer.id}" >
                        <li class="list-group-item d-flex justify-content-between
                                align-items-center list-group-item-action bg-light">
                                ${lecturer.fName}, ${lecturer.lName} - ${lecturer.email}
                            <span class="itemRightArrow"></span>
                        </li>
                    </a>
                </c:forEach>
            </ul>
        </div>
    </c:if>

    <!-- Bar Graph popup -->
    <div class="modal fade exampleModal " tabindex="-1" role="dialog" aria-labelledby="exampleModal" aria-hidden="true" id="exampleModal">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">${subject.title} progress graph</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <canvas id="myChart" width="800" height="400"></canvas>
                </div>
                    <%--<div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary">Save changes</button>
                    </div>--%>
            </div>
        </div>
    </div>
    <script>
        const studentsNames = [];
        <c:forEach items="${students}" var="subject" varStatus="loop">
        studentsNames.push("${subject.fName} ${subject.lName}");
        </c:forEach>
        const studentsMarks = [];
        <c:forEach items="${students}" var="subject" varStatus="loop">
        studentsMarks.push((${subject.id} + 5 * 5) % 100);
        </c:forEach>
        $( document ).ready(function() {
            var ctx = document.getElementById('myChart');
            var myChart = new Chart(ctx, {
                type: 'horizontalBar',
                data: {
                    labels: studentsNames,
                    datasets: [{
                        label: 'Marks',
                        data: studentsMarks,
                        backgroundColor: [
                            'rgba(255, 99, 132, 0.2)',
                            'rgba(255, 99, 132, 0.2)',
                            'rgba(54, 162, 235, 0.2)',
                            'rgba(255, 206, 86, 0.2)',
                            'rgba(75, 192, 192, 0.2)',
                            'rgba(153, 102, 255, 0.2)',
                            'rgba(255, 159, 64, 0.2)'
                        ],
                        borderColor: [
                            'rgba(255, 99, 132, 0.2)',
                            'rgba(255, 99, 132, 1)',
                            'rgba(54, 162, 235, 1)',
                            'rgba(255, 206, 86, 1)',
                            'rgba(75, 192, 192, 1)',
                            'rgba(153, 102, 255, 1)',
                            'rgba(255, 159, 64, 1)'
                        ],
                        borderWidth: 1
                    }]
                },
                options: {
                    /*title: {
                        display: true,
                        text: 'Custom Chart Title',
                        fontSize: 30,
                        position:'bottom'
                    },*/
                    scales: {
                        yAxes: [{
                            ticks: {
                                beginAtZero: true
                            }
                        }],
                        xAxes: [{
                            ticks: {
                                beginAtZero: true
                            }
                        }]
                    },
                    responsive: true
                }
            });
        });

        $('input[type=radio][name=hurdle]').change(function() {
            $("#submit-progress").removeClass("d-none");
            $("#alert-message").fadeIn(1000);
            $("#submit-progress").fadeOut(1000);
            $("#alert-message").text("Hurdle successfully added!!!");
            $("#alert-message").removeClass("d-none");
            $("#alert-message").fadeOut(5000);
            $.get("assignment?action=addHurdle", {id: this.value});
        });
    </script>
</t:template>