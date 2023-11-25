import 'package:u_traffic_driver/database/license_database.dart';
import 'package:u_traffic_driver/utils/exports/exports.dart';

final getAllDriversLicense =
    StreamProvider.autoDispose<List<LicenseDetails>>((ref) {
  final db = LicenseDatabase.instance;
  return db.getLicenseDetailsStream();
});
