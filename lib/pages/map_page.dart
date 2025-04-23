import 'dart:async';

import 'package:alfaid/api/api.dart';
import 'package:alfaid/models/route.dart';
import 'package:alfaid/models/route_path_coordinates.dart';
import 'package:alfaid/pages/driver/odometer_end_page.dart';
import 'package:alfaid/pages/partials/create_route.dart';
import 'package:alfaid/pages/partials/start_run%20copy.dart';
import 'package:alfaid/pages/partials/stop_run.dart';
import 'package:alfaid/widgets/unprogrammed_stops.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class MapPage extends StatefulWidget {
  final RouteModel route;
  final int historyId;

  const MapPage({super.key, required this.route, required this.historyId});

  @override
  State<MapPage> createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  StreamSubscription? userPositionStream;

  final PolylinePoints polylinePoints = PolylinePoints();
  final Location location = Location();

  Completer<GoogleMapController> mapController = Completer();

  LocationData? _currentLocation;
  bool _isRunning = false;

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
              _currentLocation!.latitude!,
              _currentLocation!.longitude!,
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
          _currentLocation = location;
        });
      }
    });

    location.onLocationChanged.listen((newLoc) async {
      if (mounted) {
        setState(() {
          _currentLocation = newLoc;
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
    mapController.future.then((controller) => controller.dispose());
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

  void updateHistory(Map<String, dynamic> history) {
    API().updateHistory({"id": widget.historyId, ...history}).catchError((e) {
      print('### Error ${e.toString()}');
    });
  }

  void startRunning() {
    updateHistory({"startedAt": DateTime.now().toIso8601String()});

    setState(() {
      _isRunning = true;
    });
  }

  void stopRunning() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            insetPadding: const EdgeInsets.all(16.0),
            shape: ShapeDecoration.fromBoxDecoration(
              BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
            ).shape,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 12.0,
                children: [
                  Text(
                    'Finalizar rota?',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(
                    'Essa ação não pode ser desfeita',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Não'),
                      ),
                      TextButton(
                        onPressed: () {
                          updateHistory({
                            "endedAt": DateTime.now().toIso8601String(),
                          });

                          setState(() {
                            _isRunning = false;
                          });

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OdometerEndPage(
                                historyId: widget.historyId,
                              ),
                            ),
                          );
                        },
                        child: const Text('Sim'),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _currentLocation == null
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
                      _currentLocation!.latitude!,
                      _currentLocation!.longitude!,
                    ),
                    zoom: 20,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    mapController.complete(controller);
                  },
                ),
          if (_currentLocation != null && _isRunning)
            Positioned(
              bottom: 100.0,
              right: 16.0,
              child: FloatingActionButton(
                onPressed: () => showMaterialModalBottomSheet(
                  context: context,
                  builder: (context) =>
                      unprogrammedStopsDialog(context, widget.historyId),
                ),
                child: const Icon(LucideIcons.alertTriangle),
              ),
            ),
          Positioned(
            bottom: 0.0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Colors.white),
              padding: const EdgeInsets.all(12.0),
              child: _isRunning
                  ? StopRun(onPressed: stopRunning)
                  : StartRun(onPressed: startRunning),
            ),
          )
        ],
      ),
    );
  }
}
