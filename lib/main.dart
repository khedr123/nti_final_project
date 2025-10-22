import 'package:flutter/material.dart';
import 'package:nti_final_project/screens/home_screen.dart';

void main() {
  runApp(const EcommerceApp());
}

class EcommerceApp extends StatelessWidget {
  const EcommerceApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomeScreen());
  }
}
