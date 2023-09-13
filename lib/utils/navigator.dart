import 'package:u_traffic_driver/utils/exports/flutter_dart.dart';
import 'package:u_traffic_driver/utils/exports/models.dart';
import 'package:u_traffic_driver/utils/exports/views.dart';

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
      builder: (context) => AddNewLicenseView(),
    ),
  );
}