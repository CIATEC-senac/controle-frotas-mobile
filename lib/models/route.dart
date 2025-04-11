import 'package:alfaid/models/route_path.dart';
import 'package:alfaid/models/route_path_coordinates.dart';
import 'package:alfaid/models/user.dart';
import 'package:alfaid/models/vehicle.dart';

class RouteModel {
  final int id;
  final VehicleModel? vehicle;
  final UserModel? driver;
  final RoutePath path;
  final RoutePathCoordinates coordinates;
  final int estimatedDistance;
  final int estimatedDuration;

  const RouteModel({
    required this.id,
    this.vehicle,
    this.driver,
    required this.path,
    required this.coordinates,
    required this.estimatedDistance,
    required this.estimatedDuration,
  });

  // Exclusivo para a tabela de informações de rota
  Map<String, dynamic> fromModel() {
    return {
      'Rota': id.toString(),
      'Motorista': driver?.name,
      'Origem': path.origin,
      'Destino': path.destination,
      'Horário de partida': "00:00",
      'Horário de chegada': "00:00",
      'Paradas': (path.stops?.length ?? 0).toString(),
    };
  }

  // Cria uma instância de routeModel a partir de um json
  factory RouteModel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'vehicle': Map<String, dynamic> vehicle,
        'driver': Map<String, dynamic> driver,
        'path': Map<String, dynamic> path,
        'pathCoordinates': Map<String, dynamic>? coordinates,
        'estimatedDistance': int estimatedDistance,
        'estimatedDuration': int estimatedTime,
      } =>
        RouteModel(
          id: id,
          vehicle: VehicleModel.fromJson(vehicle),
          driver: UserModel.fromJson(driver),
          path: RoutePath.fromJson(path),
          coordinates: RoutePathCoordinates.fromJson(coordinates),
          estimatedDistance: estimatedDistance,
          estimatedDuration: estimatedTime,
        ),
      {
        'id': int id,
        'path': Map<String, dynamic> path,
        'pathCoordinates': Map<String, dynamic>? coordinates,
        'estimatedDistance': int estimatedDistance,
        'estimatedDuration': int estimatedTime,
      } =>
        RouteModel(
          id: id,
          path: RoutePath.fromJson(path),
          coordinates: RoutePathCoordinates.fromJson(coordinates),
          estimatedDistance: estimatedDistance,
          estimatedDuration: estimatedTime,
        ),
      _ => throw const FormatException('Erro ao buscar rota.'),
    };
  }
}
