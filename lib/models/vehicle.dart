class VehicleModel {
  final int id;
  final String plate;
  final String model;

  const VehicleModel({
    required this.id,
    required this.plate,
    required this.model,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'placa': String plate,
      } =>
        VehicleModel(
          id: id,
          plate: plate,
          model: '',
        ),
      _ => throw const FormatException('Erro ao buscar veículo'),
    };
  }
}
