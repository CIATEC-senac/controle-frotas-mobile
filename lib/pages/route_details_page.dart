import 'package:alfaid/api/api.dart';
import 'package:alfaid/models/route.dart';
import 'package:alfaid/pages/odometer_page.dart';
import 'package:alfaid/widgets/appbar_card.dart';
import 'package:alfaid/widgets/card_info.dart';
import 'package:alfaid/widgets/details_maintenance.dart';
import 'package:alfaid/widgets/details_route_card.dart';
import 'package:flutter/material.dart';

class RouteDetailsPage extends StatefulWidget {
  final int routeId;
  const RouteDetailsPage({super.key, required this.routeId});

  @override
  State<RouteDetailsPage> createState() => _RouteDetailsPageState();
}

class _RouteDetailsPageState extends State<RouteDetailsPage> {
  RouteModel? _route;

  // Chama a função da api que recebe o id da rota pelo qrcode e armazena
  void fetchRoute() {
    API().fetchRoute(widget.routeId).then((route) {
      print("### Update status ${route}");
      setState(() {
        _route = route;
      });
    }, onError: (e) {
      print(e);
    });
  }

  @override
  void initState() {
    super.initState();
    // Passamos a função para ser criada quando for inicializado
    fetchRoute();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCard(title: 'Detalhes da rota'),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            spacing: 12.0,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CardInfo(
                  icon: const Icon(Icons.directions_bus, size: 32.0),
                  title: 'Placa: ${_route?.vehicle?.plate}',
                  subTitle: 'QRCode: ${widget.routeId}'),
              DetailsRouteCard(text: "Informações da Rota", route: _route),
              DetailsMaintenance(text: "Manutenção"),
              const SizedBox(height: 56.0)
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          // Navega para a página de odômetro e aguarda o valor inserido
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const OdometerStartPage()),
          );
        },
        label: const Text('Prosseguir', style: TextStyle(color: Colors.white)),
        icon: const Icon(Icons.arrow_forward, color: Colors.white),
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
