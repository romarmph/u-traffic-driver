import 'package:u_traffic_driver/model/evidence.dart';
import 'package:u_traffic_driver/utils/exports/exports.dart';

class EvidenceDatabase {
  const EvidenceDatabase._();

  static const EvidenceDatabase _instance = EvidenceDatabase._();
  static EvidenceDatabase get instance => _instance;

  static final _db = FirebaseFirestore.instance;
  static final _evidenceRef = _db.collection('evidences');

  Stream<List<Evidence>> getEvidencesStream(int ticketNumber) {
    return _evidenceRef
        .where('ticketNumber', isEqualTo: ticketNumber)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Evidence.fromMap(
          doc.data(),
          doc.id,
        );
      }).toList();
    });
  }
}
