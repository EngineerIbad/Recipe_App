import 'package:intl/intl.dart';

extension DateTimeFormatter on DateTime {
  String toHHMMA() {
    return DateFormat("hh:mm a").format(this);
  }

  String toHHMM24() {
    return DateFormat("hh:mm").format(this);
  }

  String toDDMMYYYY() {
    return DateFormat("dd/MM/yyyy").format(this);
  }

  DateTime tomorrowDate() {
    return add(const Duration(days: 1));
  }

}

