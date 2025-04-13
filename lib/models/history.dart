import 'package:alfaid/models/route.dart';
import 'package:alfaid/models/route_path.dart';
import 'package:alfaid/models/route_path_coordinates.dart';
import 'package:alfaid/models/user.dart';
import 'package:alfaid/models/vehicle.dart';

enum HistoryStatus { pending, approved, disapproved }

class RouteHistoryModel {
  final int id;
  final double? odometerInitial;
  final double? odometerFinal;
  final String? observation;
  final HistoryStatus status;
  final int? elapsedDistance;
  final String? imgOdometerInitial;
  final String? imgOdometerFinal;
  final RoutePathCoordinates? coordinates;
  final RoutePath? path;
  final DateTime? startedAt;
  final DateTime? endedAt;
  final RouteModel route;
  final UserModel driver;
  final VehicleModel vehicle;

  const RouteHistoryModel({
    required this.id,
    this.odometerInitial,
    this.odometerFinal,
    this.observation,
    required this.status,
    this.elapsedDistance,
    this.imgOdometerInitial,
    this.imgOdometerFinal,
    this.coordinates,
    this.path,
    this.startedAt,
    this.endedAt,
    required this.route,
    required this.driver,
    required this.vehicle,
  });

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
        'observation': String observation,
        'status': int status,
        'elapsedDistance': String elapsedDistance,
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
          observation: observation,
          status: switch (status) {
            1 => HistoryStatus.approved,
            2 => HistoryStatus.disapproved,
            _ => HistoryStatus.pending,
          },
          elapsedDistance: int.tryParse(elapsedDistance),
          imgOdometerInitial: imgOdometerInitial,
          imgOdometerFinal: imgOdometerFinal,
          coordinates: RoutePathCoordinates.fromJson(coordinates),
          path: RoutePath.fromJson(path),
          startedAt: startedAt != null ? DateTime.tryParse(startedAt) : null,
          endedAt: endedAt != null ? DateTime.tryParse(endedAt) : null,
          route: RouteModel.fromJson(route),
          vehicle: VehicleModel.fromJson(vehicle),
          driver: UserModel.fromJson(driver),
        ),
      _ => throw const FormatException('Erro ao buscar histórico.'),
    };
  }
}
