package siit.model;

import javax.persistence.Column;
import java.util.List;

public class Movies {

    private int id;
    private String name;
    private int age;
    private int likes;
    private int dislikes;
    private String story;
    private List<Genre> genres;
    private List<String> videoUrls;
    private String comments;

    public Movies(int id, String name, int age, int likes, int dislikes, String story) {
        this.id = id;
        this.name = name;
        this.age = age;
        this.likes = likes;
        this.dislikes = dislikes;
        this.story = story;
    }

    public int getId(){
        return id;
    }

    public void setId(int id){
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public int getLikes() {
        return likes;
    }

    public void setLikes(int likes) {
        this.likes = likes;
    }

    public int getDislikes() {
        return dislikes;
    }

    public void setDislikes(int dislikes) {
        this.dislikes = dislikes;
    }

    public String getStory() {
        return story;
    }

    public void setStory(String story) {
        this.story = story;
    }

    public List<Genre> getGenres() {
        return genres;
    }

    public void setGenres(List<Genre> genres) {
        this.genres = genres;
    }

    public List<String> getVideoUrls() {
        return videoUrls;
    }

    public void setVideoUrls(List<String> videoUrls) {
        this.videoUrls = videoUrls;
    }

    public String getComments() {
        return comments;
    }

    public void setComments(String comments) {
        this.comments = comments;
    }

    @Override
    public String toString() {
        return "Movies{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", age=" + age +
                ", likes=" + likes +
                ", dislikes=" + dislikes +
                ", story='" + story + '\'' +
                '}';
    }
}
