import 'package:intl/intl.dart';

abstract class DateHelper {
  static final dateTimeFormat = DateFormat('EEE, dd MMM yyyy HH:mm:ss');
  static final dateFormat = DateFormat('EEE, dd MMM yyyy');
  static final timeFormat = DateFormat('HH:mm');

  static String format(DateTime? dateTime) {
    if (dateTime == null) {
      return '-';
    }

    return dateTimeFormat.format(dateTime);
  }

  static String formatDate(DateTime? dateTime) {
    if (dateTime == null) {
      return '-';
    }

    return dateFormat.format(dateTime);
  }

  static String formatTime(DateTime? dateTime) {
    if (dateTime == null) {
      return '-';
    }

    return timeFormat.format(dateTime);
  }
}
