<%@tag description="Simple Wrapper Tag" pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<c:set var = "context" value = "${pageContext.request.contextPath}"/>

<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>Gradebook</title>
    <!-- Bootstrap core CSS -->
    <link href='js/bootstrap/css/bootstrap.css' rel="stylesheet">
    <link href='js/bootstrap/bootstrap-select.min.css' rel="stylesheet">
    <link href='css/font-awesome-4.7.0/css/font-awesome.min.css' rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href='css/sidebar.css' rel="stylesheet">
    <!-- Bootstrap core JavaScript -->
    <script src='js/jquery/jquery.min.js'></script>
    <script src='js/bootstrap/js/popper.js'></script>
    <script src='js/bootstrap/js/bootstrap.js'></script>

    <script src='js/bootstrap/bootstrap-select.min.js'></script>
    <script src='js/chartjs/Chart.bundle.min.js'></script>

    <script src='js/gijgo-combined-1.9.13/js/gijgo.min.js'></script>
    <link href='js/gijgo-combined-1.9.13/css/gijgo.min.css' rel="stylesheet">

    <!-- Menu Toggle Script -->
    <script>
        $( document ).ready(function() {
            console.log("ready!");
            $("#menu-toggle").click(function (e) {
                e.preventDefault();
                $("#wrapper").toggleClass("toggled");
            });
            $('[data-toggle="tooltip"]').tooltip();

            $("#alert-message").click(function () {
                $("#alert-message").fadeOut(3000);
            });

        });
    </script>

</head>
<body>
<div class="container-fluid main-page">
    <t:navbar></t:navbar></div>
<div class="d-flex" id="wrapper">
    <!-- /#sidebar-wrapper -->
    <t:sidebar ></t:sidebar>
    <!-- Page Content -->
    <!-- MAIN bODY -->
    <!-- /#page-content-wrapper -->
    <div id="page-content-wrapper">

        <div class="container-fluid">
            <c:if test="${not empty flashMsg}">
                <div id="flash-message" class="alert alert-success " role="alert">
                        ${flashMsg}
                </div>
                <script type="application/javascript">
                    $(document).ready(function() {
                        $("#flash-message").fadeTo(2000, 500).slideUp(500, function() {
                            $("#flash-message").slideUp(500);
                        });
                    });
                </script>
            </c:if>
            <jsp:doBody/>
        </div>
    </div>
</div>
<div id="alert-message" class="alert alert-success d-none" role="alert">
    This is a success alert—check it out!
</div>
<div id="submit-progress" class="submit-progress d-none">
    <i class="fa fa-2x fa-spinner fa-spin"></i>
</div>
</body>
</html>