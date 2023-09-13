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
      return '';
    }
  }
}
