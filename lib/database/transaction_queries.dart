import 'dart:convert';
import 'dart:io';

import 'package:Comif_Server_App/cache/cached_data.dart';
import 'package:Comif_Server_App/models/transaction.dart';
import 'package:http/http.dart' as http;


Future<void> postTransaction(Transaction transaction) async {
  final response  = await http.post(
      'https://comif.fr/api/products/',
      headers: {HttpHeaders.authorizationHeader: "Bearer " + CachedData.token},
      body: jsonEncode(<String, dynamic>{
        'user_id': transaction.userId,

  }),
  );
}