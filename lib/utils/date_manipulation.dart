String formatDate(DateTime date) {
  String pad(int value) => value.toString().padLeft(2, '0');

  return '${pad(date.day)}/${pad(date.month)}/${date.year} ${pad(date.hour)}:${pad(date.minute)}';
}
