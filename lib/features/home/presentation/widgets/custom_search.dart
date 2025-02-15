import 'package:flutter/material.dart';

class CustomSearchField extends StatelessWidget {
  final String hintText;
  final IconData leftIcon;
  final IconData rightIcon1;
  final IconData rightIcon2;

  const CustomSearchField({
    super.key,
    required this.hintText,
    required this.leftIcon,
    required this.rightIcon1,
    required this.rightIcon2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Icon(leftIcon, color: Colors.black),
          SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
              ),
            ),
          ),
          Icon(rightIcon1, color: Colors.grey),
        ],
      ),
    );
  }
}
