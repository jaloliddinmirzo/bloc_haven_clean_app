import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  final String path;
  const CustomImage({
    super.key, required this.path,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 450,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40)),
          image: DecorationImage(
              fit: BoxFit.cover, image: AssetImage(path))),
    );
  }
}
