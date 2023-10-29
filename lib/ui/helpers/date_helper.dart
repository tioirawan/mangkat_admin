import 'package:intl/intl.dart';

abstract class DateHelper {
  static final dateFormat = DateFormat('EEE, dd MMM yyyy HH:mm:ss');
  static final timeFormat = DateFormat('HH:mm');

  static String format(DateTime dateTime) {
    return dateFormat.format(dateTime);
  }

  static String formatTime(DateTime? dateTime) {
    if (dateTime == null) {
      return '-';
    }

    return timeFormat.format(dateTime);
  }
}
