import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

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
  LatLng? _currentPosition; // Posição atual do motorista

  // Lista de passageiros com suas coordenadas
  final List<Map<String, dynamic>> passageiros = [
    {"nome": "João", "latitude": -23.550520, "longitude": -46.633308},
    {"nome": "Maria", "latitude": -23.561680, "longitude": -46.625320},
    {"nome": "Carlos", "latitude": -23.547700, "longitude": -46.636390},
  ];

  @override
  void initState() {
    super.initState();
    _initializeIconsAndData(); // Inicializa ícones e carrega marcadores/localização
  }

  // Função para inicializar os ícones e carregar marcadores/localização
  Future<void> _initializeIconsAndData() async {
    await _loadCustomIcons(); // Aguarda a inicialização dos ícones
    _carregarMarcadores(); // Carrega os marcadores com ícones
    _setCurrentLocation(); // Configura a localização atual
  }

  // Função para carregar os ícones personalizados
  Future<void> _loadCustomIcons() async {
    motoristaIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(48, 48)),
      'assets/icons/onibus_icon.png', // Caminho do ícone do motorista
    );

    passageiroIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(48, 48)),
      'assets/icons/trabalhador_icon.png', // Caminho do ícone do passageiro
    );
  }

  // Função para carregar marcadores com base na lista de passageiros
  void _carregarMarcadores() {
    Set<Marker> marcadores = {};

    for (var passageiro in passageiros) {
      Marker marcador = Marker(
        markerId: MarkerId(passageiro["nome"]),
        position: LatLng(passageiro["latitude"], passageiro["longitude"]),
        icon: passageiroIcon, // Ícone do trabalhador
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

  // Função para obter a posição atual do motorista
  Future<void> _setCurrentLocation() async {
    try {
      Position position = await _getCurrentLocation();
      LatLng currentLatLng = LatLng(position.latitude, position.longitude);

      setState(() {
        _currentPosition = currentLatLng;
        _markers.add(
          Marker(
            markerId: const MarkerId("current_position"),
            position: currentLatLng,
            icon: motoristaIcon, // Ícone do ônibus
            infoWindow: const InfoWindow(title: "Sua posição atual"),
          ),
        );
      });

      // Move a câmera para a posição atual
      _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(currentLatLng, 14),
      );
    } catch (e) {
      print("Erro ao obter localização: $e");
    }
  }

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Verificar se o serviço de localização está habilitado
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception("O serviço de localização está desativado.");
    }

    // Verificar permissões de localização
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception("Permissão de localização negada.");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception("Permissão de localização permanentemente negada.");
    }

    // Retorna a posição atual
    return await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
      ),
    );
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
