<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="com.moodle.gradebook.bean.Submission" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="list" uri="http://listFun"%>
<%@ page import="com.moodle.gradebook.bean.User" %>


<t:template>
    <c:if test="${shared eq 0}">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb pb-2 pt-2 m-0 bg-transparent">
                <li class="breadcrumb-item"><a href="lecturer?action=home">Home</a></li>
                <li class="breadcrumb-item"><a href="subject?action=show&id=${subject.id}">${subject.title}</a></li>
                <li class="breadcrumb-item active" aria-current="page"> Reports </li>
            </ol>
        </nav>
    </c:if>

    <div class="card border border-primary m-2" id="print">
        <h5 class="card-header h3 shadow-sm rounded">
            <span class="fa fa-table"></span>
                ${subject.title} students marks sheet
            <c:if test="${currentUser.type ne User.STUDENT}">
                <c:if test="${shared eq 0}">
                    <a class="btn border-0 p-0 bg-transparent text-dark float-right"
                       style="margin-top: 8px;margin-right: 10px;" href="#shareModal" data-toggle="modal" data-target="#shareModal">
                        <li class="fa fa-share fa-2x"></li>
                    </a>
                </c:if>
                <a class="btn border-0 p-0 bg-transparent text-dark float-right"
                   style="margin-top: 8px;margin-right: 10px;" href="#exampleModal" data-toggle="modal" data-target="#exampleModal">
                    <li class="fa fa-bar-chart fa-2x"></li>
                </a>

                <a class="btn border-0 p-0 bg-transparent text-dark float-right" id="btnPrint"
                   style="margin-top: 8px;margin-right: 10px;"  >
                    <li class="fa fa-file-pdf-o fa-2x"></li>
                </a>


            </c:if>
        </h5>

        <table class="table table-striped">
            <thead>
            <tr>
                <th scope="col">Student Id</th>
                <th scope="col">First Name</th>
                <th scope="col">Last Name</th>
                <th scope="col">Email</th>
                <th scope="col">Total Marks</th>
                <th scope="col">Marks Obtained</th>
                <th scope="col">Percentage</th>
                <th scope="col">Grade</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${students}" var="subject" varStatus="loop">
                <tr>
                    <th scope="row">${subject.rollNo}</th>
                    <td>${subject.fName}</td>
                    <td>${subject.lName}</td>
                    <td>${subject.email}</td>
                    <td>${subject.totalMarks}</td>
                    <td>${subject.obtainMarks}</td>
                    <td><fmt:formatNumber type = "percent" maxIntegerDigits="3" value = "${subject.getPercentage() /100}" /></td>
                    <td>${subject.grade}</td>
                </tr>
            </c:forEach>
            <tr>
            </tbody>
        </table>
    </div>

    <div class="card border border-primary m-2">
        <h5 class="card-header h3 shadow-sm rounded">
            <span class="fa fa-table"></span>
                ${subject.title} Grade Report
            <c:if test="${currentUser.type ne User.STUDENT}">
                <a class="btn border-0 p-0 bg-transparent text-dark float-right"
                   style="margin-top: 8px;margin-right: 10px;" href="#exampleModal" data-toggle="modal" data-target="#exampleModal">
                    <li class="fa fa-bar-chart fa-2x"></li>
                </a>
            </c:if>
        </h5>

        <table class="table table-striped">
            <thead>
            <tr>
                <th scope="col">Grade</th>
                <th scope="col">No of students</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${grades}" var="grade" varStatus="loop">
                <tr>
                    <td>${grade.gradeCode}</td>
                    <td>${grade.count}</td>
                </tr>
            </c:forEach>
            <tr>
            </tbody>
        </table>
    </div>

    <!-- Share report popup -->
    <div class="modal fade shareModal" tabindex="-1" role="dialog" aria-labelledby="shareModal" aria-hidden="true" id="shareModal">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="shareModalLabel">
                        <span class="fa fa-share"></span>
                        Share Report
                    </h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="card-body rounded bg-light p-4 m-1">
                        <form action="report?action=update" method="post" class="m-b-0" id = "share_rpt_frm">
                            <input type="hidden" name="subject_id"  value="${subject.id}">

                            <div class="form-group row">
                                <label for="lecturers" class="col-sm-2 col-form-label">Share With</label>
                                <div class="col-sm-10">
                                    <select class="form-control selectpicker" id="lecturers" name="lecturers" multiple>
                                        <c:forEach items="${lecturers}" var="lecturer">
                                            <option value="${lecturer.id}"
                                                    <c:if test="${list:contains(reportSharedWith,lecturer )}"> selected </c:if>
                                            >
                                                    ${lecturer.fName} ${lecturer.lName}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" id="share_rpt_btn">
                        <span class="fa fa-share"></span>
                        Share</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Bar Graph popup -->
    <div class="modal fade exampleModal " tabindex="-1" role="dialog" aria-labelledby="exampleModal" aria-hidden="true" id="exampleModal">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">
                        <span class="fa fa-bar-chart-o"></span>
                            ${subject.title} Grade Graph</h5>

                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <canvas id="myChart" width="800" height="400"></canvas>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">
                        <span class="fa fa-download"></span>
                        Download</button>
                </div>
            </div>
        </div>
    </div>
    <script type="application/javascript">
        const grades = [];
        const gradesCount = [];
        <c:forEach items="${grades}" var="grade" varStatus="loop">
        grades.push("${grade.gradeCode}");
        gradesCount.push(${grade.count});
        </c:forEach>

        $( document ).ready(function() {
            var ctx = document.getElementById('myChart');
            var myChart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: grades,
                    datasets: [{
                        label: 'No Of Students',
                        data: gradesCount,
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
                    title: {
                        display: true,
                        text: '${subject.title} Grade Chart',
                        fontSize: 30,
                        position:'bottom'
                    },
                    scales: {
                        yAxes: [{
                            ticks: {
                                beginAtZero: true,
                                stepSize: 1
                            },
                            scaleLabel: {
                                display: true,
                                labelString: 'No of Students',
                            },
                        }],
                        xAxes: [{
                            ticks: {
                                beginAtZero: true,
                                stepSize: 1
                            },
                            scaleLabel: {
                                display: true,
                                labelString: 'Grades',
                            },
                        }]
                    },
                    responsive: true
                }
            });
        });
    </script>

    <script type="text/javascript">
        $( document ).ready(function() {

            $("#share_rpt_btn").click(function () {
                var form = $("#share_rpt_frm");
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
                        $("#alert-message").text("Report successfully Shared!!!");
                        $("#alert-message").removeClass("d-none");
                        $("#alert-message").fadeOut(5000);
                    }
                });
            });

            $("#btnPrint").click(function () {
                var divContents = $("#print").html();
                var printWindow = window.open('', '', 'height=900,width=1240');
                printWindow.document.write('<html><head><title>Report</title>');
                printWindow.document.write('</head><body >');
                printWindow.document.write(divContents);
                printWindow.document.write('</body></html>');
                printWindow.document.close();
                printWindow.print();
            });
        });


    </script>
</t:template>