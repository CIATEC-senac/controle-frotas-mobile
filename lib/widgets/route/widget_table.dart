import 'package:flutter/material.dart';

class WidgetTable extends StatelessWidget {
  final Map<String, dynamic> data;

  const WidgetTable({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {
        0: FixedColumnWidth(80.0),
      },
      border: const TableBorder(
        horizontalInside: BorderSide(
          style: BorderStyle.solid,
          color: Colors.grey,
          width: 0.5,
        ),
      ),
      children: data.entries
          .map((item) => _createLineTable([item.key, item.value ?? '']))
          .toList(),
    );
  }

  TableRow _createLineTable(List<String> cells) {
    return TableRow(
      children: cells
          .map(
            (name) => Container(
              alignment: Alignment.bottomLeft,
              padding:
                  const EdgeInsets.symmetric(vertical: 14.0, horizontal: 8.0),
              child: Text(name, style: const TextStyle(fontSize: 14.0)),
            ),
          )
          .toList(),
    );
  }
}
