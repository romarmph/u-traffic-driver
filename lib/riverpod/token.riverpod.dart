import 'package:u_traffic_driver/database/fcm_tokens_database.dart';
import 'package:u_traffic_driver/utils/exports/exports.dart';

final associateTokenFutureProvider = FutureProvider((ref) async {
  await FcmTokenDatabase.instance.associateToken();
});

final deleteTokenFutureProvider = FutureProvider((ref) async {
  await FcmTokenDatabase.instance.deleteToken();
});
