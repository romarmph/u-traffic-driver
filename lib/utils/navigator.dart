import 'package:u_traffic_driver/utils/exports/flutter_dart.dart';
import 'package:u_traffic_driver/utils/exports/models.dart';
import 'package:u_traffic_driver/utils/exports/views.dart';
import 'package:u_traffic_driver/views/home/ticket_view.dart';

import '../config/navigator_key.dart';

void goToLicenseDetailView(
  LicenseDetails licenseDetails,
  BuildContext context,
) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => LicenseDetailsView(
        licenseDetails: licenseDetails,
      ),
    ),
  );
}

void goAddNewLicenseView(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => const AddNewLicenseView(),
    ),
  );
}

void goTicketView(Ticket ticket) {
  Navigator.of(navigatorKey.currentContext!).push(
    MaterialPageRoute(
      builder: (context) => TicketView(
        ticket: ticket,
      ),
    ),
  );
}

void goHome() {
  Navigator.of(navigatorKey.currentState!.context).pushNamedAndRemoveUntil(
    "/",
    (route) => false,
  );
}
