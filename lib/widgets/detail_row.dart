import 'package:flutter/material.dart';

class DetailRow extends StatelessWidget {
  final String label;
  final String? value;

  const DetailRow({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Text(
          label,
          style: TextStyle(color: Colors.grey.shade600),
        )),
        Expanded(
            child: Text(
          value ?? 'N/A',
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
        ))
      ],
    );
  }
}
