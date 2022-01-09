import 'dart:convert';

class Movie {
  final int id;
  final String title;
  final String imageUrl;
  final String overview;
  final double voteAverage;
  final String releaseDate;

  Movie({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.overview,
    required this.voteAverage,
    required this.releaseDate,
  });

  factory Movie.fromJson(Map<dynamic, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      imageUrl: json['imageUrl'],
      overview: json['overview'],
      voteAverage: json['voteAverage'],
      releaseDate: json['releaseDate'],
    );
  }

  static Map<String, dynamic> toMap(Movie movie) => {
        'id': movie.id,
        'title': movie.title,
        'imageUrl': movie.imageUrl,
        'overview': movie.overview,
        'voteAverage': movie.voteAverage,
        'releaseDate': movie.releaseDate,
      };

  static String encode(List<Movie> movies) => json.encode(
        movies
            .map<Map<String, dynamic>>((movie) => Movie.toMap(movie))
            .toList(),
      );

  static List<Movie> decode(String movies) =>
      (jsonDecode(movies) as List<dynamic>)
          .map<Movie>((movie) => Movie.fromJson(movie))
          .toList();
}
