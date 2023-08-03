import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:u_traffic_driver/Dinfo.dart';
import 'package:u_traffic_driver/dlogin.dart';
import 'package:u_traffic_driver/dregister.dart';
import 'package:u_traffic_driver/home.dart';

import 'auth_service.dart';
import 'model/user_model.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return StreamBuilder<User?>(
      stream: authService.user,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.data == null) {
            return const DLogin();
          }
          // accountCompleted == false
          // return Dinfo()
          
          return const Dinfo();
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
