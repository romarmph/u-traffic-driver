import 'package:u_traffic_driver/config/utils/exports/flutter_dart.dart';
import 'package:u_traffic_driver/config/utils/exports/themes.dart';

final textButtonTheme = TextButtonThemeData(
  style: TextButton.styleFrom(
    foregroundColor: UColors.blue700,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(USpace.space8),
    ),
    padding: const EdgeInsets.symmetric(
      vertical: USpace.space12,
      horizontal: USpace.space24,
    ),
    textStyle: const UTextStyle().textbasefontnormal,
  ),
);
