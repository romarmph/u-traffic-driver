import 'package:cloud_firestore/cloud_firestore.dart';

class Driver {
  String? id;
  String firstName;
  String middleName;
  String lastName;
  Timestamp? birthDate;
  String email;
  String phone;
  bool isProfileComplete = false;

  Driver({
    this.id,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    this.birthDate,
    required this.email,
    required this.phone,
    required this.isProfileComplete,
  });

  Map<String, dynamic> toJson() {
    return {
      "firstName": firstName,
      "middleName": middleName,
      "lastName": lastName,
      "birthDate": birthDate,
      "email": email,
      "phone": phone,
      "isProfileComplete": isProfileComplete,
    };
  }

  // Create fromJson method
  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      id: json["id"],
      firstName: json["firstName"] ?? "",
      middleName: json["middleName"] ?? "",
      lastName: json["lastName"] ?? "",
      birthDate: json["birthDate"],
      email: json["email"],
      phone: json["phone"] ?? "",
      isProfileComplete: json["isProfileComplete"],
    );
  }

  // Create toString method
  @override
  String toString() {
    return "Driver(id: $id, firstName: $firstName, middleName: $middleName, lastName: $lastName, birthDate: $birthDate, email: $email, phone: $phone, password: )";
  }
}
