import 'package:u_traffic_driver/provider/driver_provider.dart';
import 'package:u_traffic_driver/provider/license_provider.dart';
import 'package:u_traffic_driver/provider/violations_provider.dart';
import 'package:u_traffic_driver/utils/exports/flutter_dart.dart';
import 'package:u_traffic_driver/utils/exports/packages.dart';
import 'package:u_traffic_driver/utils/exports/services.dart';
import 'package:u_traffic_driver/utils/exports/models.dart';
import 'package:u_traffic_driver/utils/exports/views.dart';

class WidgetWrapper extends StatelessWidget {
  const WidgetWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return StreamBuilder<User?>(
      stream: authService.user,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (snapshot.data == null) {
          return const LoginPage();
        }

        return FutureBuilder(
          future: load(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            return const ViewWrapper();
          },
        );
      },
    );
  }

  // Future<void> load(BuildContext context) async {
  //   final authService = Provider.of<AuthService>(context, listen: false);
  //   final violationProvider = Provider.of<ViolationProvider>(
  //     context,
  //     listen: false,
  //   );

  //   final licenseProvider = Provider.of<LicenseProvider>(
  //     context,
  //     listen: false,
  //   );

  //   final driverProvider = Provider.of<DriverProvider>(
  //     context,
  //     listen: false,
  //   );

  //   final List<Violation> violationsList =
  //       await FirebaseFirestore.instance.collection('violations').get().then(
  //             (value) => value.docs
  //                 .map(
  //                   (e) => Violation.fromJson(
  //                     e.data(),
  //                     e.id,
  //                   ),
  //                 )
  //                 .toList(),
  //           );

  //   final List<LicenseDetails> licenseList = await FirebaseFirestore.instance
  //       .collection('licenses')
  //       .where('userID', isEqualTo: authService.currentuser!.uid)
  //       .get()
  //       .then(
  //         (value) => value.docs
  //             .map(
  //               (e) => LicenseDetails.fromJson(
  //                 e.data(),
  //               ),
  //             )
  //             .toList(),
  //       );

  //   final Driver driver = await FirebaseFirestore.instance
  //       .collection('drivers')
  //       .doc(authService.currentuser!.uid)
  //       .get()
  //       .then(
  //         (value) => Driver.fromJson(
  //           value.data() as Map<String, dynamic>,
  //           value.id,
  //         ),
  //       );

  //   driverProvider.setDriver(driver);
  //   licenseProvider.setLicenseList(licenseList);
  //   violationProvider.setViolations(violationsList);
  // }
  Future<void> load(BuildContext context) async {
    try {
      final authService = Provider.of<AuthService>(context, listen: false);
      final violationProvider =
          Provider.of<ViolationProvider>(context, listen: false);
      final licenseProvider =
          Provider.of<LicenseProvider>(context, listen: false);
      final driverProvider =
          Provider.of<DriverProvider>(context, listen: false);

      final violationsFuture =
          await FirebaseFirestore.instance.collection('violations').get().then(
                (value) => value.docs
                    .map((e) => Violation.fromJson(e.data(), e.id))
                    .toList(),
              );

      final licenseListFuture = await FirebaseFirestore.instance
          .collection('licenses')
          .where('userID', isEqualTo: authService.currentuser!.uid)
          .get()
          .then(
            (value) => value.docs
                .map((e) => LicenseDetails.fromJson(e.data()))
                .toList(),
          );

      final driverFuture = await FirebaseFirestore.instance
          .collection('drivers')
          .doc(authService.currentuser!.uid)
          .get();

      // driverProvider.setDriver(driverFuture);
      licenseProvider.setLicenseList(licenseListFuture);
      violationProvider.setViolations(violationsFuture);
    } catch (e) {
      print('Failed to load data: $e');
    }
  }
}
