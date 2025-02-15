import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  final double width;
  final String text;
  final VoidCallback onTap;
  const CustomBtn({
    super.key,
    this.width = double.infinity,
    required this.onTap,
    this.text = "Next",
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xff156651),
        ),
        width: width,
        height: 50,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w700,
            height: 1.20,
          ),
        ),
      ),
    );
  }
}
