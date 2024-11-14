import 'dart:convert';
import 'package:flutter/material.dart';
import 'odometer_page.dart'; // Importe a página de odômetro

class ResultPage extends StatelessWidget {
  final String data;

  const ResultPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> qrData = jsonDecode(data);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Informações da Rota',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Volta para a página anterior
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Dados do QR Code',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('Rota: ${qrData["rota"]}'),
            Text('Destino: ${qrData["destino"]}'),
            Text('Quantidade de Paradas: ${qrData["paradas"]}'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          // Navega para a página de odômetro e aguarda o valor inserido
          final odometerReading = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const OdometerPage(),
            ),
          );

          if (odometerReading != null) {
            // Exibe o valor do odômetro ou realiza outra ação
            print('Leitura do odômetro: $odometerReading');
          }
        },
        label: const Text(
          'Prosseguir',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        icon: const Icon(
          Icons.arrow_forward,
          color: Colors.white,
        ),
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
