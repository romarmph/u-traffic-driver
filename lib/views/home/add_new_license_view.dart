import 'package:u_traffic_driver/config/device/device_constraint.dart';
import 'package:u_traffic_driver/utils/exports/flutter_dart.dart';
import 'package:u_traffic_driver/utils/exports/models.dart';
import 'package:u_traffic_driver/utils/exports/themes.dart';
import 'package:u_traffic_driver/utils/exports/views.dart';
import 'package:u_traffic_driver/utils/exports/services.dart';
import 'package:u_traffic_driver/utils/exports/packages.dart';

class AddNewLicenseView extends StatefulWidget {
  const AddNewLicenseView({super.key});

  @override
  State<AddNewLicenseView> createState() => _AddNewLicenseViewState();
}

class _AddNewLicenseViewState extends State<AddNewLicenseView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New License'),
      ),
    );
  }
}
