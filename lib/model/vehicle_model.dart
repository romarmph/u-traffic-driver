class DriverVehicle {
  final String? id;
  final String driverId;
  final String model;
  final String brand;
  final String? plateNumber;
  final String? engineNumber;
  final String? chassisNumber;
  final String? conductionOrFileNumber;

  DriverVehicle({
    this.id,
    required this.driverId,
    required this.brand,
    required this.model,
    this.plateNumber,
    this.engineNumber,
    this.chassisNumber,
    this.conductionOrFileNumber,
  });

  factory DriverVehicle.fromJson(Map<String, dynamic> json, String id) {
    return DriverVehicle(
      id: id,
      brand: json['brand'],
      model: json['model'],
      driverId: json['driverId'],
      plateNumber: json['plateNumber'],
      engineNumber: json['engineNumber'],
      chassisNumber: json['chassisNumber'],
      conductionOrFileNumber: json['conductionOrFileNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'brand': brand,
      'driverId': driverId,
      'model': model,
      'plateNumber': plateNumber,
      'engineNumber': engineNumber,
      'chassisNumber': chassisNumber,
      'conductionOrFileNumber': conductionOrFileNumber,
    };
  }

  DriverVehicle copyWith({
    String? id,
    String? driverId,
    String? brand,
    String? model,
    String? plateNumber,
    String? engineNumber,
    String? chassisNumber,
    String? conductionOrFileNumber,
  }) {
    return DriverVehicle(
      id: id ?? this.id,
      model: model ?? this.model,
      driverId: driverId ?? this.driverId,
      brand: brand ?? this.brand,
      plateNumber: plateNumber ?? this.plateNumber,
      engineNumber: engineNumber ?? this.engineNumber,
      chassisNumber: chassisNumber ?? this.chassisNumber,
      conductionOrFileNumber:
          conductionOrFileNumber ?? this.conductionOrFileNumber,
    );
  }
}
