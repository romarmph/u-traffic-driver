import 'package:u_traffic_driver/utils/exports/exports.dart';

class TicketDatabase {
  const TicketDatabase._();

  static const instance = TicketDatabase._();
  static TicketDatabase get getInstance => instance;

  static final _db = FirebaseFirestore.instance;

  Stream<List<Ticket>> getAllTickets(
    List<String> licenseNumbers,
    List<String> plateNumbers,
    List<String> chassisNumbers,
    List<String> engineNumbers,
    List<String> conductionOrFileNumbers,
  ) async* {
    final collection = _db.collection('tickets');
    List<Ticket> allTickets = [];

    if (licenseNumbers.isNotEmpty) {
      var querySnapshot = await collection
          .where('licenseNumber', whereIn: licenseNumbers)
          .get();
      var tickets = querySnapshot.docs
          .map((doc) => Ticket.fromJson(
                doc.data(),
                doc.id,
              ))
          .toList();
      allTickets.addAll(tickets);
    }

    if (plateNumbers.isNotEmpty) {
      var querySnapshot =
          await collection.where('plateNumber', whereIn: plateNumbers).get();
      var tickets = querySnapshot.docs
          .map((doc) => Ticket.fromJson(
                doc.data(),
                doc.id,
              ))
          .toList();
      allTickets.addAll(tickets);
    }

    if (chassisNumbers.isNotEmpty) {
      var querySnapshot = await collection
          .where('chassisNumber', whereIn: chassisNumbers)
          .get();
      var tickets = querySnapshot.docs
          .map((doc) => Ticket.fromJson(
                doc.data(),
                doc.id,
              ))
          .toList();
      allTickets.addAll(tickets);
    }

    if (engineNumbers.isNotEmpty) {
      var querySnapshot =
          await collection.where('engineNumber', whereIn: engineNumbers).get();
      var tickets = querySnapshot.docs
          .map((doc) => Ticket.fromJson(
                doc.data(),
                doc.id,
              ))
          .toList();
      allTickets.addAll(tickets);
    }

    if (conductionOrFileNumbers.isNotEmpty) {
      var querySnapshot = await collection
          .where('conductionOrFileNumber', whereIn: conductionOrFileNumbers)
          .get();
      var tickets = querySnapshot.docs
          .map((doc) => Ticket.fromJson(
                doc.data(),
                doc.id,
              ))
          .toList();
      allTickets.addAll(tickets);
    }

    yield allTickets;
  }

  Stream<Ticket> getTicketById(String id) {
    try {
      return _db
          .collection('tickets')
          .doc(id)
          .snapshots()
          .map((snapshot) => Ticket.fromJson(
                snapshot.data()!,
                snapshot.id,
              ));
    } catch (e) {
      rethrow;
    }
  }
}
