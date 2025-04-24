import 'package:alfaid/widgets/cards/detail_card.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class OdometerInitialImg extends StatelessWidget {
  final String image;
  const OdometerInitialImg({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return DetailCard(
      icon: LucideIcons.map,
      title: 'Foto do odômetro',
      children: [
        const Text('Odômetro inicial'),
        Image.network(image),
      ],
    );
  }
}
