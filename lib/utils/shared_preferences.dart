import 'package:shared_preferences/shared_preferences.dart';
import 'package:netflux/models/user.dart';
import 'package:netflux/models/movie.dart';
import 'dart:async';

class UserPreferences {
  static Future<void> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString("id", user.id);
    await prefs.setString("username", user.username);
    await prefs.setString("password", user.password);
  }

  static Future<User> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String id = prefs.getString("id") ?? '';
    String username = prefs.getString("username") ?? '';
    String password = prefs.getString("password") ?? '';

    return User(
      id: id,
      username: username,
      password: password,
    );
  }

  static void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("id");
    prefs.remove("username");
    prefs.remove("password");
  }
}

class MoviePreferences {
  static Future<void> saveMovies(List<Movie> movies) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String encodedData = Movie.encode(movies);

    await prefs.setString("movies", encodedData);
  }

  static Future<List<Movie>> getMovies() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String moviesString = prefs.getString("movies") ?? "[]";
    List<Movie> movies = Movie.decode(moviesString);
    return movies;
  }
}
