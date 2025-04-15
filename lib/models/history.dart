import 'package:alfaid/models/history_approval.dart';
import 'package:alfaid/models/route.dart';
import 'package:alfaid/models/route_path.dart';
import 'package:alfaid/models/route_path_coordinates.dart';
import 'package:alfaid/models/user.dart';
import 'package:alfaid/models/vehicle.dart';
import 'package:alfaid/utils/date_manipulation.dart';

class RouteHistoryModel {
  final int id;
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
    required this.id,
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
    return switch (json) {
      {
        'id': int id,
        'odometerInitial': num odometerInitial,
        'odometerFinal': num odometerFinal,
        'approval': Map<String, dynamic>? approval,
        'imgOdometerInitial': String? imgOdometerInitial,
        'imgOdometerFinal': String? imgOdometerFinal,
        'pathCoordinates': Map<String, dynamic>? coordinates,
        'path': Map<String, dynamic>? path,
        'startedAt': String? startedAt,
        'endedAt': String? endedAt,
        'route': Map<String, dynamic> route,
        'vehicle': Map<String, dynamic> vehicle,
        'driver': Map<String, dynamic> driver,
      } =>
        RouteHistoryModel(
          id: id,
          odometerInitial: odometerInitial.toDouble(),
          odometerFinal: odometerFinal.toDouble(),
          imgOdometerInitial: imgOdometerInitial,
          imgOdometerFinal: imgOdometerFinal,
          coordinates: RoutePathCoordinates.fromJson(coordinates),
          path: RoutePath.fromJson(path),
          startedAt: startedAt != null ? DateTime.tryParse(startedAt) : null,
          endedAt: endedAt != null ? DateTime.tryParse(endedAt) : null,
          route: RouteModel.fromJson(route),
          vehicle: VehicleModel.fromJson(vehicle),
          driver: UserModel.fromJson(driver),
          approval:
              approval != null ? HistoryApproval.fromJson(approval) : null,
        ),
      _ => throw const FormatException('Erro ao buscar histórico.'),
    };
  }
}
