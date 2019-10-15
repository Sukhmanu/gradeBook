<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<t:template>
<nav aria-label="breadcrumb">
  <ol class="breadcrumb pb-2 pt-2 m-0 bg-transparent">
    <li class="breadcrumb-item">
    	<a href="lecturer?action=home">Home</a>
    </li>
    <li class="breadcrumb-item">
    	<a href="subject?action=show&id=${assignment.subject.id}">${assignment.subject.title}</a>
    </li>
    <li class="breadcrumb-item active" aria-current="page" >
    	<a href="assignment?action=show&id=${assignment.id}">${assignment.name}</a>
    </li>
  </ol>
</nav>
    <div class="card border border-primary m-2">
        <h5 class="card-header h3 shadow-sm rounded">
            <span class="fa fa-bookmark"></span>
            Edit Assignment for ${assignment.subject.title} subject </h5>

        <div class="card-body rounded bg-light p-4 m-1">
            <form action="assignment" method="post">
                <input type="hidden" name="subjectId" value="${assignment.subject.id}">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="id" value="${assignment.id}">
                <div class="form-group row">
                    <label for="name" class="col-sm-2 col-form-label">Assignment name</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="name" name="name" value="${assignment.name}" required>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="name" class="col-sm-2 col-form-label">Description</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="desc" name="desc" value="${assignment.description}" required>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="name" class="col-sm-2 col-form-label">Due dueDate</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="due" name="due" value='<fmt:formatDate pattern = "MM/dd/YYYY"
         value = "${assignment.dueDate}" />' required>
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
                        <input type="number" class="form-control" id="maxGrade" name="maxGrade" value="${assignment.maxGrade}" required>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="name" class="col-sm-2 col-form-label">Grade to pass</label>
                    <div class="col-sm-10">
                        <input type="number" class="form-control" id="passingGrade" name="passingGrade" value="${assignment.passingGrade}" required>
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