import 'package:alfaid/models/route.dart';
import 'package:alfaid/widgets/cards/detail_card.dart';
import 'package:alfaid/widgets/detail_row.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class DetailsRouteCard extends StatelessWidget {
  final RouteModel route;

  const DetailsRouteCard({
    super.key,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return DetailCard(
      icon: LucideIcons.pin,
      title: 'Rota ${route.name}',
      children: [
        DetailRow(label: 'Origem:', value: route.path.origin),
        DetailRow(label: 'Destino:', value: route.path.destination),
        DetailRow(
            label: 'Quantidade de paradas:',
            value: (route.path.stops?.length ?? 0).toString()),
      ],
    );
  }
}
