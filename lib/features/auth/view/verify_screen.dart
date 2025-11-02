import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti_final_project/screens/home_screen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../../cubits/otp/otp_cubit.dart';
import '../../../../../cubits/otp/otp_state.dart';
import '../data/services/otp_api_service.dart';
import 'package:nti_final_project/screens/widgets/custom_elevated_button.dart';

import '../../../main.dart';

class VerifyScreen extends StatefulWidget {
  final String email;
  const VerifyScreen({super.key, required this.email});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  String currentPin = "";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OtpCubit(OtpApiService()),
      child: BlocConsumer<OtpCubit, OtpState>(
        listener: (context, state) {
          if (state is OtpSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
            Future.delayed(const Duration(seconds: 1), () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            });
          } else if (state is OtpError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: MyApp.bgColor,
            appBar: AppBar(
              backgroundColor: MyApp.bgColor,
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
                    text: state is OtpLoading ? "Verifying..." : "Verify",
                    onPressed: (currentPin.length == 6 && state is! OtpLoading)
                        ? () {
                      context
                          .read<OtpCubit>()
                          .validateOtp(widget.email, currentPin);
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
          );
        },
      ),
    );
  }
}
