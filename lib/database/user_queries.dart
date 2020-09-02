import 'dart:convert';

import '../models/user.dart';
import 'package:http/http.dart' as http;


List<User> parseUsers(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<User>((json) => User.fromJson(json)).toList();
}

User infoUser(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<String, dynamic>();
  return User.fromJson(parsed['user']);
}

User getUser(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<String, dynamic>();
  return User.fromJson(parsed);
}