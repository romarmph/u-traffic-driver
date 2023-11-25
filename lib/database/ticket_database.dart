import 'package:u_traffic_driver/utils/exports/exports.dart';

class TicketDatabase {
  const TicketDatabase._();

  static const instance = TicketDatabase._();
  static TicketDatabase get getInstance => instance;

  static final _db = FirebaseFirestore.instance;

  Stream<List<Ticket>> getAllTickets(
    List<String> licenseNumbers,
  ) {
    try {
      return _db
          .collection('tickets')
          .where('licenseNumber', whereIn: licenseNumbers)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) {
          return Ticket.fromJson(
            doc.data(),
            doc.id,
          );
        }).toList();
      });
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<Ticket>> getAllUnpaidTickets(
    List<String> licenseNumbers,
  ) {
    try {
      return _db
          .collection('tickets')
          .where('licenseNumber', whereIn: licenseNumbers)
          .where('status', isEqualTo: 'unpaid')
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) {
          return Ticket.fromJson(
            doc.data(),
            doc.id,
          );
        }).toList();
      });
    } catch (e) {
      rethrow;
    }
  }
}
