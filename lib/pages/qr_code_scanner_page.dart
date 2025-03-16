import 'package:flutter/material.dart';

class QRCodeScannerPage extends StatefulWidget {
  const QRCodeScannerPage({super.key});

  @override
  _QRCodeScannerPageState createState() => _QRCodeScannerPageState();
}

class _QRCodeScannerPageState extends State<QRCodeScannerPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  // QRViewController? controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Leitor de QR Code')),
      body: Text(''),
      // body: QRView(
      //   key: qrKey,
      //   onQRViewCreated: _onQRViewCreated,
      // ),
    );
  }

  // void _onQRViewCreated(QRViewController controller) {
  //   this.controller = controller;
  //   controller.scannedDataStream.listen((scanData) {
  //     if (scanData.code != null) {
  //       // Pausa a câmera para evitar leituras repetidas
  //       controller.pauseCamera();
  //       Navigator.push(
  //         // ignore: use_build_context_synchronously
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => ResultPage(data: scanData.code!),
  //         ),
  //       ).then((_) => controller.resumeCamera()); // Retoma a câmera ao voltar para o scanner
  //     }
  //   });
  // }

  @override
  void dispose() {
    // controller?.dispose();
    super.dispose();
  }
}
