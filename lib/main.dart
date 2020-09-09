import 'package:Comif_Server_App/cache/cached_data.dart';
import 'package:Comif_Server_App/route_generator.dart';
import 'package:Comif_Server_App/screens/invoice_builder.dart';
import 'package:flutter/material.dart';
import 'screens/login.dart';

void main() => runApp(MyApp());

// #docregion MyApp
class MyApp extends StatelessWidget {
  // #docregion build
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      home: HomePage(),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
// #enddocregion build
}
// #enddocregion MyApp
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SharedPrefs.loadAuthToken().then((_) {
      CachedData.initCache();
      String routeName = (SharedPrefs.isLogged()) ? '/main' : '/';
      if (ModalRoute.of(context).settings.name != "/") {
        Navigator.of(context).pushNamedAndRemoveUntil(routeName, (_) => false);
      }
    });
    return LoginScreen();
  }
}
// #docregion RWS-var
