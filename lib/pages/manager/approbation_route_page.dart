import 'package:alfaid/api/api.dart';
import 'package:alfaid/models/history.dart';
import 'package:alfaid/models/history_approval.dart';
import 'package:alfaid/models/user.dart';
import 'package:alfaid/pages/manager/history_route_page.dart';
import 'package:alfaid/widgets/cards/appbar_card.dart';
import 'package:alfaid/widgets/cards/detail_card.dart';
import 'package:alfaid/widgets/detail_row.dart';
import 'package:alfaid/widgets/history/driver_history_card.dart';
import 'package:alfaid/widgets/history/route_disapprovement_dialog.dart';
import 'package:alfaid/widgets/history/route_executed.dart';
import 'package:alfaid/widgets/history/route_history_card.dart';
import 'package:alfaid/widgets/history/route_planned.dart';
import 'package:alfaid/widgets/history/stops_unprogrammed.dart';
import 'package:alfaid/widgets/history/vehicle_history_card.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:toastification/toastification.dart';

class ApprobationRoutePage extends StatelessWidget {
  final UserRole role;
  final RouteHistoryModel history;

  const ApprobationRoutePage({
    super.key,
    required this.history,
    required this.role,
  });

  void confirm(context) {
    var observation = '';

    API()
        .updateHistoryStatus(history.id!, HistoryStatus.approved, observation)
        .then((_) {
      toastification.show(
          callbacks: ToastificationCallbacks(
            onAutoCompleteCompleted: (_) => goHome(context),
            onDismissed: (_) => goHome(context),
          ),
          type: ToastificationType.success,
          title: const Text('Rota aprovada com sucesso'),
          alignment: Alignment.topCenter,
          autoCloseDuration: const Duration(seconds: 3),
          borderRadius: BorderRadius.circular(4.0),
          style: ToastificationStyle.flat);
    }).catchError((e) {
      print('Ih, deu ruim');
      print(e.toString());
    });
  }

  Future<dynamic> goHome(context) {
    return Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HistoryRoutePage(role: role)),
    );
  }

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
              RoutePlanned(),
              RouteExecuted(),
              UnprogrammedStops(),
              approvalCard(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget approvalCard(BuildContext context) {
    var status = switch (history.approval?.status) {
      HistoryStatus.approved => 'Aprovada',
      HistoryStatus.disapproved => 'Reprovada',
      _ => 'Pendente'
    };

    return DetailCard(icon: LucideIcons.rotateCcw, title: 'Status', children: [
      DetailRow(label: 'Status:', value: status),
      ...getApproval(context),
    ]);
  }

  List<Widget> getApproval(BuildContext context) {
    if (history.approval != null) {
      return [
        DetailRow(
          label: 'Aprovada por:',
          value: history.approval!.approvedBy.name,
        ),
        DetailRow(
          label: 'Aprovada em:',
          value: history.approval!.fDate,
        ),
        if (history.approval!.observation!.isNotEmpty)
          DetailRow(label: 'Observação:', value: history.approval!.observation)
      ];
    }

    if (role == UserRole.manager) {
      return [
        Row(
          children: [
            Expanded(
              child: TextButton.icon(
                onPressed: () => routeDisapprovementDialog(history, context),
                icon: const Icon(LucideIcons.x, color: Colors.red),
                label: const Text(
                  'Reprovar',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
            Expanded(
              child: TextButton.icon(
                onPressed: () => confirm(context),
                icon: const Icon(LucideIcons.check),
                label: const Text('Aprovar'),
              ),
            )
          ],
        ),
      ];
    }

    return [];
  }
}
