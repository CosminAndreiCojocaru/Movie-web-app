package siit.repository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import siit.model.Genre;
import siit.model.Movies;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
@Repository
public class MoviesRepository {

    @Autowired
    JdbcTemplate jdbcTemplate;

    public List<Movies> getAllMovies() {
        List<Movies> movies = jdbcTemplate.query("SELECT * FROM Movie", this::extractMovies);
        movies.forEach(this::populateGenresForMovie); // Populate genres for each movie
        return movies;
    }

    public Movies getMovieById(int movieId) {
        String sql = "SELECT * FROM Movie WHERE id = ?";
        Movies movie = jdbcTemplate.queryForObject(sql, new Object[]{movieId}, this::extractMovies);
        if (movie != null) {
            populateGenresForMovie(movie); // Populate genres for the specific movie
        }
        return movie;
    }

    public void updateLikesAndDislikes(Movies movie) {
        String sql = "UPDATE Movie SET likes = ?, dislikes = ? WHERE id = ?";
        jdbcTemplate.update(sql, movie.getLikes(), movie.getDislikes(), movie.getId());
    }

    private Movies extractMovies(ResultSet rs, int rowNumb) throws SQLException {
        int id = rs.getInt("id");
        String name = rs.getString("name");
        int age = rs.getInt("required_age");
        int likes = rs.getInt("likes");
        int dislikes = rs.getInt("dislikes");
        String story = rs.getString("story");

        Movies movie = new Movies(id, name, age, likes, dislikes, story);
        // Genres will be populated separately
        return movie;
    }

    private void populateGenresForMovie(Movies movie) {
        String sql = "SELECT g.id, g.name FROM Genre g " +
                "INNER JOIN movie_genre mg ON g.id = mg.genre_id " +
                "WHERE mg.movie_id = ?";
        List<Genre> genres = jdbcTemplate.query(sql, new Object[]{movie.getId()}, this::extractGenres);
        movie.setGenres(genres);
    }

    private Genre extractGenres(ResultSet rs, int rowNumb) throws SQLException {
        int id = rs.getInt("id");
        String name = rs.getString("name");
        return new Genre(id, name);
    }


    public List<Genre> getAllGenres() {
        String sql = "SELECT DISTINCT g.id, g.name FROM Genre g " +
                "INNER JOIN movie_genre mg ON g.id = mg.genre_id";
        return jdbcTemplate.query(sql, this::extractGenres);
    }

    public List<Movies> getMoviesByGenre(int genreId) {
        String sql = "SELECT m.id, m.name, m.required_age, m.likes, m.dislikes, m.story " +
                "FROM Movie m " +
                "INNER JOIN movie_genre mg ON m.id = mg.movie_id " +
                "WHERE mg.genre_id = ?";
        return jdbcTemplate.query(sql, new Object[]{genreId}, this::extractMovies);
    }

    public List<String> getVideoUrlsByMovieId(int movieId) {
        String sql = "SELECT video_url FROM movie_video WHERE movie_id = ?";
        return jdbcTemplate.queryForList(sql, String.class, movieId);
    }

    public Movies getByName(String name){
        String sql = "SELECT * FROM MOVIE WHERE NAME = ?";

        List<Movies> movies = jdbcTemplate.query(sql, this::extractMovies, name);

        if(movies.isEmpty()){
            return null;
        }
        return movies.get(0);
    }

    public void addComment(int movieId, String comment) {
        String sql = "INSERT INTO movie_comments (movie_id, comment) VALUES (?, ?)";
        jdbcTemplate.update(sql, movieId, comment);
    }

    public List<String> getComments(int movieId) {
        String sql = "SELECT comment FROM movie_comments WHERE movie_id = ?";
        return jdbcTemplate.queryForList(sql, String.class, movieId);
    }




}
