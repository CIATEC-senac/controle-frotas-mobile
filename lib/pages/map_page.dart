import 'dart:async';

import 'package:alfaid/models/route.dart';
import 'package:alfaid/models/route_path_coordinates.dart';
import 'package:alfaid/pages/create_route.dart';
import 'package:alfaid/widgets/unprogrammed_stops.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class MapPage extends StatefulWidget {
  final RouteModel route;
  const MapPage({super.key, required this.route});

  @override
  State<MapPage> createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  StreamSubscription? userPositionStream;

  final PolylinePoints polylinePoints = PolylinePoints();

  Completer<GoogleMapController> mapController = Completer();

  final Location location = Location();

  LocationData? currentLocation;

  void animateCamera({
    required LatLng location,
    double? zoom,
  }) async {
    if (!mounted) {
      return;
    }

    mapController.future.then((controller) async {
      final cameraZoom = zoom ?? await controller.getZoomLevel();

      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            zoom: cameraZoom,
            target: LatLng(
              currentLocation!.latitude!,
              currentLocation!.longitude!,
            ),
          ),
        ),
      );
    });
  }

  void getCurrentLocation() async {
    location.getLocation().then((location) {
      if (mounted) {
        setState(() {
          currentLocation = location;
        });
      }
    });

    location.onLocationChanged.listen((newLoc) async {
      if (mounted) {
        setState(() {
          currentLocation = newLoc;
        });
      }

      animateCamera(
        location: LatLng(newLoc.latitude!, newLoc.longitude!),
      );
    });
  }

  late Set<Polyline> _polylines = {};
  late Set<Marker> _markers;

  LatLng toLatLng(Coordinates coordinates) {
    return LatLng(coordinates.lat, coordinates.lng);
  }

  @override
  void dispose() {
    mapController.future.then((controller) {
      controller.dispose();
    });
    userPositionStream?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    getCurrentLocation();
    drawPolylines();
    drawMarkers();

    super.initState();
  }

  void drawPolylines() async {
    var result = await polylinePoints.getRouteBetweenCoordinates(
        googleApiKey: const String.fromEnvironment(
          'GOOGLE_MAPS_APIKEY',
          defaultValue: 'AIzaSyAtnsmelP2XXZQxSgDOnn9ra2RLv3LOKWA',
        ),
        request: PolylineRequest(
          origin: PointLatLng(
            widget.route.coordinates.origin!.lat,
            widget.route.coordinates.origin!.lng,
          ),
          destination: PointLatLng(
            widget.route.coordinates.destination!.lat,
            widget.route.coordinates.destination!.lng,
          ),
          mode: TravelMode.driving,
          optimizeWaypoints: true,
          wayPoints: widget.route.path.stops!
              .map((waypoint) => PolylineWayPoint(location: waypoint))
              .toList(),
        ));

    Set<Polyline> polylines = {
      Polyline(
        polylineId: const PolylineId(''),
        points: result.points
            .map((point) => LatLng(point.latitude, point.longitude))
            .toList(),
        color: Colors.deepPurple.shade300.withAlpha(200),
        width: 5,
        geodesic: true,
      )
    };

    setState(() {
      _polylines = polylines;
    });
  }

  void drawMarkers() {
    List<Coordinates> waypoints = [];

    waypoints.add(widget.route.coordinates.origin!);
    waypoints.add(widget.route.coordinates.destination!);
    waypoints.addAll(widget.route.coordinates.stops!);

    List<LatLng> locations = waypoints.map((stop) => toLatLng(stop)).toList();

    setState(() {
      _markers = createMarkers(locations);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: currentLocation == null
            ? const Center(child: Text('Carregando...'))
            : GoogleMap(
                polylines: _polylines,
                zoomControlsEnabled: false,
                markers: _markers,
                myLocationButtonEnabled: false,
                myLocationEnabled: true,
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  bearing: 0.0,
                  tilt: 0.0,
                  target: LatLng(
                    currentLocation!.latitude!,
                    currentLocation!.longitude!,
                  ),
                  zoom: 20,
                ),
                onMapCreated: (GoogleMapController controller) {
                  mapController.complete(controller);
                },
              ),
        floatingActionButton: currentLocation == null
            ? null
            : Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    onPressed: () => showMaterialModalBottomSheet(
                      context: context,
                      builder: unprogrammedStopsDialog,
                    ),
                    child: const Icon(LucideIcons.alertTriangle),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Iniciar',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  )
                ],
              ));
  }
}
