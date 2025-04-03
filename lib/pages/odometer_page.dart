import 'dart:io';
import 'package:alfaid/pages/map_page.dart';
import 'package:alfaid/widgets/appbar_card.dart';
import 'package:alfaid/widgets/odometer_card.dart';
import 'package:flutter/material.dart';

class OdometerStartPage extends StatefulWidget {
  const OdometerStartPage({super.key});

  @override
  State<OdometerStartPage> createState() => _OdometerStartPageState();
}

class _OdometerStartPageState extends State<OdometerStartPage> {
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
      MaterialPageRoute(builder: (context) => const MapPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isButtonEnabled = _image != null && _odometer.isNotEmpty;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 249, 250, 251),
      appBar: const AppBarCard(title: 'Quilometragem do veículo'),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            spacing: 10.0,
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  backgroundColor: isButtonEnabled ? Colors.green : Colors.grey,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Menos arredondado
                  ),
                ),
                child: Text(
                  'Ir para rota',
                  style: TextStyle(
                    color: isButtonEnabled
                        ? Colors.white
                        : Colors.black, // Branco quando habilitado
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
