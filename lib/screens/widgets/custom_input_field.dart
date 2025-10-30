import 'package:flutter/material.dart';
import 'package:nti_final_project/screens/widgets/constants.dart';


class CustomInputField extends StatelessWidget {
  final String hintText;
  final String? labelText;
  final bool isDropdown;

  const CustomInputField({
    required this.hintText,
    this.labelText,
    this.isDropdown = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Widget inputField = isDropdown
        ? DropdownButtonFormField<String>(
            decoration: InputDecoration(
              filled: true,
              fillColor: kLightInputField,
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 15.0,
              ),
            ),
            value: null,
            items: const [
              DropdownMenuItem(value: '1', child: Text('Select a category')),
            ],
            onChanged: (String? newValue) {},
          )
        : TextFormField(
            decoration: InputDecoration(
              filled: true,
              fillColor: kLightInputField,
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 15.0,
              ),
            ),
            keyboardType: hintText.contains('\$')
                ? TextInputType.number
                : TextInputType.text,
          );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Text(
              labelText!,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
          ),
        inputField,
        const SizedBox(height: 15),
      ],
    );
  }
}
