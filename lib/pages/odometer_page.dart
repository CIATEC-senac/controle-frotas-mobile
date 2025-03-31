import 'dart:io';
import 'package:alfaid/pages/map_page.dart';
import 'package:alfaid/widgets/appbar_card.dart';
import 'package:alfaid/widgets/insert_image.dart';
import 'package:flutter/material.dart';

class OdometerPage extends StatefulWidget {
  const OdometerPage({super.key});

  @override
  State<OdometerPage> createState() => _OdometerPageState();
}

class _OdometerPageState extends State<OdometerPage> {
  final TextEditingController odometerController = TextEditingController();
  File? _image;
  bool _isButtonEnabled = false;

  // Função que vai ser passada para o widget insertimage para inserir imagem
  void callback(File image) {
    setState(() {
      _image = image;
      _isButtonEnabled = odometerController.text.isNotEmpty && _image != null;
    });
  }

  // Função para ir para a página seguinte
  void _navigateToMapPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MapPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
              Card(
                elevation: 1.0,
                color: const Color(0xFFFFFFFF),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    spacing: 10.0,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Informe a leitura atual do odômetro:',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87),
                      ),
                      TextField(
                        controller: odometerController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: 'Ex: 189008',
                          helperMaxLines: 2,
                          helperText:
                              'Digite apenas números sem pontos ou espaços',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _isButtonEnabled =
                                odometerController.text.isNotEmpty &&
                                    _image != null;
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Enviar foto do odômetro',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      InsertImage(image: _image, callback: callback),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: _isButtonEnabled ? _navigateToMapPage : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      _isButtonEnabled ? Colors.green : Colors.grey,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Menos arredondado
                  ),
                ),
                child: Text(
                  'Ver Mapa do Trajeto',
                  style: TextStyle(
                    color: _isButtonEnabled
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
