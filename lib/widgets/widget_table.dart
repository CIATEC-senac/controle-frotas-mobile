import 'package:flutter/material.dart';

class WidgetTable extends StatelessWidget {
  final Map<String, dynamic> data;

  const WidgetTable({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Table(
      defaultColumnWidth: const FixedColumnWidth(150.0),
      border: const TableBorder(
        horizontalInside: BorderSide(
          style: BorderStyle.solid,
          color: Colors.grey,
          width: 0.5,
        ),
      ),
      children: data.entries.map((item) {
        return _createLineTable([item.key, item.value]);
      }).toList(),
    );
  }

  TableRow _createLineTable(List<String> cells) {
    return TableRow(
      children: cells.map((name) {
        return Container(
          alignment: Alignment.bottomLeft,
          padding: const EdgeInsets.all(18.0),
          child: Text(
            name,
            style: const TextStyle(fontSize: 16.0),
          ),
        );
      }).toList(),
    );
  }
}
