import 'package:driverslogin/screen/driverHomepage.dart';
import 'package:driverslogin/screen/login.dart';
import 'package:driverslogin/screen/register.dart';
import 'package:flutter/material.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Driver Home Screen'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text('Driver Home'),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => loginScreen()));
                  },
                  child: Text('LOGIN')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterScreen()));
                  },
                  child: Text('REGISTER')),
            ],
          ),
        ),
      ),
    );
  }
}
