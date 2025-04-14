import 'package:flutter/material.dart';

class CardTitle extends StatelessWidget {
  final IconData icon;
  final String title;

  const CardTitle({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 16.0,
      children: [
        Icon(icon, size: 18.0),
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ],
    );
  }
}
