import 'package:alfaid/models/history_approval.dart';
import 'package:alfaid/models/route.dart';
import 'package:alfaid/models/route_path.dart';
import 'package:alfaid/models/route_path_coordinates.dart';
import 'package:alfaid/models/user.dart';
import 'package:alfaid/models/vehicle.dart';
import 'package:alfaid/utils/date_manipulation.dart';

class RouteHistoryModel {
  final int? id;
  final double? odometerInitial;
  final double? odometerFinal;
  final String? imgOdometerInitial;
  final String? imgOdometerFinal;
  final RoutePathCoordinates? coordinates;
  final RoutePath? path;
  final DateTime? startedAt;
  final DateTime? endedAt;
  final RouteModel route;
  final UserModel driver;
  final VehicleModel vehicle;
  final HistoryApproval? approval;

  const RouteHistoryModel({
    this.id,
    this.odometerInitial,
    this.odometerFinal,
    this.imgOdometerInitial,
    this.imgOdometerFinal,
    this.coordinates,
    this.path,
    this.startedAt,
    this.endedAt,
    required this.route,
    required this.driver,
    required this.vehicle,
    this.approval,
  });

  String? get elapsedDistance {
    if (odometerInitial != null && odometerFinal != null) {
      return (odometerFinal! - odometerInitial!).toString();
    }

    return null;
  }

  String? get elapsedDuration {
    if (endedAt != null && startedAt != null) {
      return endedAt!.difference(startedAt!).inMinutes.toString();
    }

    return null;
  }

  // Formatted started at
  String? get fStartedAt {
    if (startedAt != null) {
      return formatDate(startedAt!);
    }

    return null;
  }

  String? get fEndedAt {
    if (endedAt != null) {
      return formatDate(endedAt!);
    }

    return null;
  }

  // Exclusivo para a tabela de informações de histórico
  Map<String, dynamic> fromModel() {
    return {
      'Rota': id.toString(),
      'Motorista': driver.name,
      'Origem': path?.origin?.toUpperCase(),
      'Destino': path?.destination?.toUpperCase(),
      'Horário de partida':
          startedAt?.toIso8601String() ?? 'Ainda não iniciada',
      'Horário de chegada': "00:00",
      'Paradas': (path?.stops?.length ?? 0).toString(),
    };
  }

  // Cria uma instância de routeModel a partir de um json
  factory RouteHistoryModel.fromJson(Map<String, dynamic> json) {
    try {
      return RouteHistoryModel(
        id: json['id'],
        odometerInitial: json['odometerInitial']?.toDouble(),
        odometerFinal: json['odometerFinal']?.toDouble(),
        imgOdometerInitial: json['imgOdometerInitial'],
        imgOdometerFinal: json['imgOdometerFinal'],
        coordinates: RoutePathCoordinates.fromJson(json['coordinates']),
        path: RoutePath.fromJson(json['path']),
        startedAt: json['startedAt'] != null
            ? DateTime.tryParse(json['startedAt'])
            : null,
        endedAt:
            json['endedAt'] != null ? DateTime.tryParse(json['endedAt']) : null,
        route: RouteModel.fromJson(json['route']),
        vehicle: VehicleModel.fromJson(json['vehicle']),
        driver: UserModel.fromJson(json['driver']),
        approval: json['approval'] != null
            ? HistoryApproval.fromJson(json['approval'])
            : null,
      );
    } catch (e) {
      throw FormatException('Erro ao parsear histórico: ${e.toString()}');
    }
  }
}
