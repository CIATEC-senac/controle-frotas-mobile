import 'package:alfaid/models/user.dart';
import 'package:alfaid/widgets/cards/detail_card.dart';
import 'package:alfaid/widgets/detail_row.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class DriverHistoryCard extends StatelessWidget {
  final UserModel driver;

  const DriverHistoryCard({
    super.key,
    required this.driver,
  });

  @override
  Widget build(BuildContext context) {
    return DetailCard(
      icon: LucideIcons.user2,
      title: 'Motorista',
      children: [
        Row(
          spacing: 12.0,
          children: [
            CircleAvatar(
              radius: 24.0,
              child: Text(driver.name[0].toUpperCase()),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    driver.name,
                    style: Theme.of(context).textTheme.headlineSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text('CNH: ${driver.cnh}'),
                ],
              ),
            )
          ],
        ),
        DetailRow(label: 'CPF:', value: driver.cpf),
        DetailRow(label: 'Email:', value: driver.email),
      ],
    );
  }
}
