import 'package:flutter/material.dart';

class BigText extends StatelessWidget {
  final String text;
  final double fontSize;
  final int maxLines;

  const BigText({
    super.key,
    required this.text,
    this.fontSize = 40,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      text,
      style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
    );
  }
}
