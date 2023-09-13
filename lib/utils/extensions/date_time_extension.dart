import 'package:u_traffic_driver/utils/exports/packages.dart';

extension DateTimeExtension on DateTime {
  String get toAmericanDate => DateFormat('MMMM dd, yyyy').format(this);

  String get toISO8601Date => DateFormat('yyyy/MM/dd').format(this);

  String get formatTime => DateFormat('hh:mm a').format(this);

  String get dueDate {
    return add(const Duration(days: 7)).toISO8601Date;
  }
}
