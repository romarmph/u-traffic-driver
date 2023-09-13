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
                  lastName: licenseDetails.lastName,
                  firstName:
                      '${licenseDetails.firstName} ${licenseDetails.middleName} ',
                ),
                LicenseDetailTile(
                  detail: licenseDetails.licenseNumber,
                  label: 'License Number',
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      flex: 3,
                      child: LicenseDetailTile(
                        detail:
                            licenseDetails.dateIssued.toDate().toISO8601Date,
                        label: 'Issued Date',
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: LicenseDetailTile(
                        detail:
                            licenseDetails.dateIssued.toDate().toISO8601Date,
                        label: 'Expiration Date',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}