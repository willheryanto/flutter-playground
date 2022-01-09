import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:netflux/models/movie.dart';
import 'dart:convert';

class MovieDAO {
  Future<List<Movie>> searchMovies(String movieTitle) async {
    Uri url = constructUrl('/movies');
    url = url.replace(queryParameters: {'movie_title': movieTitle});

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Failed to get movies');
    }
    List<dynamic> rawMovies =
        jsonDecode(response.body)['movies'].map((movie) => ({
              'id': movie['id'],
              'title': movie['title'],
              'imageUrl': movie['image_url'],
              'overview': movie['overview'],
              'voteAverage': movie['vote_average'],
              'releaseDate': movie['release_date']
            })).toList();

    return rawMovies.map((movie) => Movie.fromJson(movie)).toList();
  }

  Uri constructUrl(String subUrl) {
    final baseUrl = dotenv.env["API_BASE_URL"]!;
    return Uri.parse(baseUrl + subUrl);
  }
}
