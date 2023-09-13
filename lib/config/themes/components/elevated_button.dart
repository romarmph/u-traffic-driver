import 'package:u_traffic_driver/utils/exports/flutter_dart.dart';
import 'package:u_traffic_driver/utils/exports/themes.dart';

final elevatedButtonTheme = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    backgroundColor: UColors.blue600,
    foregroundColor: UColors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(USpace.space8),
    ),
    padding: const EdgeInsets.symmetric(
      vertical: USpace.space12,
      horizontal: USpace.space24,
    ),
    textStyle: const UTextStyle().textbasefontmedium,
  ),
);
