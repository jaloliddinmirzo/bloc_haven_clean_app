import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:haven_clean_app/core/common/app/services/injcetion_container.dart';
import 'package:haven_clean_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:haven_clean_app/features/auth/domain/usecases/register_usecases.dart';

class AuthProvider extends ChangeNotifier {
  final LoginUsecase loginUsecase = getIt<LoginUsecase>();
  final RegisterUsecases registerUsecases = getIt<RegisterUsecases>();

  AuthProvider();

  bool isLoading = false;
  String message = '';

  Future<void> loginWithPhone({
    required String phoneNumber,
    required String password,
  }) async {
    isLoading = true;
    notifyListeners();
    log("data in usecase: $phoneNumber, $password");
    final result = await loginUsecase.call(
      phoneNumber: phoneNumber,
      password: password,
    );
    isLoading = false;

    notifyListeners();

    return result.fold(
      (error) => message = error,
      (_) => message = "Login succesfuly",
    );
  }

  Future<void> register({
    required String phoneNumber,
    required String email,
    required String password,
  }) async {
    isLoading = true;
    notifyListeners();
    final result = await registerUsecases.call(
      phoneNumber: phoneNumber,
      password: password,
      email: email,
    );
    isLoading = false;
    notifyListeners();

    return result.fold(
      (l) => message = l,
      (r) => message = "Successfully registered.",
    );
  }
}
