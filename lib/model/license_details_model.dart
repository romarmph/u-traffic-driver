import 'package:u_traffic_driver/utils/exports/packages.dart';

class LicenseDetails {
  String? licenseID;
  String? userID;
  Timestamp? dateCreated;
  final String licenseNumber;
  final Timestamp? expirationDate;
  final String driverName;
  final String address;
  final String nationality;
  final String sex;
  final Timestamp? birthdate;
  final double height;
  final double weight;
  final String agencyCode;
  final String dlcodes;
  final String conditions;
  final String bloodType;
  final String eyesColor;
  final String photoUrl;

  LicenseDetails({
    this.userID,
    this.licenseID,
    this.dateCreated,
    required this.licenseNumber,
    required this.expirationDate,
    required this.driverName,
    required this.address,
    required this.nationality,
    required this.sex,
    required this.birthdate,
    required this.height,
    required this.weight,
    required this.agencyCode,
    required this.dlcodes,
    required this.conditions,
    required this.bloodType,
    required this.eyesColor,
    this.photoUrl = '',
  });

  Map<String, dynamic> toJson() {
    return {
      "licenseNumber": licenseNumber,
      "expirationDate": expirationDate,
      "dateCreated": dateCreated,
      "driverName": driverName,
      "address": address,
      "nationality": nationality,
      "sex": sex,
      "birthdate": birthdate,
      "height": height,
      "weight": weight,
      "agencyCode": agencyCode,
      "dlcodes": dlcodes,
      "conditions": conditions,
      "bloodType": bloodType,
      "eyesColor": eyesColor,
      "userID": userID,
      "photoUrl": photoUrl,
    };
  }

  factory LicenseDetails.fromJson(Map<String, dynamic> json, [String? id]) {
    return LicenseDetails(
      licenseID: id,
      licenseNumber: json["licenseNumber"],
      expirationDate: json["expirationDate"],
      dateCreated: json["dateCreated"],
      driverName: json["driverName"],
      address: json["address"],
      nationality: json["nationality"],
      sex: json["sex"],
      birthdate: json["birthdate"],
      height: json["height"],
      weight: json["weight"],
      agencyCode: json["agencyCode"],
      dlcodes: json["dlcodes"],
      conditions: json["conditions"],
      bloodType: json['bloodType'],
      eyesColor: json['eyesColor'],
      userID: json['userID'],
      photoUrl: json['photoUrl'],
    );
  }

  LicenseDetails copyWith({
    String? licenseID,
    String? userID,
    Timestamp? dateCreated,
    String? licenseNumber,
    Timestamp? expirationDate,
    String? driverName,
    String? address,
    String? nationality,
    String? sex,
    Timestamp? birthdate,
    double? height,
    double? weight,
    String? agencyCode,
    String? dlcodes,
    String? conditions,
    String? bloodType,
    String? eyesColor,
    String? photoUrl,
  }) {
    return LicenseDetails(
      licenseNumber: licenseNumber ?? this.licenseNumber,
      expirationDate: expirationDate ?? this.expirationDate,
      driverName: driverName ?? this.driverName,
      address: address ?? this.address,
      nationality: nationality ?? this.nationality,
      sex: sex ?? this.sex,
      birthdate: birthdate ?? this.birthdate,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      agencyCode: agencyCode ?? this.agencyCode,
      dlcodes: dlcodes ?? this.dlcodes,
      conditions: conditions ?? this.conditions,
      bloodType: bloodType ?? this.bloodType,
      eyesColor: eyesColor ?? this.eyesColor,
      userID: userID ?? this.userID,
      photoUrl: photoUrl ?? this.photoUrl,
      dateCreated: dateCreated ?? this.dateCreated,
      licenseID: licenseID ?? this.licenseID,
    );
  }
}
