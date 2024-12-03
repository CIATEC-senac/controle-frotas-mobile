import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:alfaid/pages/success_page.dart'; // Atualize o caminho conforme o seu projeto

class HodometroFinalPage extends StatefulWidget {
  const HodometroFinalPage({super.key});

  @override
  _HodometroFinalPageState createState() => _HodometroFinalPageState();
}

class _HodometroFinalPageState extends State<HodometroFinalPage> {
  Uint8List? _selectedImageBytes;
  final TextEditingController odometerController = TextEditingController();
  bool _isButtonEnabled = false;

  Future<void> _pickImage() async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final imageBytes = await pickedFile.readAsBytes();
        setState(() {
          _selectedImageBytes = imageBytes;
          _updateButtonState();
        });
      }
    } catch (e) {
      debugPrint("Erro ao capturar imagem: $e");
    }
  }

  void _updateButtonState() {
    setState(() {
      _isButtonEnabled = odometerController.text.isNotEmpty && _selectedImageBytes != null;
    });
  }

  void _submitData() {
    debugPrint("Dados enviados: Odômetro - ${odometerController.text}");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SuccessPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Informar Odômetro',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Informe a leitura atual do hodômetro após finalizar a rota:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: odometerController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Odômetro (km)",
              ),
              onChanged: (value) => _updateButtonState(),
            ),
            const SizedBox(height: 16),
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
            if (_selectedImageBytes != null)
              Center(
                child: Image.memory(
                  _selectedImageBytes!,
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: _isButtonEnabled ? _submitData : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isButtonEnabled ? Colors.green : Colors.grey,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  "Enviar",
                  style: TextStyle(
                    color: _isButtonEnabled ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}