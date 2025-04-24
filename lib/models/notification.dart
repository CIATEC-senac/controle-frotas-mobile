class NotificationModel {
  final int id;
  final String message;
  final String? link;
  final DateTime date;
  bool read;

  NotificationModel({
    required this.id,
    required this.message,
    required this.read,
    required this.date,
    this.link,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    try {
      return NotificationModel(
        id: json['id'],
        message: json['message'],
        read: json['read'],
        date: DateTime.parse(json['date']),
      );
    } catch (e) {
      throw FormatException(
          'Erro ao parsear NotificationModel: ${e.toString()}');
    }
  }
}
