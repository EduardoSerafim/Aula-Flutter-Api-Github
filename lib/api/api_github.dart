import 'dart:convert';

import '../models/user.dart';
import 'package:http/http.dart' as http;

class GithubApi {
  final baseUrl = 'https://api.github.com/';

  Future<User?> getUser(String userName) async {
    final uri = '${baseUrl}users/$userName';
    final response = await http.get(Uri.parse(uri));

    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);
      final user = User.fromJson(json);
      return user;
    }

    return null;
  }

  Future<List<User>> listFollowing(String userName) async {
    final uri = '${baseUrl}users/$userName/following';
    final response = await http.get(Uri.parse(uri));

    if (response.statusCode == 200) {
      var listJson = jsonDecode(response.body);
      var users = listJson.map<User>((json) => User.fromJson(json)).toList();
      return users;
    }

    return [];
  }
}
