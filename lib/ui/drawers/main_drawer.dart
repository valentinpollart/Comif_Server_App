import 'package:Comif_Server_App/cache/cached_data.dart';
import 'package:Comif_Server_App/ui/drawers/admin_drawer.dart';
import 'package:Comif_Server_App/ui/texts/main_text.dart';
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
            padding: EdgeInsets.all(0),
            margin: EdgeInsets.all(0),
            child: Image.asset('assets/icons/comif_part.png'),
            decoration: BoxDecoration(
              color: drawerBackground3,
            ),
          ),
          Container(
            color: mainColor,
            child: Column(
              children: [
                ListTile(
                  title: MainText(text:'Accueil',color: drawing,size: 30,),
                  onTap: () {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/main', (route) => false);
                    // Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: MainText(text:'Mon compte',color: drawing,size: 30,),
                  onTap: () {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/account', (route) => false);
                    // Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: MainText(text:'Mes transactions',color: drawing,size: 30,),
                  onTap: () {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/transactions', (route) => false);
                    // Navigator.pop(context);
                  },
                ),
                SharedPrefs.isAdmin ? AdminDrawer() : Container(),
                ListTile(
                  title: MainText(text:'Se déconnecter',color: drawing,size: 30,),
                  onTap: () {
                    SharedPrefs.logout();
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/', (route) => false);
                    // Navigator.pop(context);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
