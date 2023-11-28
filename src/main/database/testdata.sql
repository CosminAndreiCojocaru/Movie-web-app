-- Inserting movies
INSERT INTO movie (name, required_age, likes, dislikes, story)
VALUES ('The Shawshank Redemption', 18, 1000, 50,
        'Andy Dufresne, a successful banker, is arrested for the murders of his wife and her lover, and is sentenced to life imprisonment at the Shawshank prison. He becomes the most unconventional prisoner.');

INSERT INTO movie (name, required_age, likes, dislikes, story)
VALUES ('The Godfather', 18, 900, 60, 'Don Vito Corleone, head of a mafia family, decides to hand over his empire to his youngest son Michael. However, his decision unintentionally puts the lives of his loved ones in grave danger.');

INSERT INTO movie (name, required_age, likes, dislikes, story)
VALUES ('Pulp Fiction', 17, 850, 70, 'In the realm of underworld, a series of incidents intertwines the lives of two Los Angeles mobsters, a gangster`s wife, a boxer and two small-time criminals.');

INSERT INTO movie (name, required_age, likes, dislikes, story)
VALUES ('The Dark Knight', 13, 1200, 100, 'When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.');

INSERT INTO movie (name, required_age, likes, dislikes, story)
VALUES ('Demon Slayer: Kimetsu no Yaiba - The Movie: Mugen Train', 18, 1000, 50, 'After his family was brutally murdered and his sister turned into a demon, Tanjiro Kamado`s journey as a demon slayer began. Tanjiro and his comrades embark on a new mission aboard the Mugen Train, on track to despair.');

INSERT INTO movie (name, required_age, likes, dislikes, story)
VALUES ('The BFG', 18, 1000, 50, 'An orphan little girl befriends a benevolent giant who takes her to Giant Country, where they attempt to stop the man-eating giants that are invading the human world.');

-- Inserting genres
INSERT INTO genre (name)
VALUES ('Drama');

INSERT INTO genre (name)
VALUES ('Crime');

INSERT INTO genre (name)
VALUES ('Action');

INSERT INTO genre (name)
VALUES ('Animation');

INSERT INTO genre (name)
VALUES ('Adventure');

INSERT INTO genre (name)
VALUES ('Fantasy');

-- Link movies to genres
INSERT INTO movie_genre (movie_id, genre_id)
VALUES (1, 1); -- The Shawshank Redemption (Drama)
INSERT INTO movie_genre (movie_id, genre_id)
VALUES (1, 2); -- The Shawshank Redemption (Crime)

INSERT INTO movie_genre (movie_id, genre_id)
VALUES (2, 1); -- The Godfather (Drama)
INSERT INTO movie_genre (movie_id, genre_id)
VALUES (2, 2); -- The Godfather (Crime)

INSERT INTO movie_genre (movie_id, genre_id)
VALUES (3, 1); -- Pulp Fiction (Drama)
INSERT INTO movie_genre (movie_id, genre_id)
VALUES (3, 3); -- Pulp Fiction (Action)

INSERT INTO movie_genre (movie_id, genre_id)
VALUES (4, 1);
INSERT INTO movie_genre (movie_id, genre_id)
VALUES (4, 3);

INSERT INTO movie_genre (movie_id, genre_id)
VALUES (5, 3);
INSERT INTO movie_genre (movie_id, genre_id)
VALUES (5, 4);
INSERT INTO movie_genre (movie_id, genre_id)
VALUES (5, 5);

INSERT INTO movie_genre (movie_id, genre_id)
VALUES (6, 5);
INSERT INTO movie_genre (movie_id, genre_id)
VALUES (6, 7);

INSERT INTO movie_video (movie_id, video_url) VALUES (1, 'PLl99DlL6b4');
INSERT INTO movie_video (movie_id, video_url) VALUES (2, 'UaVTIH8mujA');
INSERT INTO movie_video (movie_id, video_url) VALUES (3, 's7EdQ4FqbhY');
INSERT INTO movie_video (movie_id, video_url) VALUES (4, 'EXeTwQWrcwY');
INSERT INTO movie_video (movie_id, video_url) VALUES (5, 'bFwdl2PDAFM');
INSERT INTO movie_video (movie_id, video_url) VALUES (6, 'y1fZg0hhBX8');

