import 'package:u_traffic_driver/utils/exports/flutter_dart.dart';
import 'package:u_traffic_driver/utils/exports/themes.dart';

class AppDrawerHeader extends StatelessWidget {
  const AppDrawerHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                    'John Doe',
                    style: const UTextStyle().textlgfontbold.copyWith(
                          color: UColors.white,
                        ),
                  ),
                  subtitle: Text(
                    'driver2@gmail.com',
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
