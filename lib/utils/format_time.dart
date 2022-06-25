import 'package:intl/intl.dart';

String formatTime(String time) {
  String result = time.replaceAll(';', ' - ');
  return result;
}

String formatDateType(String date) {
  DateTime format = DateTime.parse(date.replaceAll('T', ' '));

  return DateFormat('dd/MM/yyyy').format(format);
}

String formatTimeType(String date) {
  DateTime format = DateTime.parse(date.replaceAll('T', ' '));

  return DateFormat.jm().format(format);
}
