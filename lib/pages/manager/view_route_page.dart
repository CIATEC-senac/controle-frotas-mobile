import 'package:alfaid/models/history.dart';
import 'package:alfaid/widgets/cards/appbar_card.dart';
import 'package:alfaid/widgets/history/driver_history_card.dart';
import 'package:alfaid/widgets/history/route_history_card.dart';
import 'package:alfaid/widgets/history/vehicle_history_card.dart';
import 'package:flutter/material.dart';

class ViewRouteHistoryPage extends StatelessWidget {
  final RouteHistoryModel history;

  const ViewRouteHistoryPage({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCard(title: 'Detalhes de rota finalizada'),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            spacing: 12.0,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DriverHistoryCard(driver: history.driver),
              VehicleHistoryCard(history: history),
              RouteHistoryCard(history: history),
            ],
          ),
        ),
      ),
    );
  }
}
