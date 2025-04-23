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
  final int? id;
  final HistoryUnplannedStopType? type;
  final Coordinates? coordinates;

  const HistoryUnplannedStop({this.id, this.coordinates, this.type});

  int getType() {
    return switch (type!) {
      HistoryUnplannedStopType.traffic => 0,
      HistoryUnplannedStopType.closedRoad => 1,
      HistoryUnplannedStopType.blockedLane => 2,
      HistoryUnplannedStopType.gas => 3,
      HistoryUnplannedStopType.mechanicalProblem => 4,
      HistoryUnplannedStopType.accident => 5,
    };
  }
}
