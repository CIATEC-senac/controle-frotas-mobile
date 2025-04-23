import 'package:flutter/material.dart';

class StopRun extends StatelessWidget {
  final VoidCallback onPressed;

  const StopRun({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: onPressed, child: Text('Finalizar'));
  }
}
