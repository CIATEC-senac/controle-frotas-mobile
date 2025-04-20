enum MaintenanceType { corrective, preventice, predictive, scheduled }

class MaintenanceModel {
  final int id;
  final MaintenanceType? type;
  final DateTime date;
  final String description;

  MaintenanceModel({
    required this.id,
    required this.type,
    required this.date,
    required this.description,
  });

  factory MaintenanceModel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'type': int type,
        'date': String date,
        'description': String description,
      } =>
        MaintenanceModel(
          id: id,
          type: switch (type) {
            0 => MaintenanceType.corrective,
            1 => MaintenanceType.preventice,
            2 => MaintenanceType.predictive,
            3 => MaintenanceType.scheduled,
            _ => null,
          },
          date: DateTime.parse(date),
          description: description,
        ),
      _ => throw const FormatException('Erro ao buscar manutenção'),
    };
  }
}
