// lib/logic/cubits/auth_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haven_clean_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:haven_clean_app/features/auth/domain/usecases/register_usecases.dart';
import 'package:haven_clean_app/features/auth/presentation/bloc/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUsecase loginUsecase;
  final RegisterUsecases registerUsecases;

  AuthCubit({
    required this.loginUsecase,
    required this.registerUsecases,
  }) : super(AuthInitial());

  Future<void> register(String email, String password, String phoneNumber) async {
    emit(AuthLoading());
    try {
      // Register usecase ni chaqiramiz
      final result = await registerUsecases.call(
        email: email,
        password: password,
        phoneNumber: phoneNumber,
      );

      // Resultni tekshirib, muvaffaqiyatli bo'lsa AuthAuthenticated state ni emit qilamiz
      result.fold(
        (failure) => emit(AuthError(failure.message)),
        (user) => emit(AuthAuthenticated(
          phoneNumber: phoneNumber,
          password: password,
        )),
      );
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> login(String phoneNumber, String password) async {
    emit(AuthLoading());
    try {
      // Login usecase ni chaqiramiz
      final result = await loginUsecase.call(
        phoneNumber: phoneNumber,
        password: password,
      );

      // Resultni tekshirib, muvaffaqiyatli bo'lsa AuthAuthenticated state ni emit qilamiz
      result.fold(
        (failure) => emit(AuthError(failure.message)),
        (user) => emit(AuthAuthenticated(
          phoneNumber: phoneNumber,
          password: password,
        )),
      );
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  void logout() {
    emit(AuthUnauthenticated());
  }
}