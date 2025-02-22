import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:haven_clean_app/features/auth/data/repositors/auth_repo_impl.dart';
import 'package:haven_clean_app/features/auth/domain/repositors/auth_repo.dart';
import 'package:haven_clean_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:haven_clean_app/features/auth/domain/usecases/register_usecases.dart';
import 'package:haven_clean_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:haven_clean_app/features/auth/presentation/controller/auth_provider.dart';
import 'package:haven_clean_app/features/home/data/data_source/custom_dio_client.dart';
import 'package:haven_clean_app/features/home/data/data_source/home_remote_data_source.dart';
import 'package:haven_clean_app/features/home/data/repositors/home_repo_impl.dart';
import 'package:haven_clean_app/features/home/domain/repositories/home_repo.dart';
import 'package:haven_clean_app/features/home/domain/usecases/get_banners_usecase.dart';
import 'package:haven_clean_app/features/home/domain/usecases/get_cards_usecases.dart';
import 'package:haven_clean_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../features/auth/data/data_source/auth_remote_data_source.dart';

final getIt = GetIt.instance;

Future<void> initInjection() async {
  getIt.registerLazySingleton(
    () => Dio(),
  );
  final prefs = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => prefs);
  await authInit();
  await homeInit();
}

Future<void> authInit() async {
  getIt
    ..registerLazySingleton<LoginUsecase>(() => LoginUsecase(authRepo: getIt()))
    ..registerLazySingleton<RegisterUsecases>(
      () => RegisterUsecases(authRepo: getIt()),
    )
    ..registerLazySingleton<DioClient>(
      () => DioClient(),
    )
    ..registerLazySingleton<AuthRepo>(
        () => AuthRepoImpl(authRemoteDataSource: getIt()))
    ..registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl())
    ..registerLazySingleton(
      () => AuthProvider(),
    );
}

// home
Future<void> homeInit() async {
  getIt
    ..registerLazySingleton(() => GetBannersUsecase(homeRepo: getIt()))
    ..registerLazySingleton<HomeRepo>(
        () => HomeRepoImpl(homeRemoteDataSource: getIt()))
    ..registerLazySingleton<HomeRemoteDataSource>(
        () => HomeRemoteDataSourceImpl())
    ..registerLazySingleton<HomeBloc>(
      () => HomeBloc(),
    )
    ..registerLazySingleton<AuthCubit>(
      () => AuthCubit(
        loginUsecase: getIt(),
        registerUsecases: getIt(),
      ),
    )
    // ..registerLazySingleton<HomeProvider>(() => HomeProvider())
    ..registerLazySingleton(
      () => GetCardsUsecases(homeRepo: getIt()),
    );
}
