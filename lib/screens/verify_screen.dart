import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../cubits/login/login_cubit.dart';
import '../../cubits/login/login_state.dart';
import 'widgets/custom_elevated_button.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({super.key});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  String currentPin = "";

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Verifying...")),
          );
        } else if (state is LoginSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.data['message'] ?? "Success")),
          );
          Navigator.pushNamed(context, '/addService');
        } else if (state is LoginError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5DE),
        appBar: AppBar(
          backgroundColor: const Color(0xFFF5F5DE),
          elevation: 0,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: Colors.black),
          ),
          title: const Text(
            "Verify Your Email",
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 200),

              const Text(
                "Check your email",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "We've sent a 6-digit code to your email.\nPlease enter it below to verify your account.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 11, color: Colors.black54),
              ),

              const SizedBox(height: 40),

              PinCodeTextField(
                appContext: context,
                length: 6,
                onChanged: (value) {
                  setState(() => currentPin = value);
                },
                keyboardType: TextInputType.number,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(8),
                  fieldHeight: 48,
                  fieldWidth: 48,
                  inactiveColor: Colors.black26,
                  inactiveFillColor: Colors.white,
                  selectedColor: Colors.black,
                  selectedFillColor: Colors.white,
                  activeColor: Colors.black54,
                  activeFillColor: Colors.white,
                ),
              ),

              const SizedBox(height: 40),

              CustomElevatedbutton(
                text: "Verify",
                onPressed: currentPin.length == 6
                    ? () {
                  context.read<LoginCubit>().verifyOtp(currentPin);
                }
                    : null,
              ),

              const SizedBox(height: 15),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Didn’t receive a code? ",
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  Text(
                    "Resend",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


