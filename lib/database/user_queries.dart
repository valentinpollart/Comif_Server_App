import 'dart:convert';
import 'dart:io';
import 'package:Comif_Server_App/cache/cached_data.dart';

import '../models/user.dart';
import 'package:http/http.dart' as http;


Future<List<User>> parseUsers() async {
  final response = await http.get(
      'https://comif.fr/api/users/',
      headers: {HttpHeaders.authorizationHeader: "Bearer " + SharedPrefs.token}
  );
  if (response.statusCode == 200) {
    final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
    return parsed.map<User>((json) => User.fromJson(json)).toList();
  } else {
    throw Exception('Failed to get user list');
  }
}

Future<List<User>> searchUser(String search) async {
  final users = await parseUsers();
  users.removeWhere((user) => !user.lastName.toLowerCase().contains(search.toLowerCase()) && !user.firstName.toLowerCase().contains(search.toLowerCase()));
  users.sort((User user1, User user2) => user1.lastName.compareTo(user2.lastName));
  return users;
}

Future<User> infoUser() async {
  final response = await http.get(
    'https://comif.fr/api/users/info',
    headers: {HttpHeaders.authorizationHeader: "Bearer " + SharedPrefs.token}
  );
  if (response.statusCode == 200) {
    final parsed = jsonDecode(response.body).cast<String, dynamic>();
    return User.fromJson(parsed['user']);
  } else {
    throw Exception('Failed to get user info');
  }
}

User getUser(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<String, dynamic>();
  return User.fromJson(parsed);
}

