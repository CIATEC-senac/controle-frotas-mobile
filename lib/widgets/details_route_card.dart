import 'package:alfaid/models/route.dart';
import 'package:alfaid/widgets/widget_table.dart';
import 'package:flutter/material.dart';

class DetailsRouteCard extends StatelessWidget {
  final String text;
  final RouteModel? route;

  const DetailsRouteCard({super.key, required this.text, required this.route});

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
                const Icon(Icons.info_outline, size: 20),
                Text(text, style: Theme.of(context).textTheme.headlineSmall),
              ],
            ),
            if (route != null)
              Container(
                padding: const EdgeInsets.only(left: 16.0),
                child: WidgetTable(data: route!.fromModel()),
              ),
          ],
        ),
      ),
    );
  }
}
