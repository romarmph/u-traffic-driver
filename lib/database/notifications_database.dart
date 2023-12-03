import 'package:u_traffic_driver/model/notification_model.dart';
import 'package:u_traffic_driver/utils/exports/exports.dart';

class NotificationsDatabase {
  const NotificationsDatabase._();

  static const NotificationsDatabase _instace = NotificationsDatabase._();
  static NotificationsDatabase get instance => _instace;

  static final _firestore = FirebaseFirestore.instance;
  static final _collection = _firestore.collection('notifications');

  Stream<List<UNotification>> notificationsStream(String userId) {
    return _collection
        .where('receiverId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return UNotification.fromJson(doc.data(), doc.id);
      }).toList();
    });
  }

  Future<void> markAsRead(String notificationId) async {
    await _collection.doc(notificationId).update({'read': true});
  }
}
