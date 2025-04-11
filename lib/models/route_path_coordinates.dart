class Coordinates {
  final double lat;
  final double lng;

  const Coordinates({required this.lat, required this.lng});

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'lat': num lat,
        'lng': num lng,
      } =>
        Coordinates(
          lat: lat.toDouble(),
          lng: lng.toDouble(),
        ),
      _ => throw const FormatException('Erro ao buscar coordenadas')
    };
  }
}

class RoutePathCoordinates {
  final Coordinates? origin;
  final Coordinates? destination;
  final List<Coordinates>? stops;

  const RoutePathCoordinates({
    this.origin,
    this.destination,
    this.stops,
  });

  factory RoutePathCoordinates.fromJson(Map<String, dynamic>? json) {
    return switch (json) {
      {
        'origin': Map<String, dynamic> origin,
        'destination': Map<String, dynamic> destination,
        'stops': List<dynamic> stops
      } =>
        RoutePathCoordinates(
          origin: Coordinates.fromJson(origin),
          destination: Coordinates.fromJson(destination),
          stops: stops.map((stop) => Coordinates.fromJson(stop)).toList(),
        ),
      null => const RoutePathCoordinates(),
      _ => throw const FormatException('Erro ao montar trajeto.'),
    };
  }
}
