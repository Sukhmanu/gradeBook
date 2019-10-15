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
            <li class="breadcrumb-item active" aria-current="page"> My Report </li>
        </ol>
    </nav>

    <div class="card border border-primary m-2" id="print">
        <h5 class="card-header h3 shadow-sm rounded">
            <span class="fa fa-table"></span>
                My marks sheet
            <c:if test="${currentUser.type eq User.STUDENT}">
                <a class="btn border-0 p-0 bg-transparent text-dark float-right"
                   style="margin-top: 8px;margin-right: 10px;" href="#exampleModal" data-toggle="modal" data-target="#exampleModal">
                    <li class="fa fa-bar-chart fa-2x"></li>
                </a>

               <%-- <a class="btn border-0 p-0 bg-transparent text-dark float-right" id="btnPrint"
                   style="margin-top: 8px;margin-right: 10px;"  >
                    <li class="fa fa-file-pdf-o fa-2x"></li>
                </a>--%>
            </c:if>
        </h5>

        <table class="table table-striped">
            <thead>
            <tr>
                <th scope="col">Subject name</th>
                <th scope="col">Marks Obtained</th>
                <th scope="col">Total Marks</th>
                <th scope="col">Percentage</th>
                <th scope="col">Grade</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${subjects}" var="subject" varStatus="loop">
                <tr>
                    <th scope="row">${subject.title}</th>
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

    <!-- Bar Graph popup -->
    <div class="modal fade exampleModal " tabindex="-1" role="dialog" aria-labelledby="exampleModal" aria-hidden="true" id="exampleModal">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">My Report Chart</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <canvas id="myChart" width="800" height="400"></canvas>
                </div>

            </div>
        </div>
    </div>
    <script type="application/javascript">
        const subjects = [];
        const marks = [];
        <c:forEach items="${subjects}" var="subject" varStatus="loop">
        subjects.push("${subject.title}");
        marks.push(${subject.getPercentage()});
        </c:forEach>

        $( document ).ready(function() {
            var ctx = document.getElementById('myChart');
            var myChart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: subjects,
                    datasets: [{
                        label: 'My Report',
                        data: marks,
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
                                beginAtZero: true,
                                max: 100,
                                callback: function (value) {
                                    return (value).toFixed(0) + '%'; // convert it to percentage
                                },

                            },
                            scaleLabel: {
                                display: true,
                                labelString: 'Percentage',
                            },
                        }],
                        xAxes: [{
                            ticks: {
                                beginAtZero: true
                            },
                            scaleLabel: {
                                display: true,
                                labelString: 'Subjects',
                            },
                        }]
                    },
                    responsive: true
                }
            });
        });
    </script>

    <script type="text/javascript">
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
    </script>
</t:template>