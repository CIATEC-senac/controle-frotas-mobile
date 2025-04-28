class HistoryTrackModel {
  final double latitude;
  final double longitude;

  const HistoryTrackModel({
    required this.latitude,
    required this.longitude,
  });

  factory HistoryTrackModel.fromJson(Map<String, dynamic> json) {
    try {
      return HistoryTrackModel(
          latitude: json['coordinate']['lat'],
          longitude: json['coordinate']['lng']);
    } catch (e) {
      throw FormatException('Erro ao parsear HistoryTrack: ${e.toString()}');
    }
  }
}
