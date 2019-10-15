<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="com.moodle.gradebook.bean.Submission" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.moodle.gradebook.bean.User" %>

<t:template>

        <nav aria-label="breadcrumb">
            <ol class="breadcrumb pb-2 pt-2 m-0 bg-transparent">
                <li class="breadcrumb-item"><a href="lecturer?action=home">Home</a></li>
                <li class="breadcrumb-item"><a href="subject?action=show&id=${assignment.subject.id}">${assignment.subject.title}</a></li>
                <li class="breadcrumb-item active" aria-current="page">${assignment.name}</li>
            </ol>
        </nav>

    <div class="card border border-primary m-2">
        <h5 class="card-header h3 shadow-sm rounded">
            <span class="fa fa-bookmark"></span>
            Assignment Detail of ${assignment.subject.title} subject
            <c:if test="${currentUser.type ne User.STUDENT}">
                <a class="btn border-0 p-0 bg-transparent text-dark float-right"
                   data-toggle="tooltip" data-original-title="Delete Assignment"
                   style="margin-top: 8px;" href="assignment?action=delete&id=${assignment.id}">
                    <li class="fa fa-trash fa-2x"></li>
                </a>
                <a class="btn border-0 p-0 bg-transparent text-dark float-right"
                   data-toggle="tooltip" data-original-title="Edit Assignment"
                   style="margin-top: 8px;margin-right: 10px;" href="assignment?action=edit&id=${assignment.id}">
                    <li class="fa fa-edit fa-2x"></li>
                </a>
                <a class="btn border-0 p-0 bg-transparent text-dark float-right"
                    <%--data-toggle="tooltip" data-original-title="Bar Chart"--%>
                   style="margin-top: 8px;margin-right: 10px;" href="#exampleModal" data-toggle="modal" data-target="#exampleModal">
                    <li class="fa fa-bar-chart fa-2x"></li>
                </a>
            </c:if>
        </h5>

            <%--buttons--%>


        <div class="card-body rounded bg-light p-4 m-1">
            <form action="assignment" method="post">
                <input type="hidden" name="subjectId" value="${assignment.subject.id}">
                <input type="hidden" name="action" value="create">
                <div class="form-group row">
                    <label for="name" class="col-sm-2 col-form-label">Assignment name</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="name" name="name" value="${assignment.name}" disabled>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="name" class="col-sm-2 col-form-label">Description</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="desc" name="desc" value="${assignment.description}" disabled>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="name" class="col-sm-2 col-form-label">Due dueDate</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="due" name="due"
                               value='<fmt:formatDate pattern = "MM/dd/YYYY" value = "${assignment.dueDate}" />'  disabled>
                        <script>
                            $('#due').datepicker({
                                uiLibrary: 'bootstrap4'
                            });
                        </script>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="name" class="col-sm-2 col-form-label">Maximum grade</label>
                    <div class="col-sm-10">
                        <input type="number" class="form-control" id="maxGrade" name="maxGrade" value="${assignment.maxGrade}" disabled>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="name" class="col-sm-2 col-form-label">Grade to pass</label>
                    <div class="col-sm-10">
                        <input type="number" class="form-control" id="passingGrade" name="passingGrade" value="${assignment.passingGrade}" disabled>
                    </div>
                </div>

                    <%--<div class="form-group row">
                        <div class="col-sm-10">
                            <button type="submit" class="btn btn-primary">Create</button>
                        </div>
                    </div>--%>
            </form>
        </div>
    </div>
    <c:if test="${currentUser.type ne User.STUDENT}">
        <div class="card border border-primary m-2">
            <h5 class="card-header h3 shadow-sm rounded">
                <span class="fa fa-users"></span>
                Participants
                <button type="button" id="submission_submit"
                        class="btn border-0 p-0 bg-transparent text-dark float-right text-cap"
                        data-toggle="tooltip" data-original-title="Update Participants values">
                    <li class="fa fa-save fa-2x"></li>
                </button>
            </h5>
            <c:choose>
                <c:when test="${empty students}">
                    <p class="card-text">You do not have any Participants assigned. Please contact administrator  </p>
                </c:when>
                <c:otherwise>
                    <form id="submission_form" action="submission" method="post">
                        <input type="hidden" name="assignmentId" value="${assignment.id}">
                        <table class="table table-striped">
                            <thead>
                            <tr>
                                <th scope="col">Student Id</th>
                                <th scope="col">First Name</th>
                                <th scope="col">Last Name</th>
                                <th scope="col">Email</th>
                                <th scope="col">Assignment Status</th>
                                <th scope="col">Marks</th>
                                <th scope="col"></th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${students}" var="subject" varStatus="loop">
                                <tr>
                                    <input type="hidden" name="studentIds" value="${subject.id}">
                                    <input type="hidden" name="student[${subject.id}].submissionId" value="${subject.submission.id}">
                                    <th scope="row">${subject.rollNo}</th>
                                    <td>${subject.fName}</td>
                                    <td>${subject.lName}</td>
                                    <td>${subject.email}</td>
                                    <td>
                                        <select class="form-control" name="student[${subject.id}].status">
                                            <option <c:if test="${subject.submission.status eq Submission.PENDING}"> selected </c:if> >${Submission.PENDING} </option>
                                            <option <c:if test="${subject.submission.status eq Submission.SUBMITTED}"> selected </c:if> >${Submission.SUBMITTED} </option>
                                        </select>
                                    <td>
                                        <input class="form-control" type="number"
                                               name="student[${subject.id}].marks"
                                               value="${subject.submission.marks}" min="0" max="100">
                                    </td>
                                    <td>
                                        <a href="admin?action=show&id=${subject.id}" >
                                            <span class="itemRightArrow"></span>
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </form>
                </c:otherwise>
            </c:choose>
        </div>
    </c:if>

    <!-- Bar Graph popup -->
    <div class="modal fade exampleModal " tabindex="-1" role="dialog" aria-labelledby="exampleModal" aria-hidden="true" id="exampleModal">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">${assignment.name} bar graph</h5>
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
    <script type="application/javascript">
        const studentsNames = [];
        <c:forEach items="${students}" var="subject" varStatus="loop">
        studentsNames.push("${subject.fName} ${subject.lName}");
        </c:forEach>
        const studentsMarks = [];
        <c:forEach items="${students}" var="subject" varStatus="loop">
        studentsMarks.push(${subject.submission.marks});
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
                            'rgb(255,109,41)',
                            'rgba(255,46,67,0.71)',
                            'rgba(54,162,235,0.94)',
                            'rgba(255,206,86,0.89)',
                            'rgba(38,222,228,0.9)',
                            'rgba(153,102,255,0.65)',
                            'rgba(0,202,23,0.82)'
                        ],
                        borderColor: [
                            'rgb(175,28,0)',
                            'rgb(255,0,0)',
                            'rgb(0,3,152)',
                            'rgb(184,180,0)',
                            'rgb(0,192,192)',
                            'rgb(26,0,152)',
                            'rgb(22,141,0)'
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
    </script>

    <script type="application/javascript" >
        $( document ).ready(function() {
            $("#submission_submit").click(function () {
                var form = $("#submission_form");
                var url = form.attr('action');
                $("#submit-progress").removeClass("d-none");
                $.ajax({
                    type: "POST",
                    url: url,
                    data: form.serialize(), // serializes the form's elements.
                    success: function(data) {
                        $("#submit-progress").addClass("d-none");
                        //alert(data); // show response from the php script.
                    },
                    complete:function () {
                        $("#alert-message").fadeIn(1000);
                        $("#submit-progress").addClass("d-none");
                        $("#alert-message").text("marks successfully saved!!!");
                        $("#alert-message").removeClass("d-none");
                        $("#alert-message").fadeOut(5000);
                    }
                });
            });
        });
    </script>
</t:template>