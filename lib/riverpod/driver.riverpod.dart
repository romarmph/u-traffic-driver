import 'package:u_traffic_driver/utils/exports/exports.dart';

final driverDatabaseProvider = Provider<DriverDatabase>((ref) {
  return DriverDatabase.instance;
});

final driverStreamProvider = StreamProvider<Driver>((ref) {
  final currentUser = ref.watch(currentUserProvider);
  final db = ref.watch(driverDatabaseProvider);
  return db.getDriverByIdStream(currentUser!.uid);
});

final driverAccountProvider = Provider<Driver?>((ref) {
  final provider = ref.watch(driverStreamProvider);

  return provider.when(
    data: (driver) => driver,
    error: (error, stackTrace) => null,
    loading: () => null,
  );
});
