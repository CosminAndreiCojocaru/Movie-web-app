<%--
  Created by IntelliJ IDEA.
  User: MLG Y520
  Date: 17.10.2023
  Time: 17:47
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Movies</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
          rel="stylesheet"
          integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
          crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <script src="https://www.youtube.com/iframe_api"></script>

    <style>

        table.table {
            color: white; /* Set text color for the entire table */
        }

        thead.table-header th {
            color: white; /* Set text color for table header */
        }

        tbody.movie-details td {
            color: white; /* Set text color for movie details */
        }


        .movie-image {
            width: 100%;
            max-width: 665px;
            cursor: pointer;
            position: relative;
            opacity: 1; /* Initially fully visible */
            transition: opacity 0.5s; /* Add transition for opacity changes */
        }

        .movie-image:hover {
            opacity: 0.5; /* Fading effect when hovered over */
        }

        .trailer-message {
            position: absolute;
            top: 50%;
            left: 35%;
            transform: translate(-50%, -50%);
            color: rgba(255, 255, 255, 0.45);
            font-size: 18px;
            display: none; /* Initially hidden */
            z-index: 3;
        }

        body {
            margin: 0;
            font: normal 75% Arial, Helvetica, sans-serif;
        }

        #particles-js {
            position: absolute;
            width: 100%;
            height: 500%;
            background-color: #000000;
            background-image: url("");
            background-repeat: no-repeat;
            background-size: cover;
            background-position: 50% 50%;
            z-index: 0;
        }

        .container {
            position: relative;
            z-index: 1;
        }

        .count-particles {
            background: #000022;
            position: absolute;
            top: 48px;
            left: 0;
            width: 80px;
            color: #13E8E9;
            font-size: .8em;
            text-align: left;
            text-indent: 4px;
            line-height: 14px;
            padding-bottom: 2px;
            font-family: Helvetica, Arial, sans-serif;
            font-weight: bold;
            z-index: 2;
        }

        .js-count-particles {
            font-size: 1.1em;
        }

        #stats, .count-particles {
            -webkit-user-select: none;
            margin-top: 5px;
            margin-left: 5px;
        }

        #stats {
            border-radius: 3px 3px 0 0;
            overflow: hidden;
        }

        .count-particles {
            border-radius: 0 0 3px 3px;
        }


        .custom-link {
            background-color: black;
            color: white;
            text-decoration: none; /* optional: remove underline */
        }

        form {
            display: flex; /* Align input and button horizontally */
        }

        /* Style for the search input */
        form input {
            padding: 10px; /* Add padding for better appearance */
        }

        /* Style for the search button */
        form button {
            background-color: black; /* Set the background color to black */
            border: none; /* Remove border */
            padding: 10px; /* Add padding for better appearance */
            cursor: pointer; /* Change cursor to pointer on hover */
        }

        /* Style for the magnifying glass icon */
        form button i {
            color: white; /* Set the color of the icon to white */
        }


    </style>


    <script src="http://cdn.jsdelivr.net/particles.js/2.0.0/particles.min.js"></script>
    <!-- stats.js lib -->
    <script src="http://threejs.org/examples/js/libs/stats.min.js"></script>

</head>

<a href="/movies/genres" class="custom-link">Genres</a>
<body style="background-color: black; color: white;">
<div id="particles-js"></div> <!-- stats - count particles -->
<div class="count-particles"><span class="js-count-particles"></span> </div>

<div class="container">

    <form method="GET" action="/movies/search">
        <input type="text" name="name" placeholder="Enter movie name">
        <button type="submit"><i class="fas fa-search"></i></button>
    </form>

    <script>
        // Add JavaScript validation for the search form
        const form = document.querySelector('form');
        const input = document.querySelector('input[name="name"]');
        form.addEventListener('submit', (event) => {
            if (!input.value) {
                event.preventDefault();
                const error = document.createElement('div');
                error.classList.add('alert', 'alert-danger');
                error.textContent = 'Please enter a movie name';
                form.insertBefore(error, input.nextSibling);
            }
        });
    </script>


    <table class="table table-striped">
        <thead class="table-header">
        <tr>
            <th>Name</th>
            <th>Age</th>
            <th>Likes</th>
            <th>Dislikes</th>
            <th>Rated Percent</th>
        </tr>
        </thead>

        <tbody>
        <c:forEach items="${movies}" var="movie">
            <tr>
                <td><c:out value="${movie.name}"/></td>
                <td><c:out value="${movie.age}"/></td>
                <td>
                    <span id="likes-${movie.id}">${movie.likes}</span>
                    <button class="like-button" data-movie-id="${movie.id}">
                        <i class="fas fa-thumbs-up"></i>
                    </button>
                </td>
                <td>
                    <span id="dislikes-${movie.id}">${movie.dislikes}</span>
                    <button class="dislike-button" data-movie-id="${movie.id}">
                        <i class="fas fa-thumbs-down"></i>
                    </button>
                </td>
                <td>
                    <span class="rated-percent">${String.format("%.2f", (movie.likes / (movie.likes + movie.dislikes)) * 100)}%</span>

                </td>
            </tr>
            <tr>
                <td colspan="4">
                    <div id="video-${movie.id}" style="position: relative;">
                        <c:if test="${movie.id eq 1}">
                            <img src="image/TheShawshankRedemption.jpg" alt="Movie Image" id="image-${movie.id}" class="movie-image"
                                 data-movie-id="${movie.id}" data-video-id="${movie.videoUrls[0]}">
                            <div class="trailer-message">Click on the thumbnail to see the trailer</div>

                        </c:if>

                        <c:if test="${movie.id eq 2}">
                            <img src="image/Godfather.jpg" alt="Movie Image" id="image-${movie.id}" class="movie-image"
                                 data-movie-id="${movie.id}" data-video-id="${movie.videoUrls[0]}">
                            <div class="trailer-message">Click on the thumbnail to see the trailer</div>
                        </c:if>

                        <c:if test="${movie.id eq 3}">
                            <img src="image/PulpFiction.jpg" alt="Movie Image" id="image-${movie.id}" class="movie-image"
                                 data-movie-id="${movie.id}" data-video-id="${movie.videoUrls[0]}">
                            <div class="trailer-message">Click on the thumbnail to see the trailer</div>
                        </c:if>

                        <c:if test="${movie.id eq 4}">
                        <div class="trailer-message">Click on the thumbnail to see the trailer</div>
                            <img src="image/TheDarkKnight.jpg" alt="Movie Image" id="image-${movie.id}" class="movie-image"
                                 data-movie-id="${movie.id}" data-video-id="${movie.videoUrls[0]}">
                        </c:if>

                        <c:if test="${movie.id eq 5}">
                        <div class="trailer-message">Click on the thumbnail to see the trailer</div>
                            <img src="image/DemonSlayerr.jpg" alt="Movie Image" id="image-${movie.id}" class="movie-image"
                                 data-movie-id="${movie.id}" data-video-id="${movie.videoUrls[0]}">
                        </c:if>

                        <c:if test="${movie.id eq 6}">
                        <div class="trailer-message">Click on the thumbnail to see the trailer</div>
                            <img src="image/TheBFG.jpg" alt="Movie Image" id="image-${movie.id}" class="movie-image"
                                 data-movie-id="${movie.id}" data-video-id="${movie.videoUrls[0]}">
                        </c:if>

                    </div>
                </td>
            </tr>

            <tr>
                <td>
                    <ul>
                        <c:forEach items="${movie.genres}" var="genre">
                            <li>${genre.name}</li>
                        </c:forEach>
                    </ul>
                </td>
                <td>
                    <a href="/movies/${movie.id}" class="btn btn-info">Details</a>
                </td>
            </tr>

        </c:forEach>
        </tbody>
    </table>
</div>

<script>
    function onYouTubeIframeAPIReady() {
        <c:forEach items="${movies}" var="movie">
        <c:forEach items="${movie.videoUrls}" var="videoUrl">
        new YT.Player('video-${movie.id}', {
            videoId: '${videoUrl}',
        });
        </c:forEach>
        </c:forEach>
    }


</script>

<script>
    $(document).ready(function () {
        $(".like-button, .dislike-button").click(function () {
            var button = $(this);
            var movieId = button.data("movie-id");
            var action = button.hasClass("like-button") ? "like" : "dislike";

            $.ajax({
                type: "POST",
                url: "/movies/like-dislike",
                data: {
                    movieId: movieId,
                    action: action
                },
                success: function (data) {
                    if (action === "like") {
                        $("#likes-" + movieId).text(data.likes);
                    } else if (action === "dislike") {
                        $("#dislikes-" + movieId).text(data.dislikes);
                    }
                }
            });
        });

        $(".movie-image").hover(
            function () {
                var image = $(this);
                var message = image.siblings('.trailer-message');
                message.fadeIn(); // Show the message on hover
            },
            function () {
                var image = $(this);
                var message = image.siblings('.trailer-message');
                message.fadeOut(); // Hide the message when not hovered
            }
        );


        $(".movie-image").click(function () {
            var image = $(this);
            var movieId = image.data("movie-id");
            var videoId = image.data("video-id");

            // Play the video when the image is clicked
            new YT.Player('video-' + movieId, {
                videoId: videoId,
            });
        });
    });

</script>

<script>// Initialize particles.js
particlesJS('particles-js', {
    "particles": {
        "number": {"value": 80, "density": {"enable": true, "value_area": 800}},
        "color": {"value": "#ffffff"},
        "shape": {
            "type": "circle",
            "stroke": {"width": 0, "color": "#000000"},
            "polygon": {"nb_sides": 5},
            "image": {"src": "img/github.svg", "width": 100, "height": 100}
        },
        "opacity": {
            "value": 0.5,
            "random": false,
            "anim": {"enable": false, "speed": 1, "opacity_min": 0.1, "sync": false}
        },
        "size": {"value": 3, "random": true, "anim": {"enable": false, "speed": 40, "size_min": 0.1, "sync": false}},
        "line_linked": {"enable": true, "distance": 150, "color": "#ffffff", "opacity": 0.4, "width": 1},
        "move": {
            "enable": true,
            "speed": 6,
            "direction": "none",
            "random": false,
            "straight": false,
            "out_mode": "out",
            "bounce": false,
            "attract": {"enable": false, "rotateX": 600, "rotateY": 1200}
        }
    },
    "interactivity": {
        "detect_on": "canvas",
        "events": {
            "onhover": {"enable": true, "mode": "repulse"},
            "onclick": {"enable": true, "mode": "push"},
            "resize": true
        },
        "modes": {
            "grab": {"distance": 400, "line_linked": {"opacity": 1}},
            "bubble": {"distance": 400, "size": 40, "duration": 2, "opacity": 8, "speed": 3},
            "repulse": {"distance": 200, "duration": 0.4},
            "push": {"particles_nb": 4},
            "remove": {"particles_nb": 2}
        }
    },
    "retina_detect": true
});

var count_particles, stats, update;
stats = new Stats;
stats.setMode(0);
stats.domElement.style.position = 'absolute';
stats.domElement.style.left = '0px';
stats.domElement.style.top = '0px';
document.body.appendChild(stats.domElement);
count_particles = document.querySelector('.js-count-particles');
update = function () {
    stats.begin();
    stats.end();
    if (window.pJSDom[0].pJS.particles && window.pJSDom[0].pJS.particles.array) {
        count_particles.innerText = window.pJSDom[0].pJS.particles.array.length;
    }
    requestAnimationFrame(update);
};
requestAnimationFrame(update);
</script>
</body>
</html>
