import 'package:alfaid/models/history.dart';
import 'package:alfaid/widgets/appbar_card.dart';
import 'package:alfaid/widgets/card_info.dart';
import 'package:alfaid/widgets/details_maintenance.dart';
import 'package:alfaid/widgets/details_route_card.dart';
import 'package:alfaid/widgets/driver_history_card.dart';
import 'package:alfaid/widgets/route_history_card.dart';
import 'package:alfaid/widgets/vehicle_history_card.dart';
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
