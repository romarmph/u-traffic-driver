import 'package:u_traffic_driver/config/device/device_constraint.dart';
import 'package:u_traffic_driver/utils/exports/flutter_dart.dart';
import 'package:u_traffic_driver/utils/exports/models.dart';
import 'package:u_traffic_driver/utils/exports/themes.dart';
import 'package:u_traffic_driver/utils/exports/views.dart';
import 'package:u_traffic_driver/utils/exports/services.dart';
import 'package:u_traffic_driver/utils/exports/packages.dart';

class LicenseFormField extends StatelessWidget {
  const LicenseFormField({
    super.key,
    required this.controller,
    this.validator,
    this.labelText,
  });

  final TextEditingController controller;
  final String? Function(String? value)? validator;
  final String? labelText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        labelText: labelText,
      ),
    );
  }
}
