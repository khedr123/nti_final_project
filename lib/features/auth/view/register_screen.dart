import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nti_final_project/core/validators/validator.dart';
import 'package:nti_final_project/features/auth/view/login_screen.dart';
import 'package:nti_final_project/features/auth/view/verify_screen.dart';
import 'package:nti_final_project/screens/widgets/custom_elevated_button.dart';
import 'package:nti_final_project/screens/widgets/custom_textformfield.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  bool isVisable = false;
  final dio = Dio();
  final GlobalKey<FormState> _key = GlobalKey();

  Future<void> register() async {
    try {
      final Response response = await dio.post(
        'https://accessories-eshop.runasp.net/api/auth/register',
        data: {
          "email": emailController.text,
          "password": passwordController.text,
          "firstName": firstNameController.text,
          "lastName": lastNameController.text,
        },
      );
      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return VerifyScreen(email: emailController.text,);
            },
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login Sucess'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      log("error:$e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login failed. Please check your credentials'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _key,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 97),
                  const Text(
                    'Create Account',
                    style: TextStyle(fontSize: 30, color: Color(0xff1F41BB)),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Create an account so you can explore all the existing jobs',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 53),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 150,
                        child: CustomTextfield(
                          validator: (emailValue) {
                            return Validator.validateUserName(emailValue!);
                          },
                          label: 'First Name',
                          icon: Icons.person,
                          controller: firstNameController,
                          obscureText: false,
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: CustomTextfield(
                          validator: (validateUserName) {
                            return Validator.validateUserName(
                              validateUserName!,
                            );
                          },
                          label: 'Last Name',
                          icon: Icons.person,
                          controller: lastNameController,
                          obscureText: false,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  CustomTextfield(
                    validator: (validateeEmail) {
                      return Validator.validateEmail(validateeEmail!);
                    },
                    label: 'Email',
                    icon: Icons.person,
                    controller: emailController,
                    obscureText: false,
                  ),
                  SizedBox(height: 26),
                  CustomTextfield(
                    validator: (passwordValue) {
                      return Validator.validatePassword(passwordValue!);
                    },
                    label: 'Password',
                    icon: Icons.lock,
                    obscureText: isVisable,
                    preIcon: isVisable
                        ? Icons.visibility
                        : Icons.visibility_off,
                    preonPressed: () {
                      setState(() {
                        isVisable = !isVisable;
                      });
                    },
                    controller: passwordController,
                  ),
                  SizedBox(height: 26),
                  SizedBox(height: 53),
                  SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: CustomElevatedbutton(
                      text: 'Sign Up',
                      onPressed: () {
                        if (_key.currentState!.validate()) {
                          log("email:${emailController.text}");
                          log("email:${firstNameController.text}");
                          log("email:${lastNameController.text}");
                          log("email:${passwordController.text}");
                          register();

                        }
                        register();
                      },
                    ),
                  ),
                  SizedBox(height: 30),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: const Text(
                      'Already have an account ? Login',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(height: 65),
                  Text(
                    'Or continue with',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.deepPurpleAccent,
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
