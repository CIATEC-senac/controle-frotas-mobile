import 'package:alfaid/widgets/cards/detail_card.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class UnprogrammedStops extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const DetailCard(
      icon: LucideIcons.alertTriangle,
      title: 'Paradas não programadas',
      children: [
        Text('Interrupções registradas durante o percurso'),
      ],
    );
  }
}
