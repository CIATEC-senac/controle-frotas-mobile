import 'package:alfaid/widgets/card_title.dart';
import 'package:flutter/material.dart';

class DetailCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final List<Widget> children;

  const DetailCard(
      {super.key,
      required this.icon,
      required this.title,
      required this.children});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          spacing: 12.0,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [CardTitle(icon: icon, title: title), ...children],
        ),
      ),
    );
  }
}
