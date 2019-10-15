<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>

<t:template>
    <h1 class="mt-4 text-cap bg-light rounded border border-primary heading" >
       ${type} List
      <a class="btn btn-success btn-dark float-right text-cap"
      style="margin-top: 8px;" href="admin?action=create&type=${type}">Add ${type}</a>
    </h1>

    <ul class="list-group">
        <c:forEach items="${users}" var="user" varStatus="loop">
            <a href="admin?action=show&id=${user.id}" >
            <li class="list-group-item d-flex justify-content-between
             align-items-center list-group-item-action bg-light">

                ${user.fName}, ${user.lName} - ${user.email}

                <span class="itemRightArrow"></span>
            </li>
            </a>
        </c:forEach>
    </ul>
</t:template>