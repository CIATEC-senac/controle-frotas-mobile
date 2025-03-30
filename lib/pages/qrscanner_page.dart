import 'package:alfaid/pages/odometer_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class QrScannerPage extends StatefulWidget {
  final String? data;
  const QrScannerPage({super.key, this.data});

  @override
  State<QrScannerPage> createState() => _QrScannerPageState();
}

class _QrScannerPageState extends State<QrScannerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF424242),
        title: const Text(
          'Informações de Rota',
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
        centerTitle: true,
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
            Text('QrCode: ${widget.data ?? 'Sem código'}'),
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
