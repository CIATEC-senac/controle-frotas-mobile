import 'dart:io';

import 'package:flutter/material.dart';
import 'package:alfaid/widgets/appbar_card.dart';
import 'package:alfaid/widgets/odometer_card.dart';
import 'package:alfaid/pages/success_page.dart';

class HodometroFinalPage extends StatefulWidget {
  const HodometroFinalPage({super.key});

  @override
  _HodometroFinalPageState createState() => _HodometroFinalPageState();
}

class _HodometroFinalPageState extends State<HodometroFinalPage> {
  String _odometer = "";
  File? _image;

  void imageCallback(File image) {
    setState(() {
      _image = image;
    });
  }

  void odometerCallback(String value) {
    setState(() {
      _odometer = value;
    });
  }

  void navigateToMapPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SuccessPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isButtonEnabled = _image != null && _odometer.isNotEmpty;

    return Scaffold(
      appBar: const AppBarCard(title: 'Informar odômetro'),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 10.0,
            children: [
              OdometerCard(
                odometer: _odometer,
                odometerCallback: odometerCallback,
                image: _image,
                imageCallback: imageCallback,
              ),
              ElevatedButton(
                onPressed: isButtonEnabled ? navigateToMapPage : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Menos arredondado
                  ),
                ),
                child: const Text(
                  'Ir para rota',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
