import 'package:alfaid/pages/route_details_page.dart';
import 'package:alfaid/widgets/card_info.dart';
import 'package:flutter/material.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:alfaid/widgets/appbar_card.dart';

class ScannerRoutePage extends StatefulWidget {
  const ScannerRoutePage({Key? key}) : super(key: key);

  @override
  State<ScannerRoutePage> createState() => _ScannerRoutePageState();
}

class _ScannerRoutePageState extends State<ScannerRoutePage> {
  @override
  Widget build(BuildContext context) {
    String result = '';

    return Scaffold(
      appBar: AppBarCard(title: 'Escanear QrCode'),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 8.0,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 48.0),
              child: CardInfo(
                icon: const Icon(
                  Icons.qr_code_2,
                  size: 48.0,
                ),
                title: 'Rota',
                subTitle:
                    'Clique no botão abaixo para fazer escaneamento de código',
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.green,
        onPressed: () async {
          String? code = await SimpleBarcodeScanner.scanBarcode(
            context,
            barcodeAppBar: const BarcodeAppBar(
              centerTitle: false,
              enableBackButton: true,
              backButtonIcon: Icon(Icons.arrow_back),
            ),
            isShowFlashIcon: true,
            delayMillis: 500,
            cameraFace: CameraFace.back,
            scanFormat: ScanFormat.ONLY_QR_CODE,
          );

          print("### Código: $code");

          setState(() => result = code! != '-1' ? code : 'Não validado');
          // result = code as String;

          // Valida e atualiza a variavel result e verifica se não está vazio para exibir na tela
          if (result != '' && result.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(bottom: 24.0),
            );

          if (code != null && code != '-1') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RouteDetailsPage(data: code),
              ),
            );
          }
        },
        icon: const Icon(
          Icons.qr_code_scanner,
          color: Colors.white,
        ),
        label: const Text(
          'Validar',
          style: TextStyle(color: Colors.white, fontSize: 18.0),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
