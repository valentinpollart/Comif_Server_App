import 'dart:convert';
import 'dart:io';

import 'package:Comif_Server_App/cache/cached_data.dart';
import 'package:Comif_Server_App/models/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;


Future<void> postTransaction(Transaction transaction) async {
  var body = jsonEncode(transaction.toJson());
  debugPrint(body);
  final response  = await http.post(
      'https://comif.fr/api/transactions/sell',
      headers: {HttpHeaders.authorizationHeader: "Bearer " + SharedPrefs.token, HttpHeaders.contentTypeHeader: 'application/json'},
      body: body
      );
  debugPrint(response.body);
  if (response.statusCode == 200) {
    return;
  } else {
    throw Exception('Failed to post transaction');
  }
}

Future<void> postCredit(int clientId, int amount) async {
  final response  = await http.post(
      'https://comif.fr/api/transactions/credit',
      headers: {HttpHeaders.authorizationHeader: "Bearer " + SharedPrefs.token, HttpHeaders.contentTypeHeader: 'application/json'},
      body: jsonEncode({
        'user_id': clientId,
        'amount': amount
      })
  );
  if (response.statusCode == 200) {
    return;
  } else {
    throw Exception('Failed to post credit');
  }
}

Future<List<Transaction>> listUserTransactions(int userId) async {
  final response = await http.get(
    'https://comif.fr/api/transactions/by-user/$userId',
      headers: {HttpHeaders.authorizationHeader: "Bearer " + SharedPrefs.token, HttpHeaders.contentTypeHeader: 'application/json'}
  );
  if (response.statusCode == 200) {
    final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
    return parsed.map<Transaction>((json) => Transaction.fromJson(json)).toList();
  } else {
    throw Exception('Failed to list transaction of user $userId');
  }
}