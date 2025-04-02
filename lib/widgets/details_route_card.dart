import 'package:alfaid/widgets/widget_table.dart';
import 'package:flutter/material.dart';

class DetailsRouteCard extends StatelessWidget {
  String text;

  final route = {
    'Rota': "000",
    'Origem': "R. Sergipe, 771 - Centro",
    'Destino': "BLABlabla",
    'Horário de partida': "00:00",
    'Horário de chegada': "00:00",
    'Paradas': "15"
  };

  DetailsRouteCard({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              spacing: 12,
              children: [
                const Icon(
                  Icons.info_outline,
                  size: 28,
                ),
                Text(
                  text,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
            WidgetTable(data: route),
          ],
        ),
      ),
    );
  }
}
