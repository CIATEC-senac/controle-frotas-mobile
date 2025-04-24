import 'package:alfaid/models/history.dart';
import 'package:alfaid/widgets/cards/detail_card.dart';
import 'package:daydart_flutter/daydart.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class UnplannedStop extends StatelessWidget {
  final RouteHistoryModel history;

  const UnplannedStop({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    return DetailCard(
      icon: LucideIcons.alertTriangle,
      title: 'Paradas não programadas',
      children: [
        const Text('Interrupções registradas durante o percurso'),
        ...history.unplannedStops.map(
          (unplannedStop) => Text(
              '${unplannedStop.getStringType()} às ${DayDart(unplannedStop.date).subtract(3, DayUnits.h).format(('HH:mm:ss'))}'),
        )
      ],
    );
  }
}
