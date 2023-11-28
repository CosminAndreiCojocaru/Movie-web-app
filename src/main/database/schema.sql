CREATE TABLE movie (
                       id SERIAL PRIMARY KEY,
                       name VARCHAR(255) NOT NULL,
                       required_age INT,
                       likes INT,
                       dislikes INT,
                       story TEXT
);

CREATE TABLE genre (
                       id SERIAL PRIMARY KEY,
                       name VARCHAR(255) NOT NULL
);

CREATE TABLE movie_genre (
                             movie_id INT,
                             genre_id INT,
                             PRIMARY KEY (movie_id, genre_id),
                             FOREIGN KEY (movie_id) REFERENCES movie(id),
                             FOREIGN KEY (genre_id) REFERENCES genre(id)
);

CREATE TABLE movie_video (
                             id SERIAL PRIMARY KEY,
                             movie_id INT,
                             video_url TEXT,
                             FOREIGN KEY (movie_id) REFERENCES movie(id)
);

CREATE TABLE movie_comments (
                                id SERIAL PRIMARY KEY,
                                movie_id INT REFERENCES movie(id),
                                comment TEXT
);


