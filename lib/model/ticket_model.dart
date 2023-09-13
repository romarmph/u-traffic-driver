import 'package:u_traffic_driver/config/enums/ticket_status.dart';
import 'package:u_traffic_driver/utils/exports/packages.dart';

class Ticket {
  String? id;
  int? ticketNumber;
  Timestamp? dateCreated;
  final String licenseNumber;
  final String firstName;
  final String middleName;
  final String lastName;
  final String phone;
  final String email;
  final String address;
  final String vehicleType;
  final String engineNumber;
  final String chassisNumber;
  final String plateNumber;
  final String vehicleOwner;
  final String vehicleOwnerAddress;
  final String enforcerId;
  final String driverSignature;
  final Timestamp violationDateTime;
  final Timestamp birthDate;
  final Map<String, dynamic> placeOfViolation;
  final List<dynamic> violationsID;
  final TicketStatus status;

  Ticket({
    this.id,
    this.ticketNumber,
    this.dateCreated,
    required this.violationsID,
    required this.licenseNumber,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.birthDate,
    required this.phone,
    required this.email,
    required this.address,
    required this.status,
    required this.vehicleType,
    required this.engineNumber,
    required this.chassisNumber,
    required this.plateNumber,
    required this.vehicleOwner,
    required this.vehicleOwnerAddress,
    required this.placeOfViolation,
    required this.violationDateTime,
    required this.enforcerId,
    required this.driverSignature,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['id'],
      ticketNumber: json['ticketNumber'],
      dateCreated: json['dateCreated'],
      violationsID: json['violationsID'],
      licenseNumber: json['licenseNumber'],
      firstName: json['firstName'],
      middleName: json['middleName'],
      lastName: json['lastName'],
      birthDate: json['birthDate'],
      phone: json['phone'],
      email: json['email'],
      address: json['address'],
      status: json['status'],
      vehicleType: json['vehicleType'],
      engineNumber: json['engineNumber'],
      chassisNumber: json['chassisNumber'],
      plateNumber: json['plateNumber'],
      vehicleOwner: json['vehicleOwner'],
      vehicleOwnerAddress: json['vehicleOwnerAddress'],
      placeOfViolation: json['placeOfViolation'],
      violationDateTime: json['violationDateTime'],
      enforcerId: json['enforcerId'],
      driverSignature: json['driverSignature'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ticketNumber': ticketNumber,
      'dateCreated': dateCreated,
      'violationsID': violationsID,
      'licenseNumber': licenseNumber,
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'birthDate': birthDate,
      'phone': phone,
      'email': email,
      'address': address,
      'status': status,
      'vehicleType': vehicleType,
      'engineNumber': engineNumber,
      'chassisNumber': chassisNumber,
      'plateNumber': plateNumber,
      'vehicleOwner': vehicleOwner,
      'vehicleOwnerAddress': vehicleOwnerAddress,
      'placeOfViolation': placeOfViolation,
      'violationDateTime': violationDateTime,
      'enforcerId': enforcerId,
      'driverSignature': driverSignature,
    };
  }

  // create copyWith method
  Ticket copyWith({
    String? id,
    int? ticketNumber,
    Timestamp? dateCreated,
    List<dynamic>? violationsID,
    String? licenseNumber,
    String? firstName,
    String? middleName,
    String? lastName,
    Timestamp? birthDate,
    String? phone,
    String? email,
    String? address,
    TicketStatus? status,
    String? vehicleType,
    String? engineNumber,
    String? chassisNumber,
    String? plateNumber,
    String? vehicleOwner,
    String? vehicleOwnerAddress,
    Map<String, dynamic>? placeOfViolation,
    Timestamp? violationDateTime,
    String? enforcerId,
    String? driverSignature,
  }) {
    return Ticket(
      id: id ?? this.id,
      ticketNumber: ticketNumber ?? this.ticketNumber,
      dateCreated: dateCreated ?? this.dateCreated,
      violationsID: violationsID ?? this.violationsID,
      licenseNumber: licenseNumber ?? this.licenseNumber,
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      lastName: lastName ?? this.lastName,
      birthDate: birthDate ?? this.birthDate,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      address: address ?? this.address,
      status: status ?? this.status,
      vehicleType: vehicleType ?? this.vehicleType,
      engineNumber: engineNumber ?? this.engineNumber,
      chassisNumber: chassisNumber ?? this.chassisNumber,
      plateNumber: plateNumber ?? this.plateNumber,
      vehicleOwner: vehicleOwner ?? this.vehicleOwner,
      vehicleOwnerAddress: vehicleOwnerAddress ?? this.vehicleOwnerAddress,
      placeOfViolation: placeOfViolation ?? this.placeOfViolation,
      violationDateTime: violationDateTime ?? this.violationDateTime,
      enforcerId: enforcerId ?? this.enforcerId,
      driverSignature: driverSignature ?? this.driverSignature,
    );
  }
}
