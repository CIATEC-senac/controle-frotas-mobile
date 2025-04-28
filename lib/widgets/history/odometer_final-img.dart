import 'package:alfaid/widgets/cards/detail_card.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class OdometerFinalImg extends StatelessWidget {
  final String image;
  const OdometerFinalImg({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return DetailCard(
      icon: LucideIcons.map,
      title: 'Foto do odômetro',
      children: [
        const Text('Odômetro final'),
        Image.network(image),
      ],
    );
  }
}
