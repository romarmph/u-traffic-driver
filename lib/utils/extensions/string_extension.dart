import 'package:u_traffic_driver/utils/exports/packages.dart';

extension StringExtension on String {
  String get getSex => this == 'M' ? 'Male' : 'Female';

  Timestamp? get getTimeStamp {
    try {
      return Timestamp.fromDate(DateTime.parse(split('/').join('-')));
    } catch (e) {
      return null;
    }
  }

  String get formatDate {
    try {
      return DateFormat('MMMM dd, yyyy')
          .format(DateTime.parse(split('/').join('-')));
    } catch (e) {
      rethrow;
    }
  }

  Timestamp get toTimestamp {
    try {
      final format = DateFormat('MMMM dd, yyyy');
      final date = format.parse(this);
      return Timestamp.fromDate(date);
    } catch (e) {
      rethrow;
    }
  }

  DateTime get toDateTime {
    try {
      return DateTime.parse(split(' ').reversed.join('-').split(',').join(''));
    } catch (e) {
      rethrow;
    }
  }

  bool get isAgeLegal {
    try {
      final format = DateFormat('MMMM dd, yyyy');
      final date = format.parse(this);
      final now = DateTime.now();
      final difference = now.difference(date).inDays;
      final age = difference / 365;
      return age >= 18;
    } catch (e) {
      rethrow;
    }
  }

  DateTime? get tryParseToDateTime {
    try {
      DateFormat format = DateFormat.yMMMMd('en_US');

      return format.parse(this);
    } catch (e) {
      return null;
    }
  }
}
