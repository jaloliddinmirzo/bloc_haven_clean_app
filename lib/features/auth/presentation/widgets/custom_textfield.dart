import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData prefixIcon;
  final bool obscureText;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType; // Yangi qo'shilgan parametr
  final List<TextInputFormatter>? inputFormatters; // Yangi qo'shilgan paramet
  const CustomTextField(
      {super.key,
      required this.hintText,
      required this.prefixIcon,
      this.obscureText = false,
      this.suffixIcon,
      this.validator,
      this.keyboardType, // Yangi qo'shilgan parametr
      this.inputFormatters, // Yangi qo'shilgan parametr
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType, // Klaviatura turi
      inputFormatters: inputFormatters, // Input formatterlar
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


class CustomPasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;

    // Password validation
  String? _validatePassword(String? value) {
    final passwordRegex = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d).{6,}$');
    if (value == null || value.isEmpty) {
      return 'Please fill in this field';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters';
    } else if (!passwordRegex.hasMatch(value)) {
      return 'Password must contain at least one uppercase letter, one lowercase letter, and one number';
    }
    return null;
  }

  const CustomPasswordField({
    super.key,
    required this.controller,
    this.hintText = "Password",
  });

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // validator: widget._validatePassword,
      controller: widget.controller,
      obscureText: _obscureText,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock),
        hintText: widget.hintText,
        suffixIcon: IconButton(
          icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
