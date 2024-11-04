import 'package:flutter/material.dart';

class GSTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? placeholder;
  final String? Function(String?)? validator;
  final bool concealed;

  const GSTextFormField({
    super.key,
    required this.controller,
    this.placeholder,
    this.validator,
    this.concealed = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        filled: true,
        hintText: placeholder,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      obscureText: concealed,
    );
  }
}
