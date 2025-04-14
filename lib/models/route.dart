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

  double get kmEstimatedDistance {
    return estimatedDistance / 1000;
  }

  // Exclusivo para a tabela de informações de rota
  Map<String, dynamic> fromModel() {
    return {
      'Rota': id.toString(),
      'Origem': path.origin?.toUpperCase(),
      'Destino': path.destination?.toUpperCase(),
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
        'estimatedDuration': int estimatedDuration,
      } =>
        RouteModel(
          id: id,
          vehicle: VehicleModel.fromJson(vehicle),
          driver: UserModel.fromJson(driver),
          path: RoutePath.fromJson(path),
          coordinates: RoutePathCoordinates.fromJson(coordinates),
          estimatedDistance: estimatedDistance,
          // To minutes
          estimatedDuration: (estimatedDuration / 60).floor(),
        ),
      {
        'id': int id,
        'path': Map<String, dynamic> path,
        'pathCoordinates': Map<String, dynamic>? coordinates,
        'estimatedDistance': int estimatedDistance,
        'estimatedDuration': int estimatedDuration,
      } =>
        RouteModel(
          id: id,
          path: RoutePath.fromJson(path),
          coordinates: RoutePathCoordinates.fromJson(coordinates),
          estimatedDistance: estimatedDistance,
          // To minutes
          estimatedDuration: (estimatedDuration / 60).floor(),
        ),
      _ => throw const FormatException('Erro ao buscar rota.'),
    };
  }
}
