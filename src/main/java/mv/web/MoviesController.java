package mv.web;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import mv.model.Movies;
import mv.service.MoviesService;

import java.util.*;

@Controller
@RequestMapping(path = "/movies")
@RestController
public class MoviesController {

    @Autowired
    private MoviesService moviesService;

    @RequestMapping(method = RequestMethod.GET)
    public ModelAndView renderMoviesList() {
        ModelAndView mav = new ModelAndView("movies-list");
        mav.addObject("movies", moviesService.getAllMoviesWithVideoUrls());
        return mav;
    }

    @GetMapping("/{movieId}")
    public ModelAndView renderMovieDetails(@PathVariable int movieId) {
        Movies movie = moviesService.getMovieById(movieId);
        if (movie == null) {
            // Handle the case where the movie with the given ID doesn't exist.
            return new ModelAndView("error-page"); // Provide an error page or message.
        }
        ModelAndView mav = new ModelAndView("movie-details");
        mav.addObject("movie", movie);
        return mav;
    }


    @PostMapping("/like-dislike")
    @ResponseBody
    public Map<String, Integer> likeOrDislike(@RequestParam("movieId") int movieId, @RequestParam("action") String action) {
        int updatedLikes = 0;
        int updatedDislikes = 0;

        if ("like".equals(action)) {
            updatedLikes = moviesService.likeOrDislikeMovie(movieId, "like");
        } else if ("dislike".equals(action)) {
            updatedDislikes = moviesService.likeOrDislikeMovie(movieId, "dislike");
        }

        Map<String, Integer> response = new HashMap<>();
        response.put("likes", updatedLikes);
        response.put("dislikes", updatedDislikes);
        return response;
    }

    @GetMapping("/genres")
    public ModelAndView renderGenreList() {
        ModelAndView mav = new ModelAndView("genre-list");
        mav.addObject("genres", moviesService.getAllGenres());
        return mav;
    }

    @GetMapping("/genres/{genreId}")
    public ModelAndView renderMoviesByGenre(@PathVariable int genreId) {
        List<Movies> movies = moviesService.getMoviesByGenre(genreId);
        ModelAndView mav = new ModelAndView("movies-by-genre");
        mav.addObject("movies", movies);
        return mav;
    }

    @RequestMapping(method = RequestMethod.GET, path = "/search")
    public ModelAndView searchStudentByName(@RequestParam("name") String name){
        ModelAndView mav = new ModelAndView("movies-list");
        Movies movies = moviesService.getByName(name);

        if(movies != null ){
            mav.addObject("movies", Collections.singletonList(movies));
        } else{
            mav.addObject("errorMessage", "Movie with name " + name + " not found.");
        }
        return mav;
    }

    @RequestMapping(value = "/add-comment", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, String> addComment(@RequestParam("movieId") int movieId, @RequestParam("comment") String comment) {
        Map<String, String> response = new HashMap<>();

        try {
            // Call your service method to add a comment to the database
            moviesService.addComment(movieId, comment);

            response.put("status", "success");
        } catch (Exception e) {
            response.put("status", "error");
        }

        return response;
    }

    @RequestMapping(value = "/fetch-comments", method = RequestMethod.GET)
    @ResponseBody
    public Map<String, List<String>> fetchComments(@RequestParam("movieId") int movieId) {
        Map<String, List<String>> response = new HashMap<>();

        try {
            // Call your service method to fetch comments from the database
            List<String> comments = moviesService.getComments(movieId);

            response.put("comments", comments);
        } catch (Exception e) {
            response.put("comments", Collections.emptyList());
        }

        return response;
    }





}
