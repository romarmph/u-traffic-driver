import 'package:u_traffic_driver/config/device/device_constraint.dart';
import 'package:u_traffic_driver/utils/exports/flutter_dart.dart';
import 'package:u_traffic_driver/utils/exports/models.dart';
import 'package:u_traffic_driver/utils/exports/themes.dart';
import 'package:u_traffic_driver/utils/exports/views.dart';
import 'package:u_traffic_driver/utils/exports/services.dart';
import 'package:u_traffic_driver/utils/exports/packages.dart';
import 'package:u_traffic_driver/utils/navigator.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: UColors.white,
        width: deviceWidth(context) * 0.9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppDrawerHeader(),
            const LicenseExpantionListTile(),
            const Spacer(),
            TextButton.icon(
              onPressed: logout,
              icon: const Icon(Icons.logout),
              label: const Text(
                'Logout',
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void logout() {
    AuthService().signOut();
  }
}

class LicenseExpantionListTile extends StatelessWidget {
  const LicenseExpantionListTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthService>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.all(USpace.space12),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('licenses')
            .where(
              'userID',
              isEqualTo: authProvider.currentuser!.uid,
            )
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong'),
            );
          }

          List<Widget> licenseList = snapshot.data!.docs.map((data) {
            LicenseDetails licenseDetails = LicenseDetails.fromJson(
              data.data() as Map<String, dynamic>,
            );
            return ListTile(
              title: Text(licenseDetails.licenseNumber),
              subtitle: Text(licenseDetails.driverName),
              onTap: () => goToLicenseDetailView(licenseDetails, context),
            );
          }).toList();

          return ExpansionTile(
            title: const Text("Licenses"),
            initiallyExpanded: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(USpace.space8),
              side: BorderSide.none,
            ),
            clipBehavior: Clip.antiAlias,
            backgroundColor: UColors.blue100,
            children: [
              ...licenseList,
              Container(
                color: UColors.blue200,
                child: ListTile(
                  leading: const Icon(Icons.add),
                  title: const Text("Add License"),
                  onTap: () {
                    addNewLicens(licenseList.length, context);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void addNewLicens(int licenseCount, BuildContext context) {
    if (licenseCount == 3) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.info,
        title: "Max License Reached",
        text: "You can only add 3 licenses",
        onCancelBtnTap: () => Navigator.pop(context),
      );

      return;
    }

    goAddNewLicenseView(context);
  }
}
