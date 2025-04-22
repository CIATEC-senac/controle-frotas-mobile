import 'dart:async';

import 'package:alfaid/models/route.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  final RouteModel route;
  const MapSample({super.key, required this.route});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  StreamSubscription? userPositionStream;

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static CameraPosition initialWaypoint(RouteModel route) {
    return CameraPosition(
      target: LatLng(
        route.coordinates.origin!.lat,
        route.coordinates.origin!.lng,
      ),
      zoom: 14.4746,
    );
  }

  @override
  void dispose() {
    userPositionStream?.cancel();
    super.dispose();
  }

  // static const CameraPosition _kLake = CameraPosition(
  //     target: LatLng(37.43296265331129, -122.08832357078792),
  //     zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        myLocationEnabled: true,
        mapType: MapType.normal,
        initialCameraPosition: initialWaypoint(widget.route),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          setupPositionTracking(controller);
        },
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: _goToTheLake,
      //   label: const Text('To the lake!'),
      //   icon: const Icon(Icons.directions_boat),
      // ),
    );
  }

  // Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await _controller.future;
  //   await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  // }

  Future<void> setupPositionTracking(GoogleMapController controller) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Serviço de localização está desligado');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Permissões de localização negadas');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Permissões de localização foram permanentemente negadas.');
    }

    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    userPositionStream?.cancel();

    userPositionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position position) {
      controller.moveCamera(
        CameraUpdate.newLatLng(
          LatLng(position.latitude, position.longitude),
        ),
      );
    });
  }
}
