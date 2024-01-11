import 'package:u_traffic_driver/utils/exports/packages.dart';

extension DateTimeExtension on DateTime {
  String get toAmericanDate => DateFormat('MMMM dd, yyyy').format(this);

  String get toAmericanDateWithTime =>
      DateFormat('MMMM dd, yyyy hh:mm a').format(this);

  String get toISO8601Date => DateFormat('yyyy/MM/dd').format(this);

  String get formatTime => DateFormat('hh:mm a').format(this);

  String get dueDate {
    return add(const Duration(days: 7)).toISO8601Date;
  }

  Timestamp get toTimestamp => Timestamp.fromDate(this);

  String get complaintAge {
    if (DateTime.now().difference(this).inMinutes < 60) {
      return '${DateTime.now().difference(this).inMinutes} min ago';
    } else if (DateTime.now().difference(this).inHours < 24) {
      return '${DateTime.now().difference(this).inHours} hr ago';
    } else if (DateTime.now().difference(this).inDays == 1) {
      return 'Yesterday';
    } else if (DateTime.now().difference(this).inDays < 7) {
      return '${DateTime.now().difference(this).inDays} days ago';
    } else if (DateTime.now().difference(this).inDays / 7 < 4) {
      return '${(DateTime.now().difference(this).inDays / 7).floor()} weeks ago';
    } else if (DateTime.now().difference(this).inDays / 30 < 12) {
      return '${(DateTime.now().difference(this).inDays / 30).floor()} months ago';
    } else {
      return '${(DateTime.now().difference(this).inDays / 365).floor()} years ago';
    }
  }
}
