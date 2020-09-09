import 'dart:convert';
import 'dart:io';

import 'package:Comif_Server_App/cache/cached_data.dart';
import 'package:Comif_Server_App/models/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;


Future<void> postTransaction(Transaction transaction) async {
  debugPrint(jsonEncode(transaction.toJson()).toString());
  final response  = await http.post(
      'https://comif.fr/api/transactions/sell',
      headers: {HttpHeaders.authorizationHeader: "Bearer " + SharedPrefs.token, HttpHeaders.contentTypeHeader: 'application/json'},
      body: jsonEncode(transaction.toJson())
      );
  debugPrint(response.body);
  if (response.statusCode == 200) {
    return;
  } else {
    throw Exception('Failed to post transaction');
  }
}