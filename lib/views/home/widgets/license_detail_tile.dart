import 'package:u_traffic_driver/utils/exports/flutter_dart.dart';
import 'package:u_traffic_driver/utils/exports/themes.dart';

class LicenseDetailTile extends StatelessWidget {
  const LicenseDetailTile({
    super.key,
    required this.detail,
    required this.label,
    this.detailStyle,
    this.labelStyle,
  });

  final String detail;
  final String label;
  final TextStyle? detailStyle;
  final TextStyle? labelStyle;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            detail,
            style: detailStyle ??
                const UTextStyle().textxlfontsemibold.copyWith(
                      color: UColors.white,
                    ),
          ),
          Text(
            label,
            style: labelStyle ??
                const UTextStyle().textsmfontnormal.copyWith(
                      color: UColors.blue300,
                    ),
          ),
        ],
      ),
    );
  }
}

class DriverNameTile extends StatelessWidget {
  const DriverNameTile({
    super.key,
    required this.firstName,
    required this.lastName,
    this.firstNameStyle,
  });

  final String lastName;
  final String firstName;
  final TextStyle? firstNameStyle;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            lastName.toUpperCase(),
            style: firstNameStyle ??
                const UTextStyle().text2xlfontsemibold.copyWith(
                      color: UColors.white,
                    ),
          ),
          Text(
            firstName,
            style: firstNameStyle ??
                const UTextStyle().textxlfontsemibold.copyWith(
                      color: UColors.white,
                    ),
          ),
        ],
      ),
    );
  }
}
