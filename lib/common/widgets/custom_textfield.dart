import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final String hintText;
  final bool? enabled;
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.keyboardType,
    this.obscureText,
    this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType ?? TextInputType.text,
      controller: controller,
      cursorHeight: 32,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
          ),
        ),
      ),
      enabled: enabled ?? true,
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Nhập $hintText';
        }

        return null;
      },
    );
  }
}
