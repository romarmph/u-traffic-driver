import 'package:flutter/material.dart';
import 'package:u_traffic_driver/config/navigator_key.dart';

import 'package:u_traffic_driver/utils/exports/exports.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: UTrafficDriver(),
    ),
  );
}

class UTrafficDriver extends StatelessWidget {
  const UTrafficDriver({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "U-Traffic Driver",
      navigatorKey: navigatorKey,
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
        '/new-license': (context) => const AddNewLicenseView(),
      },
    );
  }
}
