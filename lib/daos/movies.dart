import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:netflux/models/movie.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MovieDao {
  Database? _db;

  Future<void> init() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, "database.db");

    // delete existing if any
    await deleteDatabase(path);

    try {
      await Directory(dirname(path)).create(recursive: true);
    } catch (_) {}
    ByteData data = await rootBundle.load(join("assets", "database.db"));
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(path).writeAsBytes(bytes, flush: true);

    _db = await openDatabase(path, readOnly: true);
  }

  /// get all the words from english dictionary
  Future<List<Movie>> findAll() async {
    if (_db == null) {
      await init();
    }
    List<Map> movies = [];

    await _db?.transaction((txn) async {
      movies = await txn.query(
        "movies",
        columns: [
          "id",
          "title",
          "full_poster_path",
          "backdrop_path",
          "overview",
          "vote_average",
          "release_date",
        ],
      );
    });

    return movies.map((e) => Movie.fromJson(e)).toList();
  }
}
