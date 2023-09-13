import 'package:u_traffic_driver/model/ticket_model.dart';
import 'package:u_traffic_driver/utils/exports/flutter_dart.dart';
import 'package:u_traffic_driver/utils/exports/models.dart';
import 'package:u_traffic_driver/utils/exports/views.dart';
import 'package:u_traffic_driver/views/home/ticket_view.dart';

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

void goTicketView(BuildContext context, Ticket ticket) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => TicketView(
        ticket: ticket,
      ),
    ),
  );
}
