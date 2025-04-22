import 'package:alfaid/models/user.dart';
import 'package:alfaid/pages/driver/scanner_route_page.dart';
import 'package:alfaid/pages/manager/history_route_page.dart';
import 'package:alfaid/widgets/list_item.dart';
import 'package:flutter/material.dart';

class DriverHomePartial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListItem(
          title: "Rotas",
          subTitle: "Acessar rotas",
          onPressed: () {
            // Navega para a página de Rotas
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ScannerRoutePage(),
              ),
            );
          },
        ),
        ListItem(
          title: 'Histórico de rotas',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HistoryRoutePage(
                  role: UserRole.driver,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
