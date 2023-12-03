import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:u_traffic_driver/config/navigator_key.dart';
import 'package:u_traffic_driver/utils/exports/flutter_dart.dart';

class NotificationService {
  const NotificationService._();

  static const NotificationService _instance = NotificationService._();
  static NotificationService get instance => _instance;

  static final _api = FirebaseMessaging.instance;

  Future<String?> getToken() async {
    return await _api.getToken();
  }

  Future<void> initNotications() async {
    await _api.requestPermission();

    final token = await _api.getToken();

    if (token == null) {
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
        const SnackBar(
          content: Text(
              "Notifications are not enabled. To enable, go to settings and enable notifications."),
        ),
      );
      return;
    }
  }
}
