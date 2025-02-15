import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:haven_clean_app/core/common/exeptions/custom_exception.dart';
import 'package:haven_clean_app/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:haven_clean_app/features/auth/domain/repositors/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepoImpl({required this.authRemoteDataSource});
  @override
  Future<Either<dynamic, bool>> login({
    required String phoneNumber,
    required String password,
  }) async {
    log("data in repo impl: $phoneNumber, $password");
    try {
      final bool = await authRemoteDataSource.login(
        phoneNumber: phoneNumber,
        password: password,
      );
      return Right(bool ?? false);
    } on ServerException catch (e) {
      return Left(e.errorMessage);
    }
  }

  @override
  Future<Either<dynamic, bool>> register(
      {required String phoneNumber,
      required String email,
      required String password}) async {
    try {
      final bool = await authRemoteDataSource.register(
          phoneNumber: phoneNumber, email: email, password: password);
      return Right(bool!);
    } on ServerException catch (e) {
      return Left(e.errorMessage);
    }
  }
}
