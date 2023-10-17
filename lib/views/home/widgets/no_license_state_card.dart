import 'package:u_traffic_driver/utils/exports/flutter_dart.dart';
import 'package:u_traffic_driver/utils/exports/packages.dart';
import 'package:u_traffic_driver/utils/exports/themes.dart';

class LicenseAddButton extends StatelessWidget {
  const LicenseAddButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(USpace.space12),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/new-license');
        },
        child: DashedRect(
          color: UColors.gray300,
          gap: 12,
          strokeWidth: 4,
          child: Container(
            decoration: BoxDecoration(
              color: UColors.gray100,
              borderRadius: BorderRadius.circular(USpace.space12),
            ),
            height: 200,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.add_card,
                  size: 48,
                  color: UColors.gray400,
                ),
                const SizedBox(height: USpace.space12),
                Text(
                  "Tap to add license",
                  style: const UTextStyle().textxlfontsemibold.copyWith(
                        color: UColors.gray400,
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
