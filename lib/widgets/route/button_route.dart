import 'package:flutter/material.dart';

class ButtonOptions extends StatelessWidget {
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final String title;
  final VoidCallback onPressed;
  final Color? color;
  final double height;

  const ButtonOptions({
    super.key,
    this.prefixIcon,
    this.suffixIcon,
    this.height = 60.0,
    required this.title,
    required this.onPressed,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // Menos arredondado
          ),
        ),
        onPressed: onPressed,
        child: SizedBox(
          height: height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10.0,
            children: [
              if (prefixIcon != null) prefixIcon!,
              Text(title, style: Theme.of(context).textTheme.headlineSmall),
              if (suffixIcon != null) suffixIcon!,
            ],
          ),
        ),
      ),
    );
  }
}
