import 'package:Comif_Server_App/cache/cached_data.dart';

import 'package:Comif_Server_App/screens/admin/credit.dart';
import 'package:Comif_Server_App/screens/shared/change_password.dart';
import 'package:Comif_Server_App/screens/shared/forgot_password.dart';
import 'package:Comif_Server_App/screens/shared/home.dart';
import 'package:Comif_Server_App/screens/admin/invoice_builder.dart';
import 'package:Comif_Server_App/screens/admin/invoice_confirmation.dart';
import 'package:Comif_Server_App/screens/shared/about.dart';
import 'package:Comif_Server_App/screens/shared/account.dart';
import 'package:Comif_Server_App/screens/shared/login.dart';
import 'package:Comif_Server_App/screens/shared/transactions.dart';
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
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/invoice':
        return MaterialPageRoute(builder: (_) => InvoiceBuilderScreen());
      case '/invoice_confirmation':
        return MaterialPageRoute(builder: (_) => InvoiceConfirmationScreen());
      case '/credit':
        return MaterialPageRoute(builder: (_) => CreditScreen());
      case '/info':
        return MaterialPageRoute(builder: (_) => AboutScreen());
      case '/account':
        return MaterialPageRoute(builder: (_) => AccountScreen());
      case '/transactions':
        return MaterialPageRoute(builder: (_) => TransactionsScreen());
      case '/change_password':
        return MaterialPageRoute(builder: (_) => ChangePasswordScreen());
      case '/forgot_password':
        return MaterialPageRoute(builder: (_) => ForgotPasswordScreen());
      default:
        return generateRoute(RouteSettings(name: '/'));
    }
  }
}