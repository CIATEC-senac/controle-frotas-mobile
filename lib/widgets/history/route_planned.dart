import 'package:alfaid/widgets/cards/detail_card.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class RoutePlanned extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const DetailCard(
      icon: LucideIcons.map,
      title: 'Rota planejada',
      children: [
        Text('Trajeto ideal calculado pelo sistema'),
      ],
    );
  }
}
