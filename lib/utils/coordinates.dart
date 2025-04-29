import 'dart:math';

import 'package:location/location.dart';

/// Converte a diferença entre duas coordenadas em metros
Map<String, double> locationToMeters(
  LocationData a,
  LocationData b,
) {
  const double metersPerDegree = 111320.0;

  double avgLat = (a.latitude! + b.latitude!) / 2;
  double avgLatRad = avgLat * pi / 180; // Converter para radianos

  double deltaLat = (b.latitude! - a.latitude!) * metersPerDegree;
  double deltaLng =
      (b.longitude! - b.longitude!) * metersPerDegree * cos(avgLatRad);

  return {
    'deltaLat': deltaLat,
    'deltaLng': deltaLng,
  };
}
