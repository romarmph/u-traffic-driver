import 'package:u_traffic_driver/model/vehicle_model.dart';
import 'package:u_traffic_driver/utils/exports/exports.dart';

class DriverVehicleDatabase {
  const DriverVehicleDatabase._();

  static const DriverVehicleDatabase _instance = DriverVehicleDatabase._();
  static DriverVehicleDatabase get instance => _instance;

  static final _api = FirebaseFirestore.instance;
  static final _auth = FirebaseAuth.instance;
  static final _collection = _api.collection('driver_vehicles');

  Future<void> addDriverVehicle(DriverVehicle driverVehicle) async {
    final currentUser = _auth.currentUser;

    if (currentUser == null) {
      return;
    }

    await _collection.add(
      driverVehicle
          .copyWith(
            driverId: currentUser.uid,
          )
          .toJson(),
    );
  }

  Future<void> updateDriverVehicle(DriverVehicle driverVehicle) async {
    await _collection.doc(driverVehicle.id).update(
          driverVehicle.toJson(),
        );
  }

  Future<void> deleteDriverVehicle(String id) async {
    await _collection.doc(id).delete();
  }

  Stream<List<DriverVehicle>> driverVehiclesStream() {
    final currentUser = _auth.currentUser;

    return _collection
        .where('driverId', isEqualTo: currentUser!.uid)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => DriverVehicle.fromJson(
                  doc.data(),
                  doc.id,
                ),
              )
              .toList(),
        );
  }

  Stream<DriverVehicle> driverVehicleIdStream(String id) {
    return _collection.doc(id).snapshots().map(
          (snapshot) => DriverVehicle.fromJson(
            snapshot.data()!,
            snapshot.id,
          ),
        );
  }
}
