import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {

  final String hint;

  final bool obscureText;

  const CustomInput({
    super.key,
    required this.hint,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {

    return TextField(

      obscureText: obscureText,

      decoration: InputDecoration(

        hintText: hint,

        filled: true,
        fillColor: Colors.white,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}