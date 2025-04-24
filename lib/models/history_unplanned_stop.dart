import 'package:alfaid/models/route_path_coordinates.dart';

enum HistoryUnplannedStopType {
  traffic,
  closedRoad,
  blockedLane,
  gas,
  mechanicalProblem,
  accident,
}

class HistoryUnplannedStop {
  final int id;
  final HistoryUnplannedStopType type;
  final Coordinates coordinates;
  final DateTime date;

  const HistoryUnplannedStop({
    required this.id,
    required this.coordinates,
    required this.type,
    required this.date,
  });

  int getType() {
    return switch (type) {
      HistoryUnplannedStopType.traffic => 0,
      HistoryUnplannedStopType.closedRoad => 1,
      HistoryUnplannedStopType.blockedLane => 2,
      HistoryUnplannedStopType.gas => 3,
      HistoryUnplannedStopType.mechanicalProblem => 4,
      HistoryUnplannedStopType.accident => 5,
    };
  }

  String getStringType() {
    return switch (type) {
      HistoryUnplannedStopType.traffic => 'Trânsito',
      HistoryUnplannedStopType.closedRoad => 'Via interditada',
      HistoryUnplannedStopType.blockedLane => 'Faixa bloqueada',
      HistoryUnplannedStopType.gas => 'Combustível',
      HistoryUnplannedStopType.mechanicalProblem => 'Problema mecânico',
      HistoryUnplannedStopType.accident => 'Acidente',
    };
  }

  static HistoryUnplannedStopType parseType(int type) {
    return switch (type) {
      0 => HistoryUnplannedStopType.traffic,
      1 => HistoryUnplannedStopType.closedRoad,
      2 => HistoryUnplannedStopType.blockedLane,
      3 => HistoryUnplannedStopType.gas,
      4 => HistoryUnplannedStopType.mechanicalProblem,
      _ => HistoryUnplannedStopType.accident
    };
  }

  factory HistoryUnplannedStop.fromJson(Map<String, dynamic> json) {
    try {
      return HistoryUnplannedStop(
        id: json['id'],
        type: HistoryUnplannedStop.parseType(json['type']),
        date: DateTime.parse(json['date']),
        coordinates: Coordinates(
          lat: json['coordinates']['lat'],
          lng: json['coordinates']['lng'],
        ),
      );
    } catch (e) {
      throw FormatException(
          'Erro ao parsear HistoryUnplannedStop: ${e.toString()}');
    }
  }
}
