import 'package:intl/intl.dart';

DateTime requestNewDateFromNow({
  int year = 0,
  int month = 0,
  int day = 0,
  required bool toAdd,
}) {
  var dateNow = DateTime.now();
  return toAdd
      ? DateTime(dateNow.year + year, dateNow.month + month, dateNow.day + day)
      : DateTime(dateNow.year - year, dateNow.month - month, dateNow.day - day);
}

String defaultDateFormat(DateTime date) => DateFormat('MMMM d, y').format(date);
