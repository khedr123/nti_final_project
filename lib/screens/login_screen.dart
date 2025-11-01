import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/custom_textformfield.dart';
import 'widgets/custom_elevated_button.dart';
import '../../cubits/login/login_cubit.dart';
import '../../cubits/login/login_state.dart';

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
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Logging in...")),
          );
        } else if (state is LoginSuccess) {
          final data = state.data;
          if (data['statusCode'] == 200 || data['token'] != null) {
            Navigator.pushNamed(context, '/verify');
          }
          else {
            if (data['errors'] != null && data['errors'] is Map) {
              final errors = data['errors'] as Map;
              final errorMessages = errors.entries
                  .map((e) => '${e.key}: ${(e.value as List).join(', ')}')
                  .join('\n');

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(errorMessages),
                  backgroundColor: Colors.red,
                  duration: const Duration(seconds: 5),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(data['message'] ?? "Login failed"),
                  backgroundColor: Colors.red,
                  duration: const Duration(seconds: 3),
                ),
              );
            }
          }
        } else if (state is LoginError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5DE),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 60),
                const Icon(Icons.shopping_bag_outlined,
                    size: 60, color: Color(0xffA3856E)),

                const SizedBox(height: 40),
                const Text(
                  "Welcome Back",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
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
                    final email = _email.text.trim();
                    final password = _pass.text.trim();

                    if (email.isEmpty || password.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Please enter email and password")),
                      );
                      return;
                    }
                    context.read<LoginCubit>().login(email, password);
                  },
                ),

                const SizedBox(height: 25),

                const Text("or",
                    style: TextStyle(fontSize: 14, color: Colors.black54)),
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
      ),
    );
  }
}
