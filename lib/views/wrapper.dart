import 'package:u_traffic_driver/model/violation_model.dart';
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

        return FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection('drivers')
              .doc(authService.currentuser!.uid)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Scaffold(
                body: Center(
                  child: Text("Error"),
                ),
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            Driver driver = Driver.fromJson(
              snapshot.data!.data() as Map<String, dynamic>,
            );

            if (driver.isProfileComplete == false) {
              return const CompleteInfoPage();
            }

            load(context);

            return const ViewWrapper();
          },
        );
      },
    );
  }

  void load(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final violationProvider = Provider.of<ViolationProvider>(
      context,
      listen: false,
    );

    final licenseProvider = Provider.of<LicenseProvider>(
      context,
      listen: false,
    );

    final List<Violation> violationsList =
        await FirebaseFirestore.instance.collection('violations').get().then(
              (value) => value.docs
                  .map(
                    (e) => Violation.fromJson(
                      e.data(),
                      e.id,
                    ),
                  )
                  .toList(),
            );

    final List<LicenseDetails> licenseList = await FirebaseFirestore.instance
        .collection('licenses')
        .where('userID', isEqualTo: authService.currentuser!.uid)
        .get()
        .then(
          (value) => value.docs
              .map(
                (e) => LicenseDetails.fromJson(
                  e.data(),
                ),
              )
              .toList(),
        );

    licenseProvider.setLicenseList(licenseList);
    violationProvider.setViolations(violationsList);
  }
}
