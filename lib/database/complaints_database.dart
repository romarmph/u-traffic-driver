import 'package:u_traffic_driver/model/attachment_model.dart';
import 'package:u_traffic_driver/model/complaint.dart';
import 'package:u_traffic_driver/utils/exports/exports.dart';

class ComplaintsDatabase {
  const ComplaintsDatabase._();

  static const ComplaintsDatabase _instance = ComplaintsDatabase._();
  static ComplaintsDatabase get instance => _instance;

  static final _firestore = FirebaseFirestore.instance;
  static final _collection = _firestore.collection('complaints');

  Stream<List<Complaint>> getComplaints() {
    final currentUser = FirebaseAuth.instance.currentUser!.uid;
    return _collection
        .where('sender', isEqualTo: currentUser)
        .where('isSoftDeleted', isEqualTo: false)
        .where('parentThread', isEqualTo: null)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Complaint.fromJson(
          doc.data(),
          doc.id,
        );
      }).toList();
    });
  }

  Stream<Complaint> getComplaintById(String id) {
    return _collection.doc(id).snapshots().map((snapshot) {
      return Complaint.fromJson(
        snapshot.data()!,
        snapshot.id,
      );
    });
  }

  Stream<List<Complaint>> getAllReplies(String parentThreadId) {
    return _collection
        .where('parentThread', isEqualTo: parentThreadId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Complaint.fromJson(
          doc.data(),
          doc.id,
        );
      }).toList();
    });
  }

  Future<String> addComplaint(Complaint complaint) async {
    final ref = await _collection.add(complaint.toJson());
    return ref.id;
  }

  Future<void> updateComplaint(Complaint complaint) async {
    await _collection.doc(complaint.id).update(complaint.toJson());
  }

  Future<void> insertAttachments(
    List<Attachment> attachments,
    String docId,
  ) async {
    await _collection.doc(docId).update({
      'attachments': FieldValue.arrayUnion(
        attachments.map((e) => e.toJson()).toList(),
      ),
    });
  }

  Future<void> softDelete(Complaint complaint) async {
    await _collection.doc(complaint.id).update({
      'isSoftDeleted': true,
    });
  }
}
