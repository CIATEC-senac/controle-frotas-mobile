import 'package:flutter/material.dart';

class CardInfo extends StatelessWidget {
  IconData icon;
  String title;
  String? subTitle;

  CardInfo({
    super.key,
    this.icon = Icons.qr_code,
    required this.title,
    this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          spacing: 16.0,
          children: [
            Icon(
              icon,
              size: 24.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.headlineSmall),
                  getSubTitle(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getSubTitle(BuildContext context) {
    return subTitle == null
        ? Container()
        : Text(
            subTitle!,
            style: Theme.of(context).textTheme.bodySmall,
          );
  }
}
