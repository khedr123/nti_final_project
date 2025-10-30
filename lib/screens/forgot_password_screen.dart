import 'package:flutter/material.dart';
import 'package:nti_final_project/screens/widgets/constants.dart';
import 'package:nti_final_project/screens/widgets/custom_input_field';
import 'package:nti_final_project/screens/widgets/primary_button.dart';


class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: const Text(
          'Back to Login',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            const Text(
              'Forgot Password',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),

            const Text(
              'Enter the email address associated with your account and we\'ll send you a link to reset your password.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 40),

            const CustomInputField(
              labelText: 'Email',
              hintText: 'your.email@example.com',
            ),

            const SizedBox(height: 50),

            PrimaryButton(text: 'Send Reset Link', onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
