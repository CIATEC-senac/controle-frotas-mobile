import 'package:alfaid/pages/route_details_page.dart';
import 'package:alfaid/widgets/card_info.dart';
import 'package:flutter/material.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:alfaid/widgets/appbar_card.dart';

class ScannerRoutePage extends StatelessWidget {
  const ScannerRoutePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCard(title: 'Escanear QrCode'),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 8.0,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 48.0),
              child: const CardInfo(
                icon: Icon(Icons.qr_code_2, size: 48.0),
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

          int? routeId = int.tryParse(code!);

          if (routeId != null && routeId != -1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    RouteDetailsPage(routeId: int.parse(code)),
              ),
            );
          }

          // TODO: Alertar erro
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
