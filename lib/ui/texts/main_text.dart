import 'package:Comif_Server_App/ui/colors/colors.dart';
import 'package:flutter/material.dart';

class MainText extends StatelessWidget {
  final String text;
  final double size;
  final FontWeight weight;
  final TextAlign alignment;
  final Color color;

  const MainText(
      {this.text,
      this.color = drawing,
      this.size = 14,
      this.weight = FontWeight.w400,
      this.alignment = TextAlign.left});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: alignment,
        style: TextStyle(
          color: color,
          fontSize: size,
          fontFamily: 'Pompiere',
          fontWeight: weight,
        ));
  }
}
