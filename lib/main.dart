import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:u_traffic_driver/Dinfo.dart';
import 'package:u_traffic_driver/Dotp.dart';
import 'package:u_traffic_driver/dForgotPass.dart';
import 'package:u_traffic_driver/home.dart';
import 'package:u_traffic_driver/provider/driver_provider.dart';
import 'package:u_traffic_driver/wrapper.dart';
import 'auth_service.dart';
import 'dlogin.dart';
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
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(),
        ),
        ChangeNotifierProvider(
          create: (_) => DriverProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "U-Traffic Driver",
        // home: const DHome(),
        theme: ThemeData(
        useMaterial3: true,
        fontFamily: GoogleFonts.inter().fontFamily,
      ),
        builder: EasyLoading.init(),
        initialRoute: "/",
        routes: {
          "/": (context) => const Wrapper(),
          "/login": (context) => const DLogin(),
          "/register": (context) => const DRegister(),
        },
      ),
    );
  }
}
