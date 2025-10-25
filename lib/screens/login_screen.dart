import 'package:flutter/material.dart';
import 'widgets/custom_textformfield.dart';
import 'widgets/custom_elevated_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5DE),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              Icon(Icons.shopping_bag_outlined,
                  size: 60, color: const Color(0xffA3856E)),

              const SizedBox(height: 40),
              const Text(
                "Welcome Back",
                style: TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(height: 8),
              const Text(
                "Join thousands of happy customers",
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
              const SizedBox(height: 30),

              CustomTextfield(
                label: "Email Address",
                controller: _email,
                obscureText: false,
              ),
              const SizedBox(height: 15),

              CustomTextfield(
                label: "Password",
                controller: _pass,
                obscureText: true,
                preIcon: Icons.visibility_off,
                preonPressed: () {},
              ),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Forgot Password?",
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xffA3856E),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              CustomElevatedbutton(
                text: "Log In",
                onPressed: () {
                  Navigator.pushNamed(context, '/verify');
                },
              ),

              const SizedBox(height: 25),

              const Text("or", style: TextStyle(fontSize: 14, color: Colors.black54)),
              const SizedBox(height: 15),

              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.g_mobiledata, size: 30),
                label: const Text(
                  "Continue with Google",
                  style: TextStyle(color: Colors.black87),
                ),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 55),
                  side: const BorderSide(color: Colors.black38),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: Colors.white,
                ),
              ),

              const SizedBox(height: 40),

              const Text(
                "By continuing, you agree to our Terms of Service and Privacy Policy.",
                style: TextStyle(fontSize: 11, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
