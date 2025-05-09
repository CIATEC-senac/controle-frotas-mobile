import 'dart:io';

import 'package:alfaid/widgets/insert_image.dart';
import 'package:flutter/material.dart';

class OdometerCard extends StatelessWidget {
  final void Function(String) odometerCallback;
  final void Function(File) imageCallback;
  final String odometer;
  final File? image;
  final bool? enabled;

  const OdometerCard(
      {super.key,
      required this.odometerCallback,
      required this.imageCallback,
      required this.odometer,
      required this.image,
      this.enabled});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.0,
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 10.0,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Informe a leitura atual do odômetro:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            TextField(
              enabled: enabled,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Ex: 189008',
                border: OutlineInputBorder(),
              ),
              onChanged: odometerCallback,
            ),
            const SizedBox(height: 10.0),
            const Text(
              'Enviar foto do odômetro',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            InsertImage(image: image, callback: imageCallback),
          ],
        ),
      ),
    );
  }
}
