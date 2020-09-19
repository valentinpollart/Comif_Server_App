import 'package:Comif_Server_App/cache/cached_data.dart';
import 'package:Comif_Server_App/route_generator.dart';
import 'package:Comif_Server_App/screens/shared/login.dart';
import 'package:flutter/material.dart';
import 'package:Comif_Server_App/ui/colors/colors.dart';


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
      theme: new ThemeData(canvasColor: mainColor),
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
        if (SharedPrefs.isAdmin) {
          Navigator.of(context).pushNamedAndRemoveUntil("/main", (_) => false);
        } else {
          Navigator.of(context).pushNamedAndRemoveUntil("/account", (_) => false);
        }
      }
    });
    return LoginScreen();
  }
}
// #docregion RWS-var
