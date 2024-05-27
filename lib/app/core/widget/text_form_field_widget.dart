import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?) validator;
  final bool obscureText;
  final Widget? suffix;
  final TextInputType keyboardType;

  const TextFormFieldWidget({
    required this.controller,
    required this.hintText,
    required this.validator,
    super.key,
    this.obscureText = false,
    this.suffix,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: hintText,
        suffix: suffix,
      ),
      validator: validator,
      obscureText: obscureText,
      keyboardType:keyboardType,
    );
  }
}
