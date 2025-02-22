import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haven_clean_app/core/common/app/services/injcetion_container.dart';
import 'package:haven_clean_app/core/utils/bloc_observer.dart';
import 'package:haven_clean_app/core/utils/constants/prefs_keys.dart';
import 'package:haven_clean_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:haven_clean_app/features/auth/presentation/screens/cubit_login_screen.dart';
import 'package:haven_clean_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:haven_clean_app/features/home/presentation/screens/home_screen_1.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initInjection();
  Bloc.observer = MyBlocObserver();
  // await getIt<SharedPreferences>().remove(PrefsKeys.tokenKey);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<HomeBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<AuthCubit>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: getIt<SharedPreferences>().getString(PrefsKeys.tokenKey) != null
            ? HomeScreen()
            : CubitLoginScreen(),
      ),
    );
  }
}
