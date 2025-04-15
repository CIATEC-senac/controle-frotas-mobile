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
    return switch (json) {
      {
        'observation': String observation,
        'status': num status,
        'approvedBy': Map<String, dynamic> approvedBy,
        'date': String date,
      } =>
        HistoryApproval(
          observation: observation,
          status: switch (status) {
            0 => HistoryStatus.approved,
            1 => HistoryStatus.disapproved,
            _ => HistoryStatus.pending,
          },
          approvedBy: UserModel.fromJson(approvedBy),
          date: DateTime.parse(date),
        ),
      _ => throw const FormatException('Erro ao buscar aprovação'),
    };
  }
}
