import 'package:u_traffic_driver/utils/exports/exports.dart';

class LicenseDatabase {
  const LicenseDatabase._();

  static const LicenseDatabase _instance = LicenseDatabase._();
  static LicenseDatabase get instance => _instance;

  Stream<LicenseDetails> getLicenseDetailsByIdStream(String id) {
    final db = FirebaseFirestore.instance;
    try {
      return db.collection('license-details').doc(id).snapshots().map((doc) {
        return LicenseDetails.fromJson(
          doc.data()!,
          doc.id,
        );
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addLicenseDetails(LicenseDetails licenseDetails) async {
    final db = FirebaseFirestore.instance;
    await db.collection('licenses').add(licenseDetails.toJson());
  }
}
