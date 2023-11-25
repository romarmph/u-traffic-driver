import 'package:u_traffic_driver/database/license_database.dart';
import 'package:u_traffic_driver/utils/exports/exports.dart';

final getAllDriversLicense = StreamProvider<List<LicenseDetails>>((ref) {
  final db = LicenseDatabase.instance;
  return db.getLicenseDetailsStream();
});

final allLicenseProvider = Provider<List<LicenseDetails>?>((ref) {
  return ref.watch(getAllDriversLicense).when(
        data: (data) => data,
        error: (error, stackTrace) => null,
        loading: () => null,
      );
});
