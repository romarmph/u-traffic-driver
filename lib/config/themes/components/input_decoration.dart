import 'package:u_traffic_driver/utils/exports/flutter_dart.dart';
import 'package:u_traffic_driver/utils/exports/themes.dart';

final inputDecorationTheme = InputDecorationTheme(
  contentPadding: const EdgeInsets.symmetric(
    vertical: USpace.space12,
    horizontal: USpace.space16,
  ),
  filled: true,
  fillColor: UColors.gray100,
  prefixIconColor: UColors.gray400,
  hintStyle: const UTextStyle().textbasefontnormal.copyWith(
        color: UColors.gray400,
      ),
  labelStyle: const UTextStyle().textbasefontnormal.copyWith(
        color: UColors.gray400,
      ),
  floatingLabelStyle: const UTextStyle().textbasefontnormal.copyWith(
        color: UColors.blue400,
      ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(USpace.space8),
    borderSide: const BorderSide(
      color: UColors.white,
      width: 1,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(USpace.space8),
    borderSide: const BorderSide(
      color: UColors.blue400,
      width: 2,
    ),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(USpace.space8),
    borderSide: const BorderSide(
      color: UColors.red400,
      width: 2,
    ),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(USpace.space8),
    borderSide: const BorderSide(
      color: UColors.blue400,
      width: 2,
    ),
  ),
  disabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(USpace.space8),
    borderSide: const BorderSide(
      width: 0,
      color: UColors.gray100,
    ),
  ),
);
