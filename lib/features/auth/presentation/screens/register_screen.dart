import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:haven_clean_app/features/auth/presentation/controller/auth_provider.dart';
import 'package:haven_clean_app/features/auth/presentation/screens/login_screen.dart';
import 'package:haven_clean_app/features/auth/presentation/widgets/custom_btn.dart';
import 'package:haven_clean_app/features/auth/presentation/widgets/custom_textfield.dart';
import 'package:haven_clean_app/features/auth/presentation/widgets/text_bold.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // TextEditingController larni e'lon qilish
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Form uchun kalit
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Telefon raqami uchun controller ni boshlang'ich qiymat bilan ishga tushiramiz
    _phoneController = TextEditingController(text: '+998');
    // Listener qo'shamiz, shunda foydalanuvchi +998 ni o'chira olmaydi
    _phoneController.addListener(() {
      if (!_phoneController.text.startsWith('+998')) {
        _phoneController.value = TextEditingValue(
          text: '+998',
          selection: TextSelection.collapsed(offset: 4),
        );
      }
    });
  }

  @override
  void dispose() {
    // Controllerlarni tozalash
    _firstNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // First name validation
  String? _validateFirstName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please fill in this field';
    }
    return null;
  }

  // Phone number validation
  String? _validatePhone(String? value) {
    final phoneRegex = RegExp(r'^\+998[0-9]{9}$'); // +998 dan keyin 9 ta raqam
    if (value == null || value.isEmpty) {
      return 'Please fill in this field';
    } else if (!phoneRegex.hasMatch(value)) {
      return 'Invalid phone number (e.g., +998901234567)';
    }
    return null;
  }

  // Email validation
  String? _validateEmail(String? value) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (value == null || value.isEmpty) {
      return 'Please fill in this field';
    } else if (!emailRegex.hasMatch(value)) {
      return 'Invalid email address';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        return Scaffold(
          backgroundColor: const Color(0xffF5F5F5),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Form(
                  key: _formKey, // Formni ulash
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40),
                      const TextBold(text: "Create Account"),
                      const SizedBox(height: 10),
                      const Text(
                        'Fill in your details below to get started on a seamless shopping experience.',
                        style: TextStyle(
                          color: Color(0xFF757575),
                          fontSize: 14,
                          fontFamily: 'Manrope',
                          fontWeight: FontWeight.w400,
                          height: 1.20,
                        ),
                      ),
                      const SizedBox(height: 50),
                      CustomTextField(
                        controller: _firstNameController,
                        hintText: "First name",
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'[a-zA-Z]')), // Faqat harflar
                        ],
                        prefixIcon: Icons.person,
                        validator: _validateFirstName, // First name validation
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        hintText: "Phone",
                        prefixIcon: Icons.call,
                        keyboardType: TextInputType.phone,
                        // inputFormatters: [
                        //   FilteringTextInputFormatter.digitsOnly, // Faqat raqamlar
                        // ],
                        controller: _phoneController,
                        validator: _validatePhone, // Phone validation
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        hintText: "Email",
                        prefixIcon: Icons.email,
                        controller: _emailController,
                        validator: _validateEmail, // Email validation
                      ),
                      const SizedBox(height: 20),
                      CustomPasswordField(controller: _passwordController),
                      const SizedBox(height: 20),
                      Center(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(
                                text:
                                    'By clicking Create Account, you acknowledge you have read and agreed to our',
                                style: TextStyle(
                                  color: Color(0xFF404040),
                                  fontSize: 14,
                                  fontFamily: 'Manrope',
                                  fontWeight: FontWeight.w400,
                                  height: 1.20,
                                ),
                              ),
                              TextSpan(
                                text: ' Terms of Use and Privacy Policy',
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
                      ),
                      const SizedBox(height: 20),
                      CustomBtn(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            // Form validatsiyadan o'tganda
                            await authProvider.register(
                              phoneNumber: _phoneController.text.trim(),
                              email: _emailController.text.trim(),
                              password: _passwordController.text.trim(),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(authProvider.message.toString()),
                                backgroundColor:
                                    const Color.fromARGB(255, 105, 104, 104),
                              ),
                            );
                            if (authProvider.message.contains("registered")) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()),
                              );
                            } else {
                              log("Registration failed: ");
                            }
                          }
                        },
                        isLoading: authProvider.isLoading,
                        text: "Register",
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
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
