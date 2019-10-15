<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:template>
    <style type="text/css">
        .table-dark, .table-dark > th, .table-dark > td {
            background-color: black;
        }
    </style>
    <%--<h1 class="mt-4 text-cap bg-light rounded border border-primary p-4" >
        Grades
    </h1>--%>

    <div class="rounded bg-light border border-primary p-4 m-2">

        <table class="table table-bordered">
            <thead>
            <tr class="table-dark">
                <th scope="col">Grade</th>
                <th scope="col">Defination</th>
                <th scope="col">Mark range</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <th scope="row">HD</th>
                <td>High Distinction</td>
                <td>80 - 100%</td>
            </tr>
            <tr>
                <th scope="row">D</th>
                <td>Distinction</td>
                <td>70 - 79%</td>
            </tr>
            <tr>
                <th scope="row">C</th>
                <td>Credit</td>
                <td>60 - 69%</td>
            </tr>
            <tr>
                <th scope="row">P</th>
                <td>Pass</td>
                <td>50 - 59%</td>
            </tr>
            <tr>
                <th scope="row">F</th>
                <td>Fail</td>
                <td>0 - 49%</td>
            </tr>
            </tbody>
        </table>
    </div>
</t:template>