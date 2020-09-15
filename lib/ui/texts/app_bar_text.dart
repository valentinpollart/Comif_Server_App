import 'package:Comif_Server_App/ui/colors/colors.dart';
import 'package:flutter/material.dart';


class AppBarText extends StatelessWidget {
  final String text;

  const AppBarText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontFamily: 'CroissantOne'
      ),
    );
  }
}