<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:template>
    <h1 class="mt-4 text-cap bg-light rounded border border-primary p-4" >
        Add Lecturer
    </h1>


    <div class="rounded bg-light border border-primary p-4 m-2">
        <form action="admin" method="post">
            <input type="hidden" name ="type" value="lecturer"/>
            <input type="hidden" name ="rollNo" value="0"/>
           <%-- <div class="form-group row">
                <label for="rollNo" class="col-sm-2 col-form-label">Roll No</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="rollNo" name ="rollNo" placeholder="Roll No">
                </div>
            </div>--%>
            <div class="form-group row required">
                <label for="firstName" class="col-sm-2 col-form-label">First Name</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="firstName" name="firstName" placeholder="First Name" required>
                </div>
            </div>
            <div class="form-group row required">
                <label for="lastName" class="col-sm-2 col-form-label">Last Name</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="lastName" name="lastName" placeholder="Last Name" required>
                </div>
            </div>
            <div class="form-group row required">
                <label for="email" class="col-sm-2 col-form-label">Email</label>
                <div class="col-sm-10">
                    <input type="email" class="form-control" id="email" name="email" placeholder="Email" required>
                </div>
            </div>
            <div class="form-group row required">
                <label for="inputPassword3" class="col-sm-2 col-form-label">Password</label>
                <div class="col-sm-10">
                    <input type="password" class="form-control" id="inputPassword3" name="pass" placeholder="Password" required>
                </div>
            </div>
            <div class="form-group row">
                <label for="city" class="col-sm-2 col-form-label">City/Town</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="city" name="city" placeholder="city">
                </div>
            </div>
            <div class="form-group row">
                <label for="country" class="col-sm-2 col-form-label">Country</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="country" name="country" placeholder="Country">
                </div>
            </div>
            <div class="form-group row">
                <div class="col-sm-10">
                    <button type="submit" class="btn btn-primary">Create</button>
                </div>
            </div>
        </form>
    </div>
</t:template>