import 'package:Comif_Server_App/cache/cached_data.dart';
import 'package:Comif_Server_App/route_generator.dart';
import 'package:Comif_Server_App/screens/login.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

// #docregion MyApp
class MyApp extends StatelessWidget {
  // #docregion build
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Comif Server App',
      home: HomePage(),
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
      if (SharedPrefs.isLogged()) {
        Navigator.of(context).pushNamedAndRemoveUntil("/main", (_) => false);
      }
    });
    return LoginScreen();
  }
}
// #docregion RWS-var
