import 'package:flutter/material.dart';
import 'package:u_traffic_driver/utils/exports/exports.dart';

class AccountPage extends ConsumerWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
      ),
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
        ],
      ),
    );
  }
}
