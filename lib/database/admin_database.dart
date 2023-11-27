import 'package:u_traffic_driver/model/admin_model.dart';
import 'package:u_traffic_driver/utils/exports/exports.dart';

class AdminDatabase {
  const AdminDatabase._();

  static const AdminDatabase _instance = AdminDatabase._();
  static AdminDatabase get instance => _instance;

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final _collection = _firestore.collection('admins');

  Stream<Admin> getAdminById(String id) {
    try {
      return _collection.doc(id).snapshots().map((snapshot) {
        return Admin.fromJson(
          snapshot.data()!,
          snapshot.id,
        );
      });
    } catch (e) {
      rethrow;
    }
  }
}
