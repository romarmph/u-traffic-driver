import 'package:flutter/material.dart';
import 'package:u_traffic_driver/config/navigator_key.dart';
import 'package:u_traffic_driver/database/fcm_tokens_database.dart';
import 'package:u_traffic_driver/riverpod/complaints.riverpod.dart';
import 'package:u_traffic_driver/riverpod/driver_vehicle.riverpod.dart';
import 'package:u_traffic_driver/riverpod/license.riverpod.dart';
import 'package:u_traffic_driver/riverpod/ticket.riverpod.dart';
import 'package:u_traffic_driver/utils/exports/exports.dart';

class AccountPage extends ConsumerWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Account'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const ViewWrapper(),
              ),
              (route) => false,
            ),
          )),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            title: const Text('Profile'),
            subtitle: const Text('Edit your profile'),
            leading: const Icon(Icons.person),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ProfilePage(
                  currentDriver: ref.watch(driverAccountProvider)!,
                ),
              ),
            ),
          ),
          ListTile(
            title: const Text('Password'),
            subtitle: const Text('Update your password'),
            leading: const Icon(Icons.person),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const UpdatePasswordPage(),
              ),
            ),
          ),
          const Spacer(),
          TextButton.icon(
            onPressed: () => logout(ref),
            icon: const Icon(Icons.logout),
            label: const Text(
              'Logout',
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }

  void logout(WidgetRef ref) async {
    ref.invalidate(driverAccountProvider);
    ref.invalidate(driverDatabaseProvider);
    ref.invalidate(currentUserProvider);
    ref.invalidate(driverStreamProvider);
    ref.invalidate(driverDatabaseProvider);
    ref.invalidate(getAllComplaintsProvider);
    ref.invalidate(getAllTickets);
    ref.invalidate(getAllRepliesProvider);
    ref.invalidate(driverVehiclesStreamProvider);
    ref.invalidate(vehicleByIdStream);
    ref.invalidate(getAllDriversLicense);
    ref.invalidate(allLicenseProvider);

    await FcmTokenDatabase.instance.deleteToken();

    await AuthService.instance.signOut();
    Navigator.of(navigatorKey.currentContext!).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const WidgetWrapper(),
      ),
      (route) => false,
    );
  }
}
