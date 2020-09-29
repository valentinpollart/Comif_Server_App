import 'dart:convert';

import 'package:http/http.dart' as http;

Future<http.Response> authUser(String email, String password) {
  return http.post(
    'https://comif.fr/api/users/login',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'username': email,
      'password': password,
      'grant_type': 'password',
      'client_id': 1,
      'client_secret': 'secret'
    }),
  );
}

Future<http.Response> forgotPassword(String email) {
  return http.post(
    'https://comif.fr/api/users/login',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'email': email
    })
  );
}
