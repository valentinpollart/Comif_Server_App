import 'package:Comif_Server_App/ui/colors/colors.dart';
import 'package:Comif_Server_App/ui/texts/main_text.dart';
import 'package:flutter/material.dart';

class AdminDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        ListTile(
          title: MainText(text: 'Prendre une commande',color: drawing,size: 30,),
          onTap: () {
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/invoice', (route) => false);
            // Navigator.pop(context);
          },
        ),
          ListTile(
            title: MainText(text:'Recharger un compte',color: drawing,size: 30,),
            onTap: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/credit', (route) => false);
              // Navigator.pop(context);
            },
          ),
          ListTile(
            title: MainText(text:'A propos',color: drawing,size: 30,),
            onTap: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/info', (route) => false);
              // Navigator.pop(context);
            },
          ),
      ],
    );
  }
}