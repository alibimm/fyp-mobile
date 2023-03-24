import 'package:intl/intl.dart';

class Tools {
  static String formatDate(DateTime date) {
    return DateFormat.yMMMd().format(date);
  }
}