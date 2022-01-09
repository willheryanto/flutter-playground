import 'package:flutter/material.dart';
import 'package:netflux/const.dart';
import 'package:netflux/daos/movie_dao.dart';
import 'package:netflux/models/movie.dart';

import './components/movie_list.dart';

class SearchResultScreen extends StatefulWidget {
  static const routeName = '/search-result';
  final String query;

  const SearchResultScreen({Key? key, required this.query}) : super(key: key);

  @override
  _SearchResultScreenState createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  late Future<List<Movie>> _movies;
  MovieDAO movieDAO = MovieDAO();

  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _searchController.text = widget.query;

    _movies = movieDAO.searchMovies(_searchController.text);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: const EdgeInsets.all(20),
            child: Column(children: [
              TextFormField(
                decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: mainColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: mainColor),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  labelText: 'Search',
                  labelStyle: TextStyle(color: mainColor),
                ),
                initialValue: _searchController.text,
                onFieldSubmitted: (value) {
                  setState(() {
                    _movies = movieDAO.searchMovies(value);
                  });
                },
              ),
              Expanded(
                  child: FutureBuilder<List<Movie>>(
                      future: _movies,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return MovieList(
                            movies: snapshot.data!,
                            /*scrollController: _scrollController,*/
                          );
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }
                        return const CircularProgressIndicator();
                      }))
            ])));
  }
}
