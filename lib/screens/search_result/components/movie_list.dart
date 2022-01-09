import 'package:flutter/material.dart';
import 'package:netflux/models/movie.dart';
import './movie_card.dart';

class MovieList extends StatefulWidget {
  const MovieList({Key? key, required this.movies}) : super(key: key);
  final List<Movie> movies;

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildMoviesWidget(widget.movies);
  }
}

Widget buildMoviesWidget(List<Movie> movies) {
  return ListView.builder(
    itemCount: movies.length,
    itemBuilder: (context, index) {
    return MovieCard(movie: movies[index]);
    },
  );
  /*return GridView.builder(*/
    /*gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(*/
        /*maxCrossAxisExtent: 200,*/
        /*childAspectRatio: 2 / 1,*/
        /*crossAxisSpacing: 20,*/
        /*mainAxisSpacing: 20),*/
    /*itemCount: movies.length,*/
    /*itemBuilder: (context, index) {*/
      /*return MovieCard(movie: movies[index]);*/
    /*},*/
  /*);*/
}
