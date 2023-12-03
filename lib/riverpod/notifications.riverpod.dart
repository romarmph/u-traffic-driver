import 'package:u_traffic_driver/database/notifications_database.dart';
import 'package:u_traffic_driver/model/notification_model.dart';
import 'package:u_traffic_driver/utils/exports/exports.dart';

final notificationStreamProvider =
    StreamProvider.family<List<UNotification>, String>((ref, userId) {
  return NotificationsDatabase.instance.notificationsStream(userId);
});
