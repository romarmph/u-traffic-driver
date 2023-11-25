import 'package:flutter/material.dart';
import 'package:u_traffic_driver/utils/exports/exports.dart';

class ProfileForm extends ConsumerStatefulWidget {
  const ProfileForm({
    super.key,
    required this.firstNameController,
    required this.middleNameController,
    required this.lastNameController,
    required this.emailController,
    required this.phoneController,
    required this.birthdateController,
  });

  final TextEditingController firstNameController;
  final TextEditingController middleNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController birthdateController;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileFormState();
}

class _ProfileFormState extends ConsumerState<ProfileForm> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
