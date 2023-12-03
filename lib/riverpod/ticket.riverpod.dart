import 'package:u_traffic_driver/database/ticket_database.dart';
import 'package:u_traffic_driver/riverpod/driver_vehicle.riverpod.dart';
import 'package:u_traffic_driver/riverpod/license.riverpod.dart';
import 'package:u_traffic_driver/utils/exports/exports.dart';

final getAllTickets = StreamProvider<List<Ticket>>((ref) {
  final licenseNumbers = ref.watch(allLicenseProvider)!.map((license) {
    return license.licenseNumber;
  }).toList();

  final vehicles = ref.watch(vehiclesProvier);

  List<String> plateNumbers = [];
  List<String> chassisNumbers = [];
  List<String> engineNumbers = [];
  List<String> conductionOrFileNumbers = [];

  for (var vehicle in vehicles) {
    if (vehicle.plateNumber != null && vehicle.plateNumber!.isNotEmpty) {
      plateNumbers.add(vehicle.plateNumber!);
    }

    if (vehicle.chassisNumber != null && vehicle.chassisNumber!.isNotEmpty) {
      chassisNumbers.add(vehicle.chassisNumber!);
    }

    if (vehicle.engineNumber != null && vehicle.engineNumber!.isNotEmpty) {
      engineNumbers.add(vehicle.engineNumber!);
    }

    if (vehicle.conductionOrFileNumber != null &&
        vehicle.conductionOrFileNumber!.isNotEmpty) {
      conductionOrFileNumbers.add(vehicle.conductionOrFileNumber!);
    }
  }

  return TicketDatabase.getInstance.getAllTickets(
    licenseNumbers,
    plateNumbers,
    chassisNumbers,
    engineNumbers,
    conductionOrFileNumbers,
  );
});

final getTicketByIdProvider =
    StreamProvider.autoDispose.family<Ticket, String>((ref, id) {
  return TicketDatabase.getInstance.getTicketById(id);
});
