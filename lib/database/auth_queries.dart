import 'dart:convert';
import 'dart:io';

import 'package:Comif_Server_App/cache/cached_data.dart';
import 'package:flutter/cupertino.dart';
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
    'https://comif.fr/api/users/forgot',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'email': email
    })
  );
}

Future<http.Response> changePassword(String oldPassword, String newPassword, String newPasswordConfirm) {
  return http.post(
      'https://comif.fr/api/users/reset',
      headers: {
        HttpHeaders.authorizationHeader: "Bearer " + SharedPrefs.token,
        'Content-Type': 'application/json'
      },
      body: jsonEncode({
        'old_password': oldPassword,
        'new_password': newPassword,
        'new_password_confirmation': newPasswordConfirm
      })
  );
}
