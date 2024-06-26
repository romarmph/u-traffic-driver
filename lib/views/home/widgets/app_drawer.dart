import 'package:u_traffic_driver/config/device/device_constraint.dart';
import 'package:u_traffic_driver/riverpod/driver_vehicle.riverpod.dart';
import 'package:u_traffic_driver/riverpod/license.riverpod.dart';
import 'package:u_traffic_driver/utils/exports/flutter_dart.dart';
import 'package:u_traffic_driver/utils/exports/models.dart';
import 'package:u_traffic_driver/utils/exports/themes.dart';
import 'package:u_traffic_driver/utils/exports/views.dart';
import 'package:u_traffic_driver/utils/exports/services.dart';
import 'package:u_traffic_driver/utils/exports/packages.dart';
import 'package:u_traffic_driver/utils/navigator.dart';
import 'package:u_traffic_driver/views/home/add_new_vehicle_view.dart';
import 'package:u_traffic_driver/views/home/vehicle_detail_view.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
          side: BorderSide.none,
        ),
        backgroundColor: UColors.white,
        width: deviceWidth(context) * 0.9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppDrawerHeader(),
            const Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    LicenseExpantionListTile(),
                    DriverVehicleListTile(),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Account Settings'),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const AccountPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class LicenseExpantionListTile extends ConsumerWidget {
  const LicenseExpantionListTile({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authProvider = AuthService.instance;

    return Padding(
      padding: const EdgeInsets.all(USpace.space12),
      child: ref.watch(getAllDriversLicense).when(
          data: (license) {
            List<Widget> licenseList = license.map((data) {
              return ListTile(
                title: Text(data.licenseNumber),
                subtitle: Text(data.driverName),
                onTap: () => goToLicenseDetailView(data, context),
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
          error: (error, stackTrace) {
            return const Center(
              child: Text('Something went wrong'),
            );
          },
          loading: () => const Center(
                child: CircularProgressIndicator(),
              )),
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

class DriverVehicleListTile extends ConsumerWidget {
  const DriverVehicleListTile({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(USpace.space12),
      child: ref.watch(driverVehiclesStreamProvider).when(
            data: (vehicles) {
              List<Widget> licenseList = vehicles.map((data) {
                return ListTile(
                  title: Text(data.brand),
                  subtitle: Text(data.plateNumber!.isNotEmpty
                      ? data.plateNumber!
                      : data.chassisNumber!.isNotEmpty
                          ? data.chassisNumber!
                          : data.engineNumber!.isNotEmpty
                              ? data.engineNumber!
                              : data.conductionOrFileNumber!.isNotEmpty
                                  ? data.conductionOrFileNumber!
                                  : "No Vehicle Number"),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => VehicleDetailView(
                          vehicle: data,
                        ),
                      ),
                    );
                  },
                );
              }).toList();

              return ExpansionTile(
                title: const Text("Vehicles"),
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
                      title: const Text("Add Vehicle"),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const AddVehicleForm(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
            error: (error, stackTrace) {
              return const Center(
                child: Text('Something went wrong'),
              );
            },
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
    );
  }
}
