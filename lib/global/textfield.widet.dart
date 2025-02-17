import 'package:flutter/material.dart';

enum CareBloomFieldTypes {
  email,
  password,
  text,
}

class CareBloomField extends StatefulWidget {
  final TextEditingController controller;
  final CareBloomFieldTypes type;

  final String label;

  final String placeholder;
  const CareBloomField(
      {super.key,
      required this.controller,
      this.label = '',
      this.placeholder = '',
      this.type = CareBloomFieldTypes.text});

  @override
  State<CareBloomField> createState() => _CareBloomFieldState();
}

class _CareBloomFieldState extends State<CareBloomField> {
  late bool isPasswordVisible;

  @override
  void initState() {
    if (widget.type == CareBloomFieldTypes.password) {
      isPasswordVisible = false;
    }
    super.initState();
  }

  toggleVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        if (widget.type == CareBloomFieldTypes.email && !value.isValidEmail()) {
          return 'Please enter a valid email';
        }
        return null;
      },
      controller: widget.controller,
      obscureText: widget.type == CareBloomFieldTypes.password
          ? !isPasswordVisible
          : false,
      decoration: InputDecoration(
          suffixIcon: widget.type == CareBloomFieldTypes.password
              ? IconButton(
                  icon: Icon(
                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    size: 17,
                  ),
                  onPressed: toggleVisibility,
                )
              : null,
          labelText: widget.label,
          hintText: widget.placeholder,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
          )),
    );
  }
}

extension StringExtension on String {
  bool isValidEmail() {
    return RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(this);
  }
}
