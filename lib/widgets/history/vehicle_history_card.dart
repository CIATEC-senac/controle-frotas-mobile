import 'package:alfaid/models/history.dart';
import 'package:alfaid/widgets/cards/detail_card.dart';
import 'package:alfaid/widgets/detail_row.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class VehicleHistoryCard extends StatelessWidget {
  final RouteHistoryModel history;

  const VehicleHistoryCard({
    super.key,
    required this.history,
  });

  Widget tag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.grey.shade300,
      ),
      child: Text(text),
    );
  }

  @override
  Widget build(BuildContext context) {
    String? elapsedDistance = history.elapsedDistance != null
        ? '${history.elapsedDistance} Km'
        : null;

    var odometerInitial = history.odometerInitial != null
        ? '${history.odometerInitial.toString()} Km'
        : null;

    var odometerFinal = history.odometerInitial != null
        ? '${history.odometerFinal.toString()} Km'
        : null;

    return DetailCard(icon: LucideIcons.bus, title: 'Veículo', children: [
      Text(history.vehicle.model),
      Row(
        spacing: 10.0,
        children: [
          tag(history.vehicle.plate),
          if (history.vehicle.fType != null) tag(history.vehicle.fType!),
        ],
      ),
      DetailRow(
        label: 'Odômetro inicial:',
        value: odometerInitial,
      ),
      DetailRow(
        label: 'Odômetro final:',
        value: odometerFinal,
      ),
      DetailRow(label: 'Distância percorrida:', value: elapsedDistance)
    ]);
  }
}
