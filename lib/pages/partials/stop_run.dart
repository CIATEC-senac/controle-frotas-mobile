import 'package:flutter/material.dart';

class StartRun extends StatelessWidget {
  final VoidCallback onPressed;

  const StartRun({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: onPressed, child: Text('Iniciar'));
  }
}
