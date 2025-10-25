import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'screens/add_service.dart';
import 'screens/login_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/verify_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const Color bgColor = Color(0xFFF5F5DE);
  static const Color primaryBrown = Color(0xffA3856E);
  static const Color inputFill = Color(0xFFD9D9D9);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Team Project',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(),
        appBarTheme: const AppBarTheme(
          backgroundColor: bgColor,
          elevation: 0,
          centerTitle: true,
        ),
      ),
      initialRoute: '/loading',
      routes: {
        '/loading': (_) => const SplashScreen(),
        '/login': (_) => const LoginScreen(),
        '/verify': (_) => const VerifyScreen(),
        '/addService': (_) => AddService(),
      },
    );
  }
}
