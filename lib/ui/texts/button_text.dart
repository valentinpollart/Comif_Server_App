import 'package:Comif_Server_App/ui/texts/main_text.dart';
import 'package:flutter/material.dart';
import 'package:Comif_Server_App/ui/colors/colors.dart';

class ButtonText extends StatelessWidget {
  final String text;

  const ButtonText({this.text});

  @override
  Widget build(BuildContext context) {
    return MainText(
      text: "Valider le panier",
      color: font4,
      weight: FontWeight.bold,
      size: 20,
    );
  }
}
