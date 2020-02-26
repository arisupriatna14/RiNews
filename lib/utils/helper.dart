import 'package:intl/intl.dart';

class Helper {
  static formatDateTime(DateTime date) {
    return DateFormat.yMMMMEEEEd().format(date);
  }
}
