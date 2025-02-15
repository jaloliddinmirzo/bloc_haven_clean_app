import 'package:dartz/dartz.dart';
import 'package:haven_clean_app/features/auth/domain/repositors/auth_repo.dart';

class RegisterUsecases {
  final AuthRepo authRepo;

  RegisterUsecases({required this.authRepo});

  Future<Either<dynamic, bool>> call({
    required String phoneNumber,
    required String password,
    required String email,
  }) {
    return authRepo.register(
      phoneNumber: phoneNumber,
      password: password,
      email: email,
    );
  }
}
