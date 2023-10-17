import 'package:u_traffic_driver/utils/exports/models.dart';
import 'package:u_traffic_driver/utils/exports/packages.dart';

class DriverDatabase {
  DriverDatabase._();

  static final DriverDatabase _instance = DriverDatabase._();

  static DriverDatabase get instance => _instance;

  Future<void> addDriver(Driver driver, String uid) async {
    final db = FirebaseFirestore.instance;
    await db.collection('drivers').doc(uid).set(driver.toJson());
  }

  Future<bool> isProfileComplete(String uid) async {
    final db = FirebaseFirestore.instance;
    final doc = await db.collection('drivers').doc(uid).get();
    final driver = Driver.fromJson(doc.data()!);
    return driver.isProfileComplete;
  }
}
