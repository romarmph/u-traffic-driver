import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:u_traffic_driver/provider/driver_provider.dart';
import 'package:u_traffic_driver/provider/license_provider.dart';
import 'package:u_traffic_driver/provider/violations_provider.dart';
import 'services/auth_service.dart';
import 'firebase_options.dart';
import 'views/wrapper.dart';

import 'package:u_traffic_driver/utils/exports/themes.dart';

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
        ChangeNotifierProvider(
          create: (_) => LicenseProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ViolationProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "U-Traffic Driver",
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: UColors.blue600,
          ),
          useMaterial3: true,
          fontFamily: GoogleFonts.inter().fontFamily,
          elevatedButtonTheme: elevatedButtonTheme,
          inputDecorationTheme: inputDecorationTheme,
          textButtonTheme: textButtonTheme,
          floatingActionButtonTheme: fabTheme,
          appBarTheme: appBarTheme,
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              textStyle: const UTextStyle().textbasefontmedium,
              side: const BorderSide(
                color: UColors.blue500,
                width: 1.5,
              ),
              foregroundColor: UColors.blue500,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          scaffoldBackgroundColor: UColors.white,
        ),
        builder: EasyLoading.init(),
        initialRoute: "/",
        routes: {
          '/': (context) => const WidgetWrapper(),
        },
      ),
    );
  }
}
