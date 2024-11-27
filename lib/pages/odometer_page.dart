import 'dart:io';
import 'package:alfaid/pages/map_page.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class OdometerPage extends StatefulWidget {
  const OdometerPage({super.key});

  @override
  State<OdometerPage> createState() => _OdometerPageState();
}

class _OdometerPageState extends State<OdometerPage> {
  final TextEditingController odometerController = TextEditingController();
  Uint8List? _imageBytes;
  File? _selectedImage;
  bool _isButtonEnabled = false;

  void _pickImage() async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        if (kIsWeb) {
          final imageBytes = await pickedFile.readAsBytes();
          setState(() {
            _imageBytes = imageBytes;
            _updateButtonState();
          });
        } else {
          setState(() {
            _selectedImage = File(pickedFile.path);
            _updateButtonState();
          });
        }
      }
    } catch (e) {
      debugPrint("Erro ao capturar imagem: $e");
    }
  }

  void _updateButtonState() {
    setState(() {
      _isButtonEnabled = odometerController.text.isNotEmpty &&
          (_selectedImage != null || _imageBytes != null);
    });
  }

  void _navigateToMapPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MapPage(), // Página do mapa
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Informar Odômetro',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Informe a leitura atual do odômetro:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: odometerController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Odômetro (km)',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => _updateButtonState(),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'Inserir fotos do odômetro',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: IconButton(
                icon: const Icon(
                  Icons.camera_alt,
                  size: 50,
                  color: Colors.green,
                ),
                onPressed: _pickImage,
              ),
            ),
            if (_imageBytes != null)
              Center(
                child: Image.memory(
                  _imageBytes!,
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              )
            else if (_selectedImage != null)
              Center(
                child: Image.file(
                  _selectedImage!,
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _isButtonEnabled ? _navigateToMapPage : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: const Text('Ver Mapa do Trajeto'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}