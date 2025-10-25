import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  CustomTextfield({
    super.key,
    required this.label,
    this.icon,
    required this.controller,
    this.preIcon,
    this.validator,
    this.onPressed,
    this.preonPressed,
    required this.obscureText,
  });

  final String label;
  IconData? icon;
  final TextEditingController controller;
  final IconData? preIcon;
  final String? Function(String?)? validator;
  final void Function()? onPressed;
  final void Function()? preonPressed;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: obscureText,
      validator: validator,
      controller: controller,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        suffixIcon: IconButton(onPressed: preonPressed, icon: Icon(preIcon)),
        prefixIcon: IconButton(onPressed: onPressed, icon: Icon(icon)),
        filled: true,
        fillColor: Colors.grey.shade300,
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
