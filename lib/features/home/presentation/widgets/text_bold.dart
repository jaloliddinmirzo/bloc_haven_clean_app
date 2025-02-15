import 'package:flutter/material.dart';

class TextBold extends StatelessWidget {
  final String text;
  const TextBold({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Color(0xFF404040),
        fontSize: 28,
        fontFamily: 'Manrope',
        fontWeight: FontWeight.w800,
        height: 1.20,
      ),
    );
  }
}
