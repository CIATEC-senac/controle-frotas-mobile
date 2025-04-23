import 'package:alfaid/models/maintenance.dart';

enum VehicleType { bus, car, minibus, van }

class VehicleModel {
  final int id;
  final String plate;
  final String model;
  final VehicleType? type;
  final int capacity;
  final List<MaintenanceModel>? maintenances;

  const VehicleModel({
    required this.id,
    required this.plate,
    required this.model,
    required this.type,
    required this.capacity,
    required this.maintenances,
  });

  String? get fType {
    return switch (type) {
      VehicleType.bus => 'Ônibus',
      VehicleType.car => 'Carro',
      VehicleType.minibus => 'Micro-Ônibus',
      VehicleType.van => 'Van',
      _ => null
    };
  }

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'plate': String plate,
        'type': String type,
        'model': String model,
        'capacity': int capacity,
        'maintenances': List<dynamic>? maintenances,
      } =>
        VehicleModel(
          id: id,
          plate: plate,
          model: model,
          type: switch (type) {
            'bus' => VehicleType.bus,
            'van' => VehicleType.van,
            'car' => VehicleType.car,
            'minibus' => VehicleType.minibus,
            _ => null
          },
          capacity: capacity,
          maintenances: (maintenances ?? [])
              .map((maintenance) => MaintenanceModel.fromJson(maintenance))
              .toList(),
        ),
      {
        'id': int id,
        'plate': String plate,
        'type': String type,
        'model': String model,
        'capacity': int capacity,
      } =>
        VehicleModel(
            id: id,
            plate: plate,
            model: model,
            type: switch (type) {
              'bus' => VehicleType.bus,
              'van' => VehicleType.van,
              'car' => VehicleType.car,
              'minibus' => VehicleType.minibus,
              _ => null
            },
            capacity: capacity,
            maintenances: []),
      _ => throw const FormatException('Erro ao buscar veículo'),
    };
  }
}
