import 'package:u_traffic_driver/utils/exports/flutter_dart.dart';
import 'package:u_traffic_driver/utils/exports/models.dart';
import 'package:u_traffic_driver/utils/exports/themes.dart';
import 'package:u_traffic_driver/utils/exports/views.dart';
import 'package:u_traffic_driver/utils/exports/extensions.dart';
import 'package:u_traffic_driver/utils/navigator.dart';

class LicenseCard extends StatelessWidget {
  const LicenseCard({
    super.key,
    required this.licenseDetails,
  });

  final LicenseDetails licenseDetails;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: USpace.space8,
      ),
      child: GestureDetector(
        onTap: () {
          goToLicenseDetailView(licenseDetails, context);
        },
        child: Container(
          decoration: BoxDecoration(
            color: UColors.blue700,
            borderRadius: BorderRadius.circular(USpace.space12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(USpace.space12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Tap to view details',
                  textAlign: TextAlign.end,
                  style: const UTextStyle().textsmfontlight.copyWith(
                        color: UColors.blue400,
                      ),
                ),
                DriverNameTile(
                  lastName: licenseDetails.driverName.split(',')[0],
                  firstName: '${licenseDetails.driverName.split(',')[1]} ',
                ),
                DetailTile(
                  detail: licenseDetails.licenseNumber,
                  label: 'License Number',
                ),
                Expanded(
                  flex: 3,
                  child: DetailTile(
                    detail:
                        licenseDetails.expirationDate!.toDate().toISO8601Date,
                    label: 'Expiration Date',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
