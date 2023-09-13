import 'package:u_traffic_driver/utils/exports/packages.dart';

class LicenseDetails {
  String? licenseID;
  String? userID;
  final String licenseNumber;
  final Timestamp expirationDate;
  final Timestamp dateIssued;
  final Timestamp dateCreated;
  final String firstName;
  final String middleName;
  final String lastName;
  final String address;
  final String nationality;
  final String sex;
  final Timestamp dateOfBirth;
  final double height;
  final double weight;
  final String agenyCode;
  final String licenseRestriction;
  final String conditions;
  final String bloodType;
  final String eyesColor;

  LicenseDetails({
    this.userID,
    this.licenseID,
    required this.licenseNumber,
    required this.expirationDate,
    required this.dateIssued,
    required this.dateCreated,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.address,
    required this.nationality,
    required this.sex,
    required this.dateOfBirth,
    required this.height,
    required this.weight,
    required this.agenyCode,
    required this.licenseRestriction,
    required this.conditions,
    required this.bloodType,
    required this.eyesColor,
  });

  Map<String, dynamic> toJson() {
    return {
      "licenseNumber": licenseNumber,
      "expirationDate": expirationDate,
      "dateIssued": dateIssued,
      "dateCreated": dateCreated,
      "firstName": firstName,
      "middleName": middleName,
      "lastName": lastName,
      "address": address,
      "nationality": nationality,
      "sex": sex,
      "dateOfBirth": dateOfBirth,
      "height": height,
      "weight": weight,
      "agenyCode": agenyCode,
      "licenseRestriction": licenseRestriction,
      "conditions": conditions,
      "bloodType": bloodType,
      "eyesColor": eyesColor,
      "userID": userID,
    };
  }

  factory LicenseDetails.fromJson(Map<String, dynamic> json) {
    return LicenseDetails(
      licenseNumber: json["licenseNumber"],
      expirationDate: json["expirationDate"],
      dateIssued: json["dateIssued"],
      dateCreated: json["dateCreated"],
      firstName: json["firstName"],
      middleName: json["middleName"],
      lastName: json["lastName"],
      address: json["address"],
      nationality: json["nationality"],
      sex: json["sex"],
      dateOfBirth: json["dateOfBirth"],
      height: json["height"],
      weight: json["weight"],
      agenyCode: json["agenyCode"],
      licenseRestriction: json["licenseRestriction"],
      conditions: json["conditions"],
      bloodType: json['bloodType'],
      eyesColor: json['eyesColor'],
      userID: json['userID'],
    );
  }
}
