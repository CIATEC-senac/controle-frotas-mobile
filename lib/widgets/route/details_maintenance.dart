import 'package:alfaid/models/maintenance.dart';
import 'package:alfaid/models/vehicle.dart';
import 'package:alfaid/widgets/cards/detail_card.dart';
import 'package:alfaid/widgets/detail_row.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class DetailsMaintenance extends StatelessWidget {
  final VehicleModel vehicle;

  const DetailsMaintenance({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    var today = DateTime.now().copyWith(hour: 0, minute: 0, second: 0);

    MaintenanceModel? nextMaintenance = vehicle.maintenances
        ?.where((maintenance) => maintenance.date.isAfter(today))
        .firstOrNull;

    return DetailCard(
      icon: LucideIcons.calendar,
      title: 'Manutenção',
      children: [
        DetailRow(label: 'Última manutenção:', value: 'N/A'),
        DetailRow(
            label: 'Próxima manutenção:',
            value: nextMaintenance?.date.toString() ?? 'N/A'),
      ],
    );
  }
}
