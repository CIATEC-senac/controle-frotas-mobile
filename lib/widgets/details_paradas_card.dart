import 'package:alfaid/widgets/widget_table.dart';
import 'package:flutter/material.dart';

class DetailsParadasCard extends StatelessWidget {
  String text;

  final paradas = {
    '01': "Rua tal tal 00",
    '02': "Rua tal tal 11",
    '03': "Rua tal tal 02",
    '04': "Rua tal tal 33",
  };

  DetailsParadasCard({super.key, required this.text});

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
                  Icons.pin_drop_outlined,
                  size: 28,
                ),
                Text(
                  text,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
            WidgetTable(data: paradas),
          ],
        ),
      ),
    );
  }
}
