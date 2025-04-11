import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  final TextInputType? keyboardType;
  final String value;
  final Function(String) onChanged;
  final String labelText;
  final IconData prefixIcon;
  final IconButton? suffixIcon;
  final bool? obscureText;
  final int? maxLength;

  const LoginTextField({
    super.key,
    required this.value,
    required this.onChanged,
    required this.labelText,
    required this.prefixIcon,
    this.keyboardType,
    this.suffixIcon,
    this.obscureText,
    this.maxLength,
  });

  final outlineInputBorder = const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
  );

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Colors.white,
      style: const TextStyle(color: Colors.white),
      keyboardType: keyboardType ?? TextInputType.text,
      obscureText: obscureText ?? false, // Controla a visibilidade da senha
      decoration: InputDecoration(
        counterText: "",
        prefixIconColor: Colors.white,
        prefixIcon: Icon(prefixIcon), // Ícone de cadeado
        suffixIconColor: Colors.white,
        suffixIcon: suffixIcon,
        labelStyle: const TextStyle(color: Colors.white),
        labelText: labelText, // Texto do rótulo
        border: outlineInputBorder,
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
      ),
      maxLength: maxLength,
      onChanged: onChanged,
    );
  }
}
