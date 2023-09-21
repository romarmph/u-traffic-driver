import 'package:cloud_firestore/cloud_firestore.dart';

class Driver {
  String? id;
  String driverName;
  Timestamp birthDate;
  String address;
  String? email;
  String? phone;
  bool isProfileComplete = false;

  Driver({
    this.id,
    required this.driverName,
    required this.address,
    required this.birthDate,
    required this.email,
    required this.phone,
    required this.isProfileComplete,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "driverName": driverName,
      "address": address,
      "birthDate": birthDate,
      "email": email,
      "phone": phone,
      "isProfileComplete": isProfileComplete,
    };
  }

  // Create fromJson method
  factory Driver.fromJson(Map<String, dynamic> json, String id) {
    return Driver(
      id: json["id"],
      driverName: json["driverName"],
      address: json["address"],
      birthDate: json["birthDate"],
      email: json["email"],
      phone: json["phone"],
      isProfileComplete: json["isProfileComplete"],
    );
  }

  // Create toString method
  @override
  String toString() {
    return 'Driver{id: $id, driverName: $driverName, address: $address, birthDate: $birthDate, email: $email, phone: $phone, isProfileComplete: $isProfileComplete}';
  }
}
