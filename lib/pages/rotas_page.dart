import 'package:flutter/material.dart';
import 'qr_code_scanner_page.dart';

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
        centerTitle: true, // Centraliza o título
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context); // Volta para a página anterior
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.refresh,
              color: Colors.white,
            ), // Ícone de recarregar
            onPressed: () {
              // Ação para recarregar a página ou funcionalidade futura
            },
          ),
        ],
      ),
      backgroundColor: Colors.black87,
      body: const Center(
        child: Text(
          'Ler QrCode e atribuir-se à rota',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
          textAlign: TextAlign.center, // Centraliza o texto
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green, // Cor verde do botão
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const QRCodeScannerPage()),
          );

          if (result != null) {
            // Aqui você pode fazer algo com o resultado do QR Code escaneado
            print('QR Code escaneado: $result');
          }
        },
        child: const Icon(Icons.camera_alt), // Ícone de câmera
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation
          .endFloat, // Posição no canto inferior direito
    );
  }
}
