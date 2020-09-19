import 'package:Comif_Server_App/cache/cached_data.dart';
import 'package:Comif_Server_App/ui/drawers/main_drawer.dart';
import 'package:Comif_Server_App/ui/texts/app_bar_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:Comif_Server_App/ui/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background2,
      appBar: AppBar(
        backgroundColor: mainColor,
        title: AppBarText('Accueil')
      ),
      body: SafeArea(
          child: GridView.count(
        padding: EdgeInsets.all(30),
        crossAxisCount: 2,
        mainAxisSpacing: 30,
        crossAxisSpacing: 30,
        children: [...
          [Container(
            decoration: BoxDecoration(
              color: font1,
              border: Border.all(
                width: 3,
                color: font4,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Center(
              child: ListTile(
                title: Text(
                  "Mon compte",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: drawing,
                      fontSize: 25,
                      fontFamily: 'Pompiere',
                      fontWeight: FontWeight.w900
                  ),
                ),
                onTap: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil("/account", (_) => false);
                },
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: font1,
              border: Border.all(
                width: 3,
                color: font4,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Center(
              child: ListTile(
                title: Text(
                  "Mes transactions",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: drawing,
                      fontSize: 25,
                      fontFamily: 'Pompiere',
                      fontWeight: FontWeight.w900
                  ),
                ),
                onTap: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil("/transactions", (_) => false);
                },
              ),
            ),
          ),],
          ...(SharedPrefs.isAdmin ? [Container(
            decoration: BoxDecoration(
              color: font1,
              border: Border.all(
                width: 3,
                color: font4,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Center(
              child: ListTile(
                title: Text(
                  "Passer une commande",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: drawing,
                      fontSize: 25,
                      fontFamily: 'Pompiere',
                      fontWeight: FontWeight.w900
                  ),
                ),
                onTap: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil("/invoice", (_) => false);
                },
              ),
            ),
          ),
            Container(
              decoration: BoxDecoration(
                color: font1,
                border: Border.all(
                  width: 3,
                  color: font4,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Center(
                child: ListTile(
                  title: Text(
                    "Recharger un compte",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: drawing,
                        fontSize: 25,
                        fontFamily: 'Pompiere',
                        fontWeight: FontWeight.w900
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil("/credit", (_) => false);
                  },
                ),
              ),
            ),] : [Container()])
        ],
      )),
      drawer: MainDrawer(),
    );
  }
}
