import 'package:flutter/material.dart';
import 'result_page.dart'; // Importa a página de resultado

class RotasPage extends StatelessWidget {
  const RotasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text(
          'Rotas',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Volta para a página anterior
          },
        ),
      ),
      // backgroundColor: Colors.black87,
      body: const Center(
        child: Text(
          'Ler QrCode e atribuir-se à rota',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          // simulamdo o resultado de um QR Code
          String simulatedQRCodeData =
              '{"rota": "0060", "destino": "Alfa Engenharia", "paradas": 12}';
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResultPage(data: simulatedQRCodeData),
            ),
          );
        },
        child: const Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
