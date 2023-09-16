import 'package:intl/intl.dart';

abstract class DateHelper {
  static final dateFormat = DateFormat('EEE, dd MMM yyyy HH:mm:ss');

  static String format(DateTime dateTime) {
    return dateFormat.format(dateTime);
  }
}
