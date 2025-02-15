import 'package:flutter/material.dart';

class TextSimple extends StatelessWidget {
  final String text;
  final double fontSize;

  const TextSimple({
    super.key,
    required this.text,
    this.fontSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color(0xFF757575),
          fontSize: fontSize,
          fontFamily: 'Manrope',
          fontWeight: FontWeight.w400,
          height: 1.20,
        ),
      ),
    );
  }
}
