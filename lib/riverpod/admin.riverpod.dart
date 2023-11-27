import 'package:u_traffic_driver/database/admin_database.dart';
import 'package:u_traffic_driver/model/admin_model.dart';
import 'package:u_traffic_driver/utils/exports/exports.dart';

final adminProvider = StreamProvider.family<Admin, String>(
  (ref, id) {
    return AdminDatabase.instance.getAdminById(id);
  },
);
