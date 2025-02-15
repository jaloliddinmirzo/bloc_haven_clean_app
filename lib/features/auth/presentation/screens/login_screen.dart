import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:haven_clean_app/features/auth/presentation/controller/auth_provider.dart';
import 'package:haven_clean_app/features/auth/presentation/widgets/custom_btn.dart';
import 'package:haven_clean_app/features/auth/presentation/widgets/custom_textfield.dart';
import 'package:haven_clean_app/features/auth/presentation/widgets/text_bold.dart';
import 'package:haven_clean_app/features/home/presentation/screens/home_screen_1.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>(); // Form uchun kalit
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
    passwordController.dispose();
  }

  // Phone number validation
  String? _validatePhone(String? value) {
    final phoneRegex = RegExp(r'^\+?[0-9]{6,}$');
    if (value == null || value.isEmpty) {
      return 'Please fill in this field';
    } else if (!phoneRegex.hasMatch(value)) {
      return 'Invalid phone number';
    }
    return null;
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Form(
              key: _formKey, // Formni ulash
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  const TextBold(text: "Welcome Back!"),
                  const SizedBox(height: 10),
                  const Text(
                    'Enter your phone number to start shopping and get awesome deals today!',
                    style: TextStyle(
                      color: Color(0xFF757575),
                      fontSize: 14,
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w400,
                      height: 1.20,
                    ),
                  ),
                  const SizedBox(height: 80),
                  CustomTextField(
                    hintText: "Phone number",
                    prefixIcon: Icons.call,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly, // Faqat raqamlar
                    ],
                    controller: phoneController,
                    // validator: _validatePhone, // Phone validation
                  ),
                  const SizedBox(height: 20),
                  CustomPasswordField(controller: passwordController),
                  const SizedBox(height: 20),
                  const Text(
                    'Forgot your password?',
                    style: TextStyle(
                      color: Color(0xFF156650),
                      fontSize: 14,
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w400,
                      height: 1.20,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Consumer<AuthProvider>(
                    builder: (context, authProvider, child) {
                      return CustomBtn(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            // Form validatsiyadan o'tganda
                            await authProvider.loginWithPhone(
                              phoneNumber: phoneController.text.trim(),
                              password: passwordController.text.trim(),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(authProvider.message.toString()),
                                backgroundColor: Colors.red,
                              ),
                            );
                            if (authProvider.message.contains("succesfuly")) {
                              log("Login successful:");
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomeScreen()),
                              );
                            } else {
                              log("Login failed: ");
                            }
                          }
                        },
                        text: "Login",
                        isLoading: authProvider.isLoading,
                      );
                    },
                  ),
                  const SizedBox(height: 40),
                  Image.asset(
                    width: double.infinity,
                    "assets/images/driver.png",
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(height: 20),
                  Image.asset(
                    width: double.infinity,
                    "assets/images/google.png",
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(height: 20),
                  Image.asset(
                    width: double.infinity,
                    "assets/images/book.png",
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(height: 50),
                  Center(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Don’t have an account? ',
                            style: TextStyle(
                              color: Color(0xFF404040),
                              fontSize: 14,
                              fontFamily: 'Manrope',
                              fontWeight: FontWeight.w400,
                              height: 1.20,
                            ),
                          ),
                          TextSpan(
                            text: 'Register',
                            style: const TextStyle(
                              color: Color(0xFF156650),
                              fontSize: 14,
                              fontFamily: 'Manrope',
                              fontWeight: FontWeight.w400,
                              height: 1.20,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
