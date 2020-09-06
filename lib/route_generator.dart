import 'package:Comif_Server_App/cache/cached_data.dart';
import 'package:Comif_Server_App/screens/invoice_builder.dart';
import 'package:Comif_Server_App/screens/login.dart';
import 'package:Comif_Server_App/screens/random_words.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Map<String, dynamic> args = settings.arguments;
    switch (settings.name) {
      case '/':
        if (CachedData.isLogged()) {
          return generateRoute(RouteSettings(name: '/invoice'));
        }
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/invoice':
        return MaterialPageRoute(builder: (_) => InvoiceBuilderScreen());
    }
  }
}