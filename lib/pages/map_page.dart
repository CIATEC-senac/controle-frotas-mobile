import 'dart:convert'; // Para converter o JSON
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Para carregar o JSON dos assets
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
// ignore: unused_import
import 'package:http/http.dart' as http; // Para fazer requisições HTTP
// ignore: unused_import
import 'package:flutter_polyline_points/flutter_polyline_points.dart'; // Para traçar linhas no mapa

late BitmapDescriptor motoristaIcon; // Ícone do ônibus
late BitmapDescriptor passageiroIcon; // Ícone do trabalhador

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController? _mapController; // Controlador do mapa
  Set<Marker> _markers = {}; // Marcadores no mapa
  final Set<Polyline> _polylines = {}; // Linhas que formam a rota
  // ignore: unused_field
  LatLng? _currentPosition; // Posição atual do motorista
  // ignore: unused_field, prefer_final_fields
  List<LatLng> _routePoints = []; // Pontos da rota (coordenadas)

  final String apiKey = "AIzaSyDFieq3fbOX00euhBUc8co-WEudMUf44Xs";

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
    final String response = await rootBundle.loadString('assets/json/passageiros.json');
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
      // ignore: avoid_print
      print("Erro ao obter localização: $e");
    }
  }

  Future<void> _setMapStyle() async {
    final String style = await DefaultAssetBundle.of(context).loadString('assets/json/map_style.json');
    // ignore: deprecated_member_use
    _mapController?.setMapStyle(style);
  }

  void _showUnscheduledStopModal() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Parada não programada?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("NÃO")),
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("SIM")),
        ],
      ),
    );
  }

  void _showEndRouteModal() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Finalizar rota?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("NÃO")),
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("SIM")),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Mapa do Trajeto',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(-20.151510159413444, -44.87900580854352),
              zoom: 14.0,
            ),
            markers: _markers,
            polylines: _polylines,
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
              _setMapStyle(); // Aplica o estilo escuro
            },
          ),
          Positioned(
            top: 16,
            left: 16,
            child: SizedBox(
              height: 48,
              width: 48,
              child: FloatingActionButton(
                onPressed: _showUnscheduledStopModal,
                backgroundColor: Colors.red,
                child: const Icon(Icons.warning, size: 24),
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: ElevatedButton(
              onPressed: _showEndRouteModal,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                "FINALIZAR ROTA",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
