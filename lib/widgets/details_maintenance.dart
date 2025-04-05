import 'package:alfaid/widgets/widget_table.dart';
import 'package:flutter/material.dart';

class DetailsMaintenance extends StatelessWidget {
  final String text;

  final maintenances = {
    'Última': "00/00/00",
    'Próxima': "00/00/00",
  };

  DetailsMaintenance({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              spacing: 12,
              children: [
                const Icon(Icons.calendar_today_outlined, size: 20.0),
                Text(text, style: Theme.of(context).textTheme.headlineSmall),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(left: 16.0),
              child: WidgetTable(data: maintenances),
            ),
          ],
        ),
      ),
    );
  }
}
