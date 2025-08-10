import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String hintText;
  final IconData suffixIcon;
  final IconData? prefixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final String? Function(String?) validator;
  final void Function(String)? onChanged;

  const CustomInputField({
    Key? key,
    required this.hintText,
    required this.suffixIcon,
    this.prefixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.controller,
    required this.validator,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: const TextStyle(fontSize: 16),
        validator: validator,
        onChanged: onChanged,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          prefixIcon:
          prefixIcon != null ? Icon(prefixIcon, color: Colors.grey[700]) : null,
          suffixIcon: Icon(suffixIcon, color: Colors.grey[700]),
          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400, width: 1.1),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue.shade400, width: 1.5),
            borderRadius: BorderRadius.circular(12),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade700, width: 1.5),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade700, width: 1.5),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
