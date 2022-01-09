import 'package:flutter/material.dart';
import 'package:netflux/models/movie.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({Key? key, required this.movie}) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    double width = 0.4 * MediaQuery.of(context).size.width;
    double height = 0.5 * MediaQuery.of(context).size.height;

    return Container(
        padding: const EdgeInsets.all(10),
        width: width,
        height: height,
        child: Card(
          elevation: 10,
          color: Colors.grey,
          child: Column(children: [
            SizedBox(
                height: height * 0.75,
                child: Ink.image(
                  image: NetworkImage(movie.imageUrl),
                  fit: BoxFit.cover,
                )),
            ListTile(
                title: Text(movie.title),
                subtitle: Text(movie.releaseDate),
                trailing: Text(movie.voteAverage.toString())),
          ]),
        ));
  }
}
