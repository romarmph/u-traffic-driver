import 'package:u_traffic_driver/database/ticket_database.dart';
import 'package:u_traffic_driver/riverpod/license.riverpod.dart';
import 'package:u_traffic_driver/utils/exports/exports.dart';

final getAllUnpaidTickets = StreamProvider<List<Ticket>>((ref) {
  final licenseNumbers = ref.watch(allLicenseProvider)!.map((license) {
    return license.licenseNumber;
  }).toList();

  return TicketDatabase.getInstance.getAllUnpaidTickets(licenseNumbers);
});

final getAllTickets = StreamProvider<List<Ticket>>((ref) {
  final licenseNumbers = ref.watch(allLicenseProvider)!.map((license) {
    return license.licenseNumber;
  }).toList();

  return TicketDatabase.getInstance.getAllTickets(licenseNumbers);
});

final getTicketByIdProvider =
    StreamProvider.autoDispose.family<Ticket, String>((ref, id) {
  return TicketDatabase.getInstance.getTicketById(id);
});
