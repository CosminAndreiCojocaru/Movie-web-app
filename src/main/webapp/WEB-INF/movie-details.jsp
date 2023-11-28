<%--
  Created by IntelliJ IDEA.
  User: MLG Y520
  Date: 18.10.2023
  Time: 13:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Movie Details</title>
    <style>
        body {
            background-color: #000000;
            color: #ffffff;
        }

        .container {
            padding: 20px;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>${movie.name} Details</h1>
    <p>Age Requirement: ${movie.age} years and older</p>
    <p>Likes: ${movie.likes}</p>
    <p>Dislikes: ${movie.dislikes}</p>
    <td>
        <p>Rated Percent: <span class="rated-percent">${String.format("%.2f", (movie.likes / (movie.likes + movie.dislikes)) * 100)}%</span></p>
    </td>
    <p>Story: ${movie.story}</p>

    <p>Genres:</p>
    <ul>
        <c:forEach items="${movie.genres}" var="genre">
            <li>${genre.name}</li>
        </c:forEach>
    </ul>

    <h2>Comments</h2>
    <ul id="comments-list">
        <c:forEach items="${movie.comments}" var="comment">
            <li>${comment}</li>
        </c:forEach>
    </ul>

    <textarea name="comments" rows="4" cols="50" placeholder="Write a comment"></textarea>
    <button onclick="updateComments()">Comment</button>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
    function updateComments() {
        var movieId = ${movie.id};
        var commentText = $("textarea[name='comments']").val();

        $.ajax({
            type: "POST",
            url: "/movies/add-comment",
            data: {
                movieId: movieId,
                comment: commentText
            },
            success: function (data) {
                if (data.status === "success") {
                    // Refresh the comments section after a successful update
                    fetchComments(movieId);
                    alert("Comment added successfully!");
                } else {
                    alert("Failed to add comment. Please try again.");
                }
            },
            error: function (xhr, status, error) {
                console.error(xhr.responseText);
            }
        });
    }

    // Function to fetch and update comments
    function fetchComments(movieId) {
        $.ajax({
            type: "GET",
            url: "/movies/fetch-comments",
            data: {
                movieId: movieId
            },
            success: function (data) {
                // Update the comments section
                $("#comments-list").empty(); // Clear existing comments
                $.each(data.comments, function (index, comment) {
                    $("#comments-list").append("<li>" + comment + "</li>");
                });
            },
            error: function (xhr, status, error) {
                console.error(xhr.responseText);
            }
        });
    }

    $(document).ready(function () {
        fetchComments(${movie.id});
    });
</script>

</body>
</html>
