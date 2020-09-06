import 'package:Comif_Server_App/cache/cached_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Drawer Header'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('Se déconnecter'),
            onTap: () {
              CachedData.logout();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/', (route) => false);
            },
          ),
          ListTile(
            title: Text('Prendre une commande'),
            onTap: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/invoice', (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
