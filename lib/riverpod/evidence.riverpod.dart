import 'package:u_traffic_driver/database/evidence_database.dart';
import 'package:u_traffic_driver/model/evidence.dart';
import 'package:u_traffic_driver/utils/exports/exports.dart';

final evidenceDbProvider = Provider<EvidenceDatabase>((ref) {
  return EvidenceDatabase.instance;
});

final getAllEvidencesProvider = StreamProvider.family<List<Evidence>, int>((
  ref,
  ticketNumber,
) {
  final db = ref.watch(evidenceDbProvider);
  return db.getEvidencesStream(ticketNumber);
});
