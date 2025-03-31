import 'package:flutter/material.dart';

class CardInfo extends StatelessWidget {
  Icon icon;
  String title;
  String? subTitle;

  CardInfo({
    super.key,
    this.icon = const Icon(Icons.qr_code),
    required this.title,
    this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          spacing: 16.0,
          children: [
            icon,
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
