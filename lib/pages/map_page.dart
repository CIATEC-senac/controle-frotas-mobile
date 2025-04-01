import 'dart:convert'; // Para converter o JSON
import 'package:alfaid/widgets/appbar_card.dart';
import 'package:alfaid/widgets/button_route.dart';
import 'package:alfaid/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Para carregar o JSON dos assets
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:alfaid/pages/hodometro_final_page.dart'; // Atualize o nome do projeto aqui

late BitmapDescriptor motoristaIcon;
late BitmapDescriptor passageiroIcon;

enum RouteState { Idle, Running, Completed }

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final TextEditingController paradController = TextEditingController();
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};

  RouteState progress = RouteState.Idle;

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

  void _showEndRouteModal() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Finalizar rota?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("NÃO"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HodometroFinalPage(),
                ),
              );
            },
            child: const Text("SIM"),
          ),
        ],
      ),
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Variável para armazenar o título do botão
  String buttonTitle = 'Iniciar rota';
  Color buttonBackgroundColor = Colors.green;

  // Função para alterar o título do botão
  void _toggleButtonTitle() {
    setState(() {
      if (buttonTitle == 'Iniciar rota') {
        buttonTitle = 'Finalizar rota';
        buttonBackgroundColor = Colors.red;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Color getProgressBackgroundColor() {
      return switch (progress) {
        RouteState.Idle => Colors.green,
        RouteState.Running => Colors.red,
        RouteState.Completed => Colors.transparent,
      };
    }

    String getProgressText() {
      return switch (progress) {
        RouteState.Idle => "Iniciar rota",
        RouteState.Running => "Finalizar rota",
        RouteState.Completed => "Redirecionando...",
      };
    }

    void trackProgress() {
      setState(() {
        progress = switch (progress) {
          RouteState.Idle => RouteState.Running,
          RouteState.Running => RouteState.Completed,
          _ => progress,
        };
      });

      if (progress == RouteState.Completed) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HodometroFinalPage(),
          ),
        );
      }
    }

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color.fromARGB(255, 79, 75, 75),
      appBar: const AppBarCard(title: 'Mapa da rota'),
      drawer: const DrawerWidget(),
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
                  icon: const Icon(
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
                  icon: const Icon(
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
