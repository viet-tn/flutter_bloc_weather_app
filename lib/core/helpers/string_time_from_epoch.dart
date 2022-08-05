String hourFromEpoch(int seconds) {
  final dateTime = DateTime.fromMillisecondsSinceEpoch(seconds * 1000);
  return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
}
