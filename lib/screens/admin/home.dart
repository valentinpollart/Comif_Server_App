import 'package:Comif_Server_App/ui/drawers/main_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:Comif_Server_App/ui/colors/colors.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: main,
        title: Text('Accueil'),
      ),
      body: SafeArea(
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: font1,
                  border: Border.all(
                    width: 3,
                    color: font4,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: ListTile(
                  title: Text("Passer une commande"),
                  onTap: () {
                    Navigator.of(context).pushNamedAndRemoveUntil("/invoice", (_) => false);
                  },
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
                child: ListTile(
                  title: Text("Recharger un compte"),
                  onTap: () {
                    Navigator.of(context).pushNamedAndRemoveUntil("/credit", (_) => false);
                  },
                ),
              ),

            ],
          )
      ),
      drawer: MainDrawer(),
    );
  }
}
