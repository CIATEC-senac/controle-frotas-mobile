import 'dart:async';

import 'package:alfaid/models/route.dart';
import 'package:alfaid/models/route_path_coordinates.dart';
import 'package:alfaid/pages/create_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:lucide_icons/lucide_icons.dart';

class MapSample extends StatefulWidget {
  final RouteModel route;
  const MapSample({super.key, required this.route});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  StreamSubscription? userPositionStream;

  final PolylinePoints polylinePoints = PolylinePoints();

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  LocationData? currentLocation;

  void getCurrentLocation() async {
    Location location = Location();

    location.getLocation().then((location) {
      currentLocation = location;

      if (mounted) {
        setState(() {});
      }
    });

    GoogleMapController controller = await _controller.future;

    location.onLocationChanged.listen((newLoc) async {
      currentLocation = newLoc;

      final zoom = await controller.getZoomLevel();

      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            zoom: zoom,
            target: LatLng(
              currentLocation!.latitude!,
              currentLocation!.longitude!,
            ),
          ),
        ),
      );

      if (mounted) {
        setState(() {});
      }
    });
  }

  static CameraPosition initialWaypoint(RouteModel route) {
    return CameraPosition(
      target: LatLng(
        route.coordinates.origin!.lat,
        route.coordinates.origin!.lng,
      ),
      zoom: 15,
    );
  }

  late Set<Polyline> _polylines = {};
  late Set<Marker> _markers;

  LatLng toLatLng(Coordinates coordinates) {
    return LatLng(coordinates.lat, coordinates.lng);
  }

  @override
  void dispose() {
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
                _controller.complete(controller);
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          GoogleMapController controller = await _controller.future;

          controller.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                bearing: 270.0,
                zoom: 30.0,
                tilt: 17.0,
                target: LatLng(
                  currentLocation!.latitude!,
                  currentLocation!.longitude!,
                ),
              ),
            ),
          );
        },
        child: const Icon(LucideIcons.alertTriangle),
      ),
    );
  }
}
