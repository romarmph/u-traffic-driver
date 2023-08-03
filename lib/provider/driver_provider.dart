import '../model/driver_model.dart';
import 'package:flutter/material.dart';

class DriverProvider extends ChangeNotifier {
   Driver _currentdriver = Driver(
    firstName: "",
    middleName: "",
    lastName: "",
    birthDate: "",
    email: "",
    phone: "",
    password: "",
  );

  Driver get currentDriver => _currentdriver;

  void updateDriver(Driver driver){

    _currentdriver = driver;
    notifyListeners();

  }
}
