import 'package:alfaid/models/user.dart';
import 'package:alfaid/models/vehicle.dart';

class RouteModel {
  final int id;
  final VehicleModel? vehicle;
  final UserModel? driver;
  final String origin;
  final String destiny;
  final int stopsCount;
  final int distancy;
  final int estimatedTime;

  const RouteModel({
    required this.id,
    required this.vehicle,
    required this.driver,
    required this.origin,
    required this.destiny,
    required this.stopsCount,
    required this.distancy,
    required this.estimatedTime,
  });

  Map<String, dynamic> fromModel() {
    return {
      'Rota': id.toString(),
      'Motorista': driver?.name,
      'Origem': origin,
      'Destino': destiny,
      'Horário de partida': "00:00",
      'Horário de chegada': "00:00",
      'Paradas': stopsCount.toString(),
    };
  }

  // Cria uma instância de routeModel a partir de um json
  factory RouteModel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'veiculo': Map<String, dynamic> vehicle,
        'motorista': Map<String, dynamic> driver,
        'trajeto': Map<String, dynamic> path,
        'kmTotal': int distancy,
        'tempoTotal': int estimatedTime,
      } =>
        RouteModel(
            id: id,
            vehicle: VehicleModel.fromJson(vehicle),
            driver: UserModel.driverFromJson(driver),
            origin: path['origem'],
            destiny: path['destino'],
            stopsCount: (path['paradas'] as List<dynamic>).length,
            distancy: distancy,
            estimatedTime: estimatedTime),
      _ => throw const FormatException('Erro ao buscar rota.'),
    };
  }
}
