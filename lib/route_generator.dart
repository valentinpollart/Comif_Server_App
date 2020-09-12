import 'package:Comif_Server_App/cache/cached_data.dart';
import 'package:Comif_Server_App/screens/credit.dart';
import 'package:Comif_Server_App/screens/invoice_builder.dart';
import 'package:Comif_Server_App/screens/invoice_confirmation.dart';
import 'package:Comif_Server_App/screens/login.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        if (SharedPrefs.isLogged()) {
          return MaterialPageRoute(builder: (_) => InvoiceBuilderScreen());
        }
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/main':
        return MaterialPageRoute(builder: (_) => InvoiceBuilderScreen());
      case '/invoice':
        return MaterialPageRoute(builder: (_) => InvoiceBuilderScreen());
      case '/invoice_confirmation':
        return MaterialPageRoute(builder: (_) => InvoiceConfirmationScreen());
      case '/credit':
        return MaterialPageRoute(builder: (_) => CreditScreen());
      default:
        return generateRoute(RouteSettings(name: '/invoice'));
    }
  }
}