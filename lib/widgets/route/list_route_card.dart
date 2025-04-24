import 'package:alfaid/models/history.dart';
import 'package:alfaid/models/history_approval.dart';
import 'package:daydart_flutter/daydart.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ListRouteCard extends StatelessWidget {
  final RouteHistoryModel history;
  final VoidCallback onPressed;

  const ListRouteCard(
      {super.key, required this.history, required this.onPressed});

  String getStreet(String address) {
    return address.split(',').first.toUpperCase();
  }

  Widget getStatusContainer(String text, Color bgColor, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
      ),
      child: Text(text, style: TextStyle(color: color, fontSize: 12.0)),
    );
  }

  Widget getStatus(HistoryStatus? status) {
    return switch (status) {
      HistoryStatus.approved => getStatusContainer(
          'Aprovada',
          Colors.green.withAlpha(80),
          Colors.green,
        ),
      HistoryStatus.disapproved => getStatusContainer(
          'Reprovada',
          Colors.red.withAlpha(80),
          Colors.red,
        ),
      _ => getStatusContainer(
          'Pendente',
          Colors.grey.withAlpha(80),
          Colors.grey,
        ),
    };
  }

  Widget getHeader() {
    return Wrap(
      spacing: 4.0,
      children: [
        const Text('ROTA '),
        Text(getStreet(history.route.path.origin ?? '')),
        const Icon(Icons.arrow_right_alt),
        Text(getStreet(history.route.path.destination ?? '')),
      ],
    );
  }

  Widget getRow(IconData icon, String text) {
    return Row(
      spacing: 12.0,
      children: [
        Icon(icon, size: 16),
        Expanded(
          child: Text(text, overflow: TextOverflow.ellipsis, maxLines: 3),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var startedAt = history.startedAt != null
        ? DayDart(history.startedAt)
            .subtract(3, DayUnits.h)
            .format('dd/MM/yyyy HH:mm:ss')
        : 'N/A';

    return Card(
      elevation: 1.0,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          spacing: 16.0,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: getHeader()),
                getStatus(history.approval?.status)
              ],
            ),
            getRow(LucideIcons.calendar, startedAt),
            getRow(LucideIcons.user2, history.driver.name),
            getRow(LucideIcons.mapPin, history.route.path.origin ?? 'N/A'),
            getRow(LucideIcons.pin, history.route.path.destination ?? 'N/A'),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: onPressed,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Ver detalhes'),
                      Icon(LucideIcons.chevronRight)
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
