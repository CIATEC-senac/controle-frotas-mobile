import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final Widget? prefix;
  final String title;
  final String? subTitle;
  final Icon icon;
  final VoidCallback onPressed;

  const ListItem({
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
      elevation: 1,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            if (prefix != null) prefix!,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.headlineSmall),
                  if (subTitle != null)
                    Text(
                      subTitle!,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                ],
              ),
            ),
            IconButton(onPressed: onPressed, icon: icon)
          ],
        ),
      ),
    );
  }
}
