import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_mapbox_navigation/flutter_mapbox_navigation.dart';
import 'package:geolocator/geolocator.dart' as gl;
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as mp;

class MapboxPage extends StatefulWidget {
  @override
  State<MapboxPage> createState() => _MapboxPageState();
}

class _MapboxPageState extends State<MapboxPage> {
  mp.MapboxMap? mapboxMapController;
  // pegando a posição do usuário
  StreamSubscription? userPositionStream;

  // MapBoxNavigationViewController? controller;

  @override
  void initState() {
    super.initState();
    setupPositionTracking();
  }

  @override
  void dispose() {
    userPositionStream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          mp.MapWidget(
            onMapCreated: _onMapboxCreated,
            styleUri: mp.MapboxStyles.DARK,
          )
        ],
      ),
    );
  }

  void _onMapboxCreated(mp.MapboxMap controller) async {
    setState(
      () {
        mapboxMapController = controller;
      },
    );

    // Logic for displaying user position on map
    mapboxMapController?.location.updateSettings(
      mp.LocationComponentSettings(
        enabled: true,
        pulsingEnabled: true,
      ),
    );

    // logic for adding custom annotations
    final pointAnnotationManager =
        await mapboxMapController?.annotations.createPointAnnotationManager();

    final Uint8List imageData = await loadMarkerImage();

    mp.PointAnnotationOptions pointAnnotationOptions =
        mp.PointAnnotationOptions(
      image: imageData,
      iconSize: 0.05,
      geometry: mp.Point(
        coordinates: mp.Position(
          -44.897823,
          -20.146057,
        ),
      ),
    );

    pointAnnotationManager?.create(
      pointAnnotationOptions,
    );
  }

  Future<void> setupPositionTracking() async {
    bool serviceEnabled;
    gl.LocationPermission permission;

    serviceEnabled = await gl.Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Serviço de localização está desligado');
    }

    permission = await gl.Geolocator.checkPermission();

    if (permission == gl.LocationPermission.denied) {
      permission = await gl.Geolocator.requestPermission();
      if (permission == gl.LocationPermission.denied) {
        return Future.error('Permissões de localização negadas');
      }
    }

    if (permission == gl.LocationPermission.deniedForever) {
      return Future.error(
          'Permissões de localização foram permanentemente negadas.');
    }

    gl.LocationSettings locationSettings = const gl.LocationSettings(
      accuracy: gl.LocationAccuracy.high,
      distanceFilter: 100,
    );

    userPositionStream?.cancel();
    userPositionStream =
        gl.Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((
      gl.Position? position,
    ) {
      if (position != null && mapboxMapController != null) {
        mapboxMapController?.setCamera(
          mp.CameraOptions(
            zoom: 15,
            center: mp.Point(
              coordinates: mp.Position(
                position.longitude,
                position.latitude,
              ),
            ),
          ),
        );
      }
    });
  }

  Future<Uint8List> loadMarkerImage() async {
    var byteData = await rootBundle.load("assets/icons/pin.png");
    return byteData.buffer.asUint8List();
  }
}
