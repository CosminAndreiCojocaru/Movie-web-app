<%--
  Created by IntelliJ IDEA.
  User: MLG Y520
  Date: 18.10.2023
  Time: 18:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>

    <title>Movies by Genre</title>
    <style>
        body {
            background-color: #000000; /* Set the background color to black */
            color: #ffffff; /* Set the text color to white */
        }

        .container {
            padding: 20px; /* Add some padding to the container for better visibility */
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Movies by Genre</h1>
    <ul>
        <c:forEach items="${movies}" var="movie">
            <li>${movie.name}</li>
        </c:forEach>
    </ul>
</div>
</body>
</html>

