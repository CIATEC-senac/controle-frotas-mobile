import 'package:alfaid/models/history.dart';
import 'package:alfaid/widgets/cards/detail_card.dart';
import 'package:alfaid/widgets/detail_row.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class RouteHistoryCard extends StatelessWidget {
  final RouteHistoryModel history;

  const RouteHistoryCard({
    super.key,
    required this.history,
  });

  @override
  Widget build(BuildContext context) {
    var origin = history.path?.origin;
    var destination = history.path?.destination;

    return DetailCard(
      icon: LucideIcons.pin,
      title: 'Rota ${history.route.id.toString().padLeft(4, '0')}',
      children: [
        DetailRow(label: 'Origem:', value: origin),
        DetailRow(label: 'Destino:', value: destination),
        DetailRow(label: 'Hora de início:', value: history.fStartedAt),
        DetailRow(label: 'Hora de término:', value: history.fEndedAt),
        DetailRow(
          label: 'Tempo previsto:',
          value: '${history.route.estimatedDuration.toString()} min',
        ),
        DetailRow(
            label: 'Tempo executado:', value: '${history.elapsedDuration} min'),
        DetailRow(
            label: 'Distância prevista:',
            value: '${history.route.kmEstimatedDistance.toString()} km'),
        DetailRow(
            label: 'Distância percorrida:',
            value: '${history.elapsedDistance} km'),
      ],
    );
  }
}
