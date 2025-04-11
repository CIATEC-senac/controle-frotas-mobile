class RoutePath {
  final String? origin;
  final String? destination;
  final List<String>? stops;

  const RoutePath({this.origin, this.destination, this.stops});

  factory RoutePath.fromJson(Map<String, dynamic>? json) {
    return switch (json) {
      {
        'origin': String origin,
        'destination': String destination,
        'stops': List<dynamic> stops
      } =>
        RoutePath(
          origin: origin,
          destination: destination,
          stops: List<String>.from(stops),
        ),
      null => const RoutePath(),
      _ => throw const FormatException('Erro ao montar coordenadas.'),
    };
  }
}
