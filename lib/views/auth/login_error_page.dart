import 'package:flutter/material.dart';
import 'package:u_traffic_driver/utils/exports/exports.dart';

class LoginErrorPage extends ConsumerWidget {
  const LoginErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_rounded,
              color: UColors.red400,
              size: 42,
            ),
            const Text(
              "Error while trying to login!",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Try again later.",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(authServiceProvider).signOut();
              },
              child: const Text("Okay"),
            ),
          ],
        ),
      ),
    );
  }
}
