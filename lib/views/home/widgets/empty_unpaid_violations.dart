import 'package:u_traffic_driver/utils/exports/flutter_dart.dart';

import 'package:u_traffic_driver/utils/exports/themes.dart';

class EmptyUnpaidViolationsState extends StatelessWidget {
  const EmptyUnpaidViolationsState({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(
        USpace.space12,
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: UColors.green100,
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: Center(
          child: Text(
            'You have no unpaid violations',
            style: const UTextStyle().textbasefontmedium.copyWith(
                  color: UColors.gray400,
                ),
          ),
        ),
      ),
    );
  }
}
