import 'package:cloud_firestore/cloud_firestore.dart';

class Driver {
  String? id;
  String firstName;
  String middleName;
  String lastName;
  String? suffix;
  Timestamp? birthDate;
  String email;
  String phone;
  bool isProfileComplete = false;
  String password;

  Driver({
    this.id,
    this.suffix,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    this.birthDate,
    required this.email,
    required this.phone,
    required this.isProfileComplete,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "suffix": suffix,
      "firstName": firstName,
      "middleName": middleName,
      "lastName": lastName,
      "birthDate": birthDate,
      "email": email,
      "phone": phone,
      "password": password,
      "isProfileComplete": isProfileComplete,
    };
  }

  // Create fromJson method
  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      id: json["id"],
      suffix: json["suffix"] ?? "",
      firstName: json["firstName"] ?? "",
      middleName: json["middleName"] ?? "",
      lastName: json["lastName"] ?? "",
      birthDate: json["birthDate"],
      email: json["email"],
      phone: json["phone"] ?? "",
      password: json["password"] ?? "",
      isProfileComplete: json["isProfileComplete"],
    );
  }

  // Create toString method
  @override
  String toString() {
    return "Driver(id: $id, suffix: $suffix, firstName: $firstName, middleName: $middleName, lastName: $lastName, birthDate: $birthDate, email: $email, phone: $phone, password: $password)";
  }
}
