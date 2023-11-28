
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Movie Genres</title>
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
    <h1>Movie Genres</h1>
    <ul>
        <c:forEach items="${genres}" var="genre">
            <li>
                <a href="/movies/genres/${genre.id}">${genre.name}</a>
            </li>
        </c:forEach>
    </ul>
</div>

</body>
</html>
