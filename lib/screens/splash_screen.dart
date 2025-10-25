import 'dart:async';
import 'package:flutter/material.dart';
import '../main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyApp.bgColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.shopping_bag, size: 80, color: MyApp.primaryBrown),
            SizedBox(height: 15),
            Text(
              "Welcome to Shop",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: MyApp.primaryBrown,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
