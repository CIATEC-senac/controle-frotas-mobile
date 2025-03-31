import 'package:alfaid/widgets/widget_table.dart';
import 'package:flutter/material.dart';

class DetailsMaintenance extends StatelessWidget {
  String text;

  final maintenances = {
    'Última manutenção': "00/00/00",
    'Próxima manutenção': "00/00/00",
  };

  DetailsMaintenance({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              spacing: 12,
              children: [
                const Icon(
                  Icons.calendar_today_outlined,
                  size: 28,
                ),
                Text(
                  text,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
            WidgetTable(data: maintenances),
          ],
        ),
      ),
    );
  }
}
