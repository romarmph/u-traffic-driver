import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:u_traffic_driver/model/fcm_token.dart';
import 'package:u_traffic_driver/services/auth_service.dart';
import 'package:u_traffic_driver/services/notification_service.dart';

class FcmTokenDatabase {
  const FcmTokenDatabase._();

  static const FcmTokenDatabase _instance = FcmTokenDatabase._();
  static FcmTokenDatabase get instance => _instance;

  static final _api = FirebaseFirestore.instance;

  Future<void> associateToken() async {
    final token = await NotificationService.instance.getToken();

    if (token == null) {
      return;
    }

    final foundToken = await _api
        .collection('fcm_tokens')
        .where('token', isEqualTo: token)
        .get();

    if (foundToken.docs.isNotEmpty) {
      final currentUser = AuthService.instance.currentuser;
      final token = FcmToken.fromJson(
        foundToken.docs.first.data(),
        foundToken.docs.first.id,
      );

      await updateToken(
        FcmToken(
          id: token.id,
          token: token.token,
          userId: currentUser?.uid,
        ),
      );
    } else {
      final currentUser = AuthService.instance.currentuser;
      await _api.collection('fcm_tokens').add(
            FcmToken(
              token: token,
              userId: currentUser?.uid,
            ).toJson(),
          );
      print('token added');
    }
  }

  Future<void> deleteToken() async {
    final token = await NotificationService.instance.getToken();

    if (token == null) {
      return;
    }

    final foundToken = await _api
        .collection('fcm_tokens')
        .where('token', isEqualTo: token)
        .get();

    if (foundToken.docs.isNotEmpty) {
      await _api
          .collection('fcm_tokens')
          .doc(foundToken.docs.first.id)
          .delete();
    }
  }

  Future<void> updateToken(FcmToken token) async {
    await _api.collection('fcm_tokens').doc(token.id).update(token.toJson());
  }
}
