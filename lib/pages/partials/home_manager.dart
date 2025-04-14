import 'package:alfaid/pages/manager/approbation_route_page.dart';
import 'package:alfaid/widgets/list_item.dart';
import 'package:flutter/material.dart';

class ManagerHomePartial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListItem(
          title: 'Rotas finalizadas',
          subTitle: 'Aprovar rotas',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ApprobationRoutePage(),
              ),
            );
          },
        )
      ],
    );
  }
}
