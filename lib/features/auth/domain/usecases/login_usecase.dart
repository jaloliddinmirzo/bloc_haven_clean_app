
import 'package:dartz/dartz.dart';
import 'package:haven_clean_app/features/auth/domain/repositors/auth_repo.dart';

class LoginUsecase {
  final AuthRepo authRepo;

  LoginUsecase({required this.authRepo});

  Future<Either<dynamic, bool>> call({
    required String phoneNumber,
    required String password,
  }) {
    return authRepo.login(
      phoneNumber: phoneNumber,
      password: password,
    );
  }
}