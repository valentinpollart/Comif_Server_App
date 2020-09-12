import 'package:Comif_Server_App/cache/cached_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Comif_Server_App/ui/colors/colors.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Drawer Header',
            style: TextStyle(color: drawing),),
            decoration: BoxDecoration(
              color: main,
            ),
          ),
          ListTile(
            title: Text('Se déconnecter'),
            onTap: () {
              SharedPrefs.logout();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/', (route) => false);
              // Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Prendre une commande'),
            onTap: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/invoice', (route) => false);
              // Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Recharger un compte'),
            onTap: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/credit', (route) => false);
              // Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
