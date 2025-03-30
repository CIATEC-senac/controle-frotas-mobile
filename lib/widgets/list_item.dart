import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  Widget? prefix;
  String title;
  String? subTitle;
  Icon icon;
  VoidCallback onPressed;

  ListItem({
    super.key,
    required this.title,
    required this.onPressed,
    this.icon = const Icon(Icons.chevron_right),
    this.prefix,
    this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            prefix ?? Container(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.headlineSmall),
                  getSubTitle(context),
                ],
              ),
            ),
            IconButton(onPressed: onPressed, icon: icon)
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
