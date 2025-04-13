import 'package:alfaid/models/history.dart';
import 'package:alfaid/widgets/appbar_card.dart';
import 'package:alfaid/widgets/widget_table.dart';
import 'package:flutter/material.dart';

class ViewRoutePage extends StatelessWidget {
  final RouteHistoryModel history;

  const ViewRoutePage({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCard(title: 'Detalhes'),
      body: WidgetTable(data: history.fromModel()),
    );
  }
}
