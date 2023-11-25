import 'package:u_traffic_driver/utils/exports/exports.dart';

class LicenseDatabase {
  const LicenseDatabase._();

  static const LicenseDatabase _instance = LicenseDatabase._();
  static LicenseDatabase get instance => _instance;

  Stream<List<LicenseDetails>> getLicenseDetailsStream() {
    final db = FirebaseFirestore.instance;
    final uid = AuthService.instance.currentuser!.uid;
    try {
      return db
          .collection('licenses')
          .where('userID', isEqualTo: uid)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) {
          return LicenseDetails.fromJson(
            doc.data(),
            doc.id,
          );
        }).toList();
      });
    } catch (e) {
      rethrow;
    }
  }

  Stream<LicenseDetails> getLicenseDetailsByIdStream(String id) {
    final db = FirebaseFirestore.instance;
    try {
      return db.collection('licenses').doc(id).snapshots().map((doc) {
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

  Future<void> updateLicenseDetails(LicenseDetails licenseDetails) async {
    final db = FirebaseFirestore.instance;
    await db
        .collection('licenses')
        .doc(licenseDetails.licenseID)
        .update(licenseDetails.toJson());
  }

  Future<void> deleteLicenseDetails(String id) async {
    final db = FirebaseFirestore.instance;
    await db.collection('licenses').doc(id).delete();
  }
}
