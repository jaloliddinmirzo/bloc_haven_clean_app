import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  final double width;
  final String text;
  final bool isLoading;
  final VoidCallback onTap;
  final bool isEnabled;
  const CustomBtn({
    super.key,
    this.width = double.infinity,
    required this.onTap,
    this.text = "Next",
    this.isLoading = false,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xff156651),
        ),
        width: width,
        height: 50,
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Text(
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
