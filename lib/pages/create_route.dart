import 'package:google_maps_flutter/google_maps_flutter.dart';

Set<Marker> createMarkers(List<LatLng> waypoints) {
  return waypoints.map((waypoint) {
    return Marker(
      markerId: MarkerId(waypoint.latitude.toString()),
      position: waypoint,
    );
  }).toSet();
}
