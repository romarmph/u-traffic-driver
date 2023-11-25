import 'package:u_traffic_driver/utils/exports/models.dart';
import 'package:u_traffic_driver/utils/exports/packages.dart';

class DriverDatabase {
  DriverDatabase._();

  static final DriverDatabase _instance = DriverDatabase._();

  static DriverDatabase get instance => _instance;

  Stream<Driver> getDriverByIdStream(String id) {
    final db = FirebaseFirestore.instance;
    return db
        .collection('drivers')
        .doc(id)
        .snapshots()
        .map((doc) => Driver.fromJson(
              doc.data()!,
              doc.id,
            ));
  }

  Future<Driver> getCurrentDriver(String uid) async {
    final db = FirebaseFirestore.instance;
    try {
      final doc = await db.collection('drivers').doc(uid).get();
      return Driver.fromJson(
        doc.data()!,
        doc.id,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addDriver(Driver driver, String uid) async {
    final db = FirebaseFirestore.instance;
    await db.collection('drivers').doc(uid).set(driver.toJson());
  }

  Future<bool> isProfileComplete(String uid) async {
    final db = FirebaseFirestore.instance;
    final doc = await db.collection('drivers').doc(uid).get();
    final driver = Driver.fromJson(
      doc.data()!,
      doc.id,
    );
    return driver.isProfileComplete;
  }

  Future<void> updateDriverPhotoUrl(String uid, String photoUrl) async {
    final db = FirebaseFirestore.instance;
    await db.collection('drivers').doc(uid).update({
      'photoUrl': photoUrl,
    });
  }
}
