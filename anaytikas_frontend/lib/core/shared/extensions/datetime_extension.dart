import 'package:intl/intl.dart';

extension DatetimeExtension on DateTime {
  // Senin, 1 Januari 2000
  String toFullDate() {
    return DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(this);
  }

  // 2000-01-01
  String toDBDate() {
    return DateFormat('yyyy-MM-dd').format(this);
  }

  // 2000-01-01 01:11:00
  String toDBDatetime() {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(this);
  }

  // 01:11
  String toTime() {
    return DateFormat('HH:mm').format(this);
  }
}
