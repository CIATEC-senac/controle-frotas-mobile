import 'package:flutter/material.dart';

class ButtonOptions extends StatelessWidget {
  Icon icon;
  String title;
  VoidCallback onPressed;
  Color? color;

  ButtonOptions(
      {super.key,
      this.icon = const Icon(Icons.abc),
      required this.title,
      required this.onPressed,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // Menos arredondado
            ),
          ),
          onPressed: onPressed,
          child: SizedBox(
            height: 60.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10.0,
              children: [
                icon,
                Text(title, style: Theme.of(context).textTheme.headlineSmall),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
