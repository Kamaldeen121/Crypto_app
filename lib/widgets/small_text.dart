import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  const SmallText(
      {super.key,
      required this.text,
      this.fontSize = 15,
      this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: fontSize, color: color),
    );
  }
}
