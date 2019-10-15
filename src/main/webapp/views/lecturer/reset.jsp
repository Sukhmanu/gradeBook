<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<t:template>

    <script type="text/javascript">
        $( document ).ready(function() {
            $("#resetForm").submit(function (event) {
                //alert( "Handler for .submit() called." );
                const oldPass = $("#oldPass").val();
                const newPass = $("#newPass").val();
                const repeatPass = $("#repeatPass").val();

                $("#oldPass").removeClass("is-invalid");
                $("#newPass").removeClass("is-invalid");
                $("#repeatPass").removeClass("is-invalid");

                if (oldPass == "") {
                    $("#oldPass").addClass("is-invalid");
                    $('#oldPass_err_msg').text("Current Password can't be blank !!!")
                } else if (newPass == "") {
                    $("#newPass").addClass("is-invalid");
                } else if (newPass != repeatPass) {
                    $("#repeatPass").addClass("is-invalid");
                } else {
                    return true;
                }

                event.preventDefault();
            });
        });
    </script>

    <style type="text/css">
        .input-group-text{
            font-family: var(--Montserrat);
        }
        .fa-passwd-reset > .fa-lock {
            font-size: 0.85rem;
        }
    </style>
    <c:if test="${not empty err_msg}">
        <div class="alert alert-danger" >
           ${err_msg}
        </div>
    </c:if>

    <div class="card border border-primary m-2">
        <form action="lecturer" class="m-0" method="post" id="resetForm">
            <h5 class="card-header h3 shadow-sm rounded">
                Change Password

                <button type="submit" class="btn border-0 p-0 bg-transparent text-dark float-right text-cap">
                        <%--<li class="fa fa-lock fa-2x"></li>--%>
                    <span class="fa-passwd-reset fa-stack">
                        <i class="fa fa-undo fa-stack-2x"></i>
                        <i class="fa fa-lock fa-stack-1x"></i>
                    </span>
                </button>
            </h5>

            <div class="card-body bg-light rounded m-1 p-3">

                <input type="hidden" name ="type" value="lecturers"/>
                <input type="hidden" name ="action" value="reset"/>
                <input type="hidden" name ="userId" value="${currentUser.id}"/>

                <div class="form-group row">
                    <label for="oldPass" class="col-sm-2 col-form-label">Current Password</label>
                    <div class="col-sm-10">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <div class="input-group-text">
                                    <i class="fa fa-key" aria-hidden="true"></i>
                                </div>
                            </div>
                            <input type="password" class="form-control " id="oldPass" name="oldPass" >
                            <div class="invalid-feedback" id="oldPass_err_msg">
                                Incorrect password!!! Please fill your current password.
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="newPass" class="col-sm-2 col-form-label">New Password</label>
                    <div class="col-sm-10">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <div class="input-group-text">
                                    <i class="fa fa-key" aria-hidden="true"></i>
                                </div>
                            </div>
                            <input type="password" class="form-control" id="newPass" name="newPass" >
                            <div class="invalid-feedback" id="newPass_err_msg">
                                New password can't be blank.
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="RepeatPass" class="col-sm-2 col-form-label">Repeat Password</label>
                    <div class="col-sm-10">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <div class="input-group-text">
                                    <i class="fa fa-key" aria-hidden="true"></i>
                                </div>
                            </div>
                            <input type="password" class="form-control" id="repeatPass" name="RepeatPass" >
                            <div class="invalid-feedback" id="repeatPass_err_msg">
                                Repeat Password do not match with new password!!!
                            </div>
                        </div>
                    </div>
                </div>

                <div class="form-group row">
                    <div class="col-sm-10">
                        <button type="submit" class="btn btn-primary">
                            <span class="fa-passwd-reset fa-stack border-0 m-0">
                                <i class="fa fa-undo fa-stack-2x"></i>
                                <i class="fa fa-lock fa-stack-1x"></i>
                            </span>
                            Reset Password
                        </button>
                    </div>
                </div>

            </div>
        </form>
    </div>
</t:template>