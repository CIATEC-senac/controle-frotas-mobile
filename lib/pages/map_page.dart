import 'dart:convert'; // Para converter o JSON
import 'package:alfaid/widgets/appbar_card.dart';
import 'package:alfaid/widgets/button_route.dart';
import 'package:alfaid/widgets/drawer_parada_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Para carregar o JSON dos assets
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:alfaid/pages/odometer_end_page.dart'; // Atualize o nome do projeto aqui

late BitmapDescriptor motoristaIcon;
late BitmapDescriptor passageiroIcon;

enum RouteState { idle, running, completed }

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final TextEditingController paradController = TextEditingController();
  Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};

  RouteState progress = RouteState.idle;

  GoogleMapController? _mapController;

  // ignore: unused_field
  LatLng? _currentPosition;
  // ignore: unused_field, prefer_final_fields
  List<LatLng> _routePoints = [];

  @override
  void initState() {
    super.initState();
    _initializeIconsAndData();
  }

  Future<void> _initializeIconsAndData() async {
    await _loadCustomIcons();
    await _carregarMarcadores();
    _setCurrentLocation();
  }

  Future<void> _loadCustomIcons() async {
    // ignore: deprecated_member_use
    motoristaIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(32, 32)),
      'assets/icons/onibus_icon.png',
    );

    // ignore: deprecated_member_use
    passageiroIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(32, 32)),
      'assets/icons/trabalhador_icon.png',
    );
  }

  Future<void> _carregarMarcadores() async {
    final String response =
        await rootBundle.loadString('assets/json/passageiros.json');
    final List<dynamic> data = jsonDecode(response);

    Set<Marker> marcadores = {};

    for (var passageiro in data) {
      Marker marcador = Marker(
        markerId: MarkerId(passageiro["nome"]),
        position: LatLng(passageiro["latitude"], passageiro["longitude"]),
        icon: passageiroIcon,
        infoWindow: InfoWindow(
          title: passageiro["nome"],
          snippet: "Localização do passageiro",
        ),
      );
      marcadores.add(marcador);
    }

    setState(() {
      _markers = marcadores;
    });
  }

  Future<void> _setCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition();
      LatLng currentLatLng = LatLng(position.latitude, position.longitude);

      setState(() {
        _currentPosition = currentLatLng;
        _markers.add(
          Marker(
            markerId: const MarkerId("current_position"),
            position: currentLatLng,
            icon: motoristaIcon,
            infoWindow: const InfoWindow(title: "Sua posição atual"),
          ),
        );
      });

      _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(currentLatLng, 14),
      );
    } catch (e) {
      print("Erro ao obter localização: $e");
    }
  }

  Future<void> _setMapStyle() async {
    final String style = await DefaultAssetBundle.of(context)
        .loadString('assets/json/map_style.json');
    // ignore: deprecated_member_use
    _mapController?.setMapStyle(style); // Aplica o estilo escuro
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // altera a cor do botão 'iniciar rota' conforme seu estado
    Color getProgressBackgroundColor() {
      return switch (progress) {
        RouteState.idle => Colors.green,
        RouteState.running => Colors.red,
        RouteState.completed => Colors.transparent,
      };
    }

    // Criando estados para quando o botão iniciar rota for chamado
    String getProgressText() {
      return switch (progress) {
        RouteState.idle => "Iniciar rota",
        RouteState.running => "Finalizar rota",
        RouteState.completed => "Redirecionando...",
      };
    }

    // Verificando o estado atual do titulo do botão e alterando
    void trackProgress() {
      setState(() {
        progress = switch (progress) {
          RouteState.idle => RouteState.running,
          RouteState.running => RouteState.completed,
          _ => progress,
        };
      });

      // Verificando se caso o estado do botão está como 'finalizar rota', caso sim redireciona para a próxima tela
      if (progress == RouteState.completed) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const OdometerEndPage(),
          ),
        );
      }
    }

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color.fromARGB(255, 79, 75, 75),
      appBar: const AppBarCard(title: 'Mapa da rota'),
      drawer: const DrawerParadaWidget(),
      body: Column(
        spacing: 10.0,
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: LatLng(-20.151510159413444, -44.87900580854352),
                zoom: 16.0,
              ),
              zoomControlsEnabled: false,
              markers: _markers,
              polylines: _polylines,
              onMapCreated: (GoogleMapController controller) {
                _mapController = controller;
                _setMapStyle(); // Aplica o estilo escuro
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              spacing: 16.0,
              children: [
                ButtonOptions(
                  color: Colors.greenAccent,
                  title: 'Registrar parada não programada',
                  prefixIcon: const Icon(
                    Icons.warning_amber_outlined,
                    color: Colors.white,
                  ),
                  onPressed: () => {
                    _scaffoldKey.currentState?.openDrawer(),
                  },
                ),
                ButtonOptions(
                  color: getProgressBackgroundColor(),
                  title: getProgressText(),
                  prefixIcon: const Icon(
                    Icons.play_arrow_outlined,
                    color: Colors.white,
                    size: 28,
                  ),
                  onPressed: trackProgress,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
