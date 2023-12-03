import 'package:u_traffic_driver/database/driver_vehicle_database.dart';
import 'package:u_traffic_driver/model/vehicle_model.dart';
import 'package:u_traffic_driver/utils/exports/exports.dart';

final driverVehiclesStreamProvider = StreamProvider<List<DriverVehicle>>((ref) {
  return DriverVehicleDatabase.instance.driverVehiclesStream();
});

final vehicleByIdStream =
    StreamProvider.family<DriverVehicle, String>((ref, id) {
  return DriverVehicleDatabase.instance.driverVehicleIdStream(id);
});

final vehiclesProvier = Provider<List<DriverVehicle>>((ref) {
  return ref.watch(driverVehiclesStreamProvider).when(
        data: (data) => data,
        error: (error, stackTrace) => [],
        loading: () => [],
      );
});
