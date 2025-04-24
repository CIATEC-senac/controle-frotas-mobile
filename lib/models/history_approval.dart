import 'package:alfaid/models/user.dart';
import 'package:alfaid/utils/date_manipulation.dart';

enum HistoryStatus { pending, approved, disapproved }

class HistoryApproval {
  final String? observation;
  final HistoryStatus status;
  final UserModel approvedBy;
  final DateTime date;

  const HistoryApproval({
    required this.observation,
    required this.status,
    required this.approvedBy,
    required this.date,
  });

  String get fDate {
    return formatDate(date);
  }

  factory HistoryApproval.fromJson(Map<String, dynamic> json) {
    try {
      return HistoryApproval(
        observation: json['observation'],
        status: switch (json['status']) {
          0 => HistoryStatus.approved,
          1 => HistoryStatus.disapproved,
          _ => HistoryStatus.pending,
        },
        approvedBy: UserModel.fromJson(json['approvedBy']),
        date: DateTime.parse(json['date']),
      );
    } catch (e) {
      throw FormatException('Erro ao parsear aprovação: ${e.toString()}');
    }
  }
}
