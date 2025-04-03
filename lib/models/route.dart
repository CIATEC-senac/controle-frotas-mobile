class RouteModel {
  final int id;
  final String origin;
  final String destiny;
  final int stopsCount;
  final int distancy;
  final int estimatedTime;

  const RouteModel({
    required this.id,
    required this.origin,
    required this.destiny,
    required this.stopsCount,
    required this.distancy,
    required this.estimatedTime,
  });

  Map<String, dynamic> fromModel() {
    return {
      'Rota': id.toString(),
      'Origem': origin,
      'Destino': destiny,
      'Horário de partida': "00:00",
      'Horário de chegada': "00:00",
      'Paradas': stopsCount.toString(),
    };
  }

  factory RouteModel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'origem': String origin,
        'destino': String destiny,
        'totalParadas': int stopsCount,
        'distancia': int distancy,
        'tempoEstimado': int estimatedTime,
      } =>
        RouteModel(
            id: id,
            origin: origin,
            destiny: destiny,
            stopsCount: stopsCount,
            distancy: distancy,
            estimatedTime: estimatedTime),
      _ => throw const FormatException('Erro ao buscar rota.'),
    };
  }
}
