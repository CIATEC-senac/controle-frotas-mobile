import 'package:alfaid/api/api.dart';
import 'package:alfaid/models/route.dart';
import 'package:alfaid/pages/driver/odometer_page.dart';
import 'package:alfaid/widgets/cards/appbar_card.dart';
import 'package:alfaid/widgets/cards/card_info.dart';
import 'package:alfaid/widgets/history/driver_history_card.dart';
import 'package:alfaid/widgets/route/details_maintenance.dart';
import 'package:alfaid/widgets/route/route_card.dart';
import 'package:flutter/material.dart';

class RouteDetailsPage extends StatefulWidget {
  final int routeId;
  const RouteDetailsPage({super.key, required this.routeId});

  @override
  State<RouteDetailsPage> createState() => _RouteDetailsPageState();
}

class _RouteDetailsPageState extends State<RouteDetailsPage> {
  bool _isLoading = true;
  bool _isError = false;
  RouteModel? _route;

  // Chama a função da api que recebe o id da rota pelo qrcode e armazena
  void fetchRoute() {
    setState(() {
      _isLoading = true;
    });

    API().fetchRoute(widget.routeId).then((route) {
      setState(() {
        _route = route;
        _isError = false;
      });
    }, onError: (e) {
      print(e);
      setState(() {
        _isError = true;
      });
    }).whenComplete(() {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    // Passamos a função para ser criada quando for inicializado
    fetchRoute();
  }

  Widget getChildren(BuildContext context) {
    if (_isLoading) {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('Carregando...')],
        ),
      );
    }

    if (_isError) {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Nâo foi possível buscar rota'),
            TextButton(
                onPressed: fetchRoute, child: const Text('Tentar novamente'))
          ],
        ),
      );
    }

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 12.0,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CardInfo(
                icon: const Icon(Icons.directions_bus, size: 32.0),
                title: 'Placa: ${_route?.vehicle?.plate}',
                subTitle: 'Modelo: ${_route?.vehicle?.model}'),
            DriverHistoryCard(driver: _route!.driver!),
            DetailsRouteCard(route: _route!),
            DetailsMaintenance(vehicle: _route!.vehicle!),
            const SizedBox(height: 56.0),
          ],
        ),
      ),
    );
  }

  void onPressed() async {
    // Navega para a página de odômetro e aguarda o valor inserido
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => OdometerStartPage(
                route: _route!,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCard(title: 'Detalhes da rota'),
      body: getChildren(context),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _route != null ? onPressed : null,
        label: const Text('Prosseguir', style: TextStyle(color: Colors.white)),
        icon: const Icon(Icons.arrow_forward, color: Colors.white),
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
