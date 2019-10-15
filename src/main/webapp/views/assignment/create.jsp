<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:template>
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb pb-2 pt-2 m-0 bg-transparent">
            <li class="breadcrumb-item"><a href="lecturer?action=home">Home</a></li>
            <li class="breadcrumb-item"><a href="subject?action=show&id=${subject.id}">${subject.title}</a></li>
            <li class="breadcrumb-item active" aria-current="page">Create Assignment</li>
        </ol>
    </nav>

    <div class="card border border-primary m-2">
        <h5 class="card-header h3 shadow-sm rounded">
            <span class="fa fa-bookmark"></span>
            Create Assignment </h5>

        <div class="card-body rounded bg-light p-4 m-1">
            <form action="assignment" method="post">
                <input type="hidden" name="subjectId" value="${subject.id}">
                <input type="hidden" name="action" value="create">
                <div class="form-group row required">
                    <label for="name" class="col-sm-2 col-form-label required">Assignment Name</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="name" name="name" placeholder="Assignment name" required>
                    </div>
                </div>
                <div class="form-group row required">
                    <label for="name" class="col-sm-2 col-form-label required">Description</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="desc" name="desc" placeholder="Description" required>
                    </div>
                </div>
                <div class="form-group row required">
                    <label for="name" class="col-sm-2 col-form-label required">Due Date</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="due" name="due" placeholder="Due Date" required>
                        <script>
                            $('#due').datepicker({
                                uiLibrary: 'bootstrap4'
                            });
                        </script>
                    </div>
                </div>
                <div class="form-group row required">
                    <label for="name" class="col-sm-2 col-form-label">Maximum grade</label>
                    <div class="col-sm-10">
                        <input type="number" class="form-control" id="maxGrade" name="maxGrade" placeholder="0" required>
                    </div>
                </div>
                <div class="form-group row required">
                    <label for="name" class="col-sm-2 col-form-label">Grade to pass</label>
                    <div class="col-sm-10">
                        <input type="number" class="form-control" id="passingGrade" name="passingGrade" placeholder="0" required>
                    </div>
                </div>

                <div class="form-group row">
                    <div class="col-sm-10">
                        <button type="submit" class="btn btn-primary">Create</button>
                    </div>
                </div>
            </form>
        </div>
    </div>

</t:template>