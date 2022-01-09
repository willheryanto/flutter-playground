import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:netflux/models/user.dart';
import 'dart:convert';

class UserDAO {
  Future<Map<String, dynamic>> login(String username, String password) async {
    Uri url = constructUrl('/sessions');
    final response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'username': username, 'password': password}));

    if (response.statusCode != 200) {
      return {'status': false, 'message': 'Invalid username or password'};
    }
    return {'status': true, 'message': ''};
  }

  Future<Map<String, dynamic>> register(
      String username, String password) async {
    Uri url = constructUrl('/users');
    final response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'username': username, 'password': password}));

    if (response.statusCode != 200) {
        print(response.body);
      return {'status': false, 'message': 'User already exists'};
    }
    return {'status': true, 'message': ''};
  }

  Uri constructUrl(String subUrl) {
    final baseUrl = dotenv.env["API_BASE_URL"]!;
    return Uri.parse(baseUrl + subUrl);
  }
}
