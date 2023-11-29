package mv.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import mv.model.Genre;
import mv.model.Movies;
import mv.repository.MoviesRepository;

import java.util.List;

@Service
public class MoviesService {

    @Autowired
    private MoviesRepository moviesRepository;

    public Movies getMovieById(int movieId) {
        return moviesRepository.getMovieById(movieId);
    }

    public int likeOrDislikeMovie(int movieId, String action) {
        Movies movie = moviesRepository.getMovieById(movieId);
        if (movie == null) {
            return -1; // Handle the case where the movie with the given ID doesn't exist.
        }

        if ("like".equals(action)) {
            movie.setLikes(movie.getLikes() + 1);
        } else if ("dislike".equals(action)) {
            movie.setDislikes(movie.getDislikes() + 1);
        }

        moviesRepository.updateLikesAndDislikes(movie);

        return "like".equals(action) ? movie.getLikes() : movie.getDislikes();
    }

    public List<Genre> getAllGenres() {
        return moviesRepository.getAllGenres();
    }

    public List<Movies> getMoviesByGenre(int genreId) {
        return moviesRepository.getMoviesByGenre(genreId);
    }

    public List<Movies> getAllMoviesWithVideoUrls() {
        List<Movies> movies = moviesRepository.getAllMovies();
        for (Movies movie : movies) {
            List<String> videoUrls = moviesRepository.getVideoUrlsByMovieId(movie.getId());
            movie.setVideoUrls(videoUrls);
        }
        return movies;
    }


    public Movies getByName(String name){
        Movies movies = moviesRepository.getByName(name);

        return movies;
    }

    public void addComment(int movieId, String comment) {
        moviesRepository.addComment(movieId, comment);
    }

    public List<String> getComments(int movieId) {
        return moviesRepository.getComments(movieId);
    }


}
