import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData prefixIcon;
  final bool obscureText;
  final TextEditingController firstNameController;
  final Widget? suffixIcon;

  const CustomTextField(
      {super.key,
      required this.hintText,
      required this.prefixIcon,
       this.obscureText = false,
      this.suffixIcon,
      required this.firstNameController});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: firstNameController,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(prefixIcon),
        hintText: hintText,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          // borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
