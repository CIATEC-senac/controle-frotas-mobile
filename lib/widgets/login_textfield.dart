import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  TextInputType? keyboardType;
  String value;
  Function(String) onChanged;
  String labelText;
  IconData prefixIcon;
  IconButton? suffixIcon;
  bool? obscureText;

  LoginTextField({
    super.key,
    required this.value,
    required this.onChanged,
    required this.labelText,
    required this.prefixIcon,
    this.keyboardType,
    this.suffixIcon,
    this.obscureText,
  });

  final outlineInputBorder = const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
  );

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white),
      keyboardType: keyboardType ?? TextInputType.text,
      obscureText: obscureText ?? true, // Controla a visibilidade da senha
      decoration: InputDecoration(
        prefixIconColor: Colors.white,
        prefixIcon: Icon(prefixIcon), // Ícone de cadeado
        suffixIconColor: Colors.white,
        suffixIcon: suffixIcon,
        labelStyle: TextStyle(color: Colors.white),
        labelText: labelText, // Texto do rótulo
        border: outlineInputBorder,
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
      ),
      onChanged: onChanged,
    );
  }
}
