import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController _mapController; // Controlador do mapa
  Set<Marker> _markers = {}; // Marcadores no mapa

  // Lista de passageiros com suas coordenadas
  final List<Map<String, dynamic>> passageiros = [
    {"nome": "João", "latitude": -23.550520, "longitude": -46.633308},
    {"nome": "Maria", "latitude": -23.561680, "longitude": -46.625320},
    {"nome": "Carlos", "latitude": -23.547700, "longitude": -46.636390},
  ];

  @override
  void initState() {
    super.initState();
    _carregarMarcadores(); // Chama a função para carregar os marcadores
  }

  // Função para carregar marcadores com base na lista de passageiros
  void _carregarMarcadores() {
    Set<Marker> marcadores = {};

    for (var passageiro in passageiros) {
      Marker marcador = Marker(
        markerId: MarkerId(passageiro["nome"]),
        position: LatLng(passageiro["latitude"], passageiro["longitude"]),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Mapa do Trajeto',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(-23.550520, -46.633308), // Coordenadas iniciais (São Paulo)
          zoom: 14.0,
        ),
        markers: _markers, // Marcadores exibidos no mapa
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
        },
      ),
    );
  }
}