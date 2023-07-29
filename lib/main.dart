import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const UTrafficDriver());
}

class UTrafficDriver extends StatelessWidget {
  const UTrafficDriver({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "U-Traffic Driver",
      home: Scaffold(
        body: Center(
          child: Text("Driver Home"),
        ),
      ),
    );
  }
}
