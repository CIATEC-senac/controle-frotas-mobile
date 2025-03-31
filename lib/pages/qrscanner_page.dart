import 'package:alfaid/pages/odometer_page.dart';
import 'package:alfaid/widgets/appbar_card.dart';
import 'package:alfaid/widgets/card_info.dart';
import 'package:alfaid/widgets/details_maintenance.dart';
import 'package:alfaid/widgets/details_paradas_card.dart';
import 'package:alfaid/widgets/details_route_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class QrScannerDetailsPage extends StatefulWidget {
  final String? data;
  const QrScannerDetailsPage({super.key, this.data});

  @override
  State<QrScannerDetailsPage> createState() => _QrScannerDetailsPageState();
}

class _QrScannerDetailsPageState extends State<QrScannerDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCard(title: 'Detalhes da rota'),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            spacing: 12.0,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardInfo(
                icon: const Icon(Icons.directions_bus, size: 32.0),
                title: 'Placa: 123AD09',
                subTitle: 'QRCode: ${widget.data ?? 'Sem código'}',
              ),
              DetailsRouteCard(
                text: "Informações da Rota",
              ),
              DetailsMaintenance(
                text: "Manutenção",
              ),
            ],
          ),
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
