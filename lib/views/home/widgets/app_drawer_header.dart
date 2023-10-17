import 'package:u_traffic_driver/utils/exports/exports.dart';
import 'package:u_traffic_driver/utils/exports/flutter_dart.dart';

class AppDrawerHeader extends StatelessWidget {
  const AppDrawerHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final driverProvider = Provider.of<DriverProvider>(context);

    final currentDriver = driverProvider.currentDriver;

    return Container(
      height: 120,
      decoration: const BoxDecoration(
        color: UColors.blue700,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(height: USpace.space20),
          Row(
            children: [
              const SizedBox(width: USpace.space20),
              const Icon(
                Icons.person,
                color: UColors.white,
                size: USpace.space48,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ListTile(
                  title: Text(
                    "${currentDriver.firstName} ${currentDriver.lastName}",
                    style: const UTextStyle().textlgfontbold.copyWith(
                          color: UColors.white,
                        ),
                  ),
                  subtitle: Text(
                    currentDriver.email,
                    style: const UTextStyle().textsmfontnormal.copyWith(
                          color: UColors.white,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
