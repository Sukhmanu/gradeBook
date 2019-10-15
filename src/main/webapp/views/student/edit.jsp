<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:template>
    <h1 class="mt-4 text-cap bg-light rounded border border-primary p-4" >
        Edit Student
    </h1>


    <div class="rounded bg-light border border-primary p-4 m-2">
        <form action="admin" method="post">
            <input type="hidden" name ="type" value="student"/>
            <input type="hidden" name ="id" value="${user.id}"/>
            <input type="hidden" name ="operation" value="update"/>
            <div class="form-group row required">
                <label for="rollNo" class="col-sm-2 col-form-label">Student ID</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="rollNo" name ="rollNo" value="${user.rollNo}" required>
                </div>
            </div>
            <div class="form-group row required">
                <label for="firstName" class="col-sm-2 col-form-label">First Name</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="firstName" name="firstName" value="${user.fName}" required data-error-msg="Must enter your name?">
                </div>
            </div>
            <div class="form-group row required">
                <label for="lastName" class="col-sm-2 col-form-label">Last Name</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="lastName" name="lastName" value="${user.lName}" required>
                </div>
            </div>
            <div class="form-group row required">
                <label for="email" class="col-sm-2 col-form-label">Email</label>
                <div class="col-sm-10">
                    <input type="email" class="form-control" id="email" name="email" value="${user.email}" required>
                </div>
            </div>
            <div class="form-group row required">
                <label for="inputPassword3" class="col-sm-2 col-form-label">Password</label>
                <div class="col-sm-10">
                    <input type="password" class="form-control" id="inputPassword3" name="pass" value="${user.password}" required>
                </div>
            </div>
            <div class="form-group row">
                <label for="city" class="col-sm-2 col-form-label">City/Town</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="city" name="city" value="${user.city}">
                </div>
            </div>
            <div class="form-group row">
                <label for="country" class="col-sm-2 col-form-label">Country</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="country" name="country" value="${user.country}">
                </div>
            </div>
            <div class="form-group row">
                <div class="col-sm-10">
                    <button type="submit" class="btn btn-primary">Update</button>
                </div>
            </div>
        </form>
    </div>
</t:template>