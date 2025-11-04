import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nti_final_project/features/auth/view/splash_screen.dart';
import 'package:nti_final_project/features/home/presentation/screens/home_screen.dart';
import 'package:nti_final_project/main/presentation/main_screen.dart';

import 'core/validators/theme.dart';
import 'cubits/login/login_cubit.dart';
import 'features/auth/data/repository/auth_repository.dart';
import 'features/auth/data/services/auth_api_service.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => LoginCubit(AuthRepository(AuthApiService())),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});


  static const Color bgColor = Colors.white;
  static const Color primaryBrown = Color(0xffA3856E);
  static const Color inputFill = Color(0xFFD9D9D9);

  @override
  State<MyApp> createState() => _MyAppState();
}
  bool isDarkMode = false;

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: HomeScreen(),
      title: 'Team Project',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      darkTheme: AppTheme.darkTheme,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.poppinsTextTheme(),
        appBarTheme: const AppBarTheme(
          backgroundColor: MyApp.bgColor,
          elevation: 0,
          centerTitle: true,
        ),
      ),
      // initialRoute: '/loading',
      // routes: {
      //  '/loading': (_) => const SplashScreen(),
      //'/login': (_) => const LoginScreen(),
      // '/verify': (_) => const VerifyScreen(),
      // '/addService': (_) => AddServiceScreen(),
      // },
    );
  }
}


