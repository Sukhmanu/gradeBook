<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:template>
    <div class="card border border-primary m-2">
        <h5 class="card-header h3 shadow-sm rounded">
            <span class="d-inline-block fa fa-book"></span>
            Create Subject </h5>

        <div class="card-body rounded bg-light p-4 m-1">
            <form action="subject" method="post">
                <div class="form-group row required">
                    <label for="title" class="col-sm-2 col-form-label">Title</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="title" name="title" placeholder="Title" required>
                    </div>
                </div>
                <div class="form-group row required">
                    <label for="code" class="col-sm-2 col-form-label">Code</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="code" name="code" placeholder="Code" required>
                    </div>
                </div>
                <div class="form-group row required">
                    <label for="summary" class="col-sm-2 col-form-label">Summary</label>
                    <div class="col-sm-10">
                        <textarea class="form-control" rows="5" id="summary" name="summary" placeholder="Summary" required></textarea>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="detail" class="col-sm-2 col-form-label">Detail</label>
                    <div class="col-sm-10">
                        <textarea class="form-control"  rows="7" id="detail" name="detail" placeholder="Detail"></textarea>
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