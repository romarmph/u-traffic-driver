import 'package:flutter/services.dart';
import 'package:u_traffic_driver/utils/exports/flutter_dart.dart';

class LicenseFormField extends StatelessWidget {
  const LicenseFormField({
    super.key,
    required this.controller,
    this.validator,
    this.labelText,
    this.onTap,
    this.readOnly = false,
    this.inputFormatters = const [],
    this.onChanged,
  });

  final TextEditingController controller;
  final String? Function(String? value)? validator;
  final String? labelText;
  final VoidCallback? onTap;
  final bool readOnly;
  final List<TextInputFormatter> inputFormatters;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: inputFormatters,
      readOnly: readOnly,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      validator: validator,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: labelText,
      ),
      onChanged: onChanged,
    );
  }
}
