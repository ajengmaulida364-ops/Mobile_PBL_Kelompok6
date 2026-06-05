import 'package:flutter/material.dart';

class CustomInput extends StatefulWidget {
  final String hint;
  final bool obscureText;
  final TextEditingController? controller;

  const CustomInput({
    super.key,
    required this.hint,
    this.obscureText = false,
    this.controller,
  });

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  late bool isHidden;

  @override
  void initState() {
    super.initState();
    isHidden = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: isHidden,
      decoration: InputDecoration(
        hintText: widget.hint,
        filled: true,
        fillColor: Colors.white,

        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                  isHidden
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    isHidden = !isHidden;
                  });
                },
              )
            : null,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}