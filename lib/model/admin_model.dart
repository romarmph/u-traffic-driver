class Admin {
  final String? id;
  final String firstName;
  final String middleName;
  final String lastName;
  final String suffix;
  final String email;
  final String createdBy;
  final String updatedBy;
  final String employeeNo;

  final String photoUrl;

  const Admin({
    this.id,
    required this.firstName,
    this.middleName = "",
    required this.lastName,
    this.suffix = "",
    required this.email,
    required this.createdBy,
    this.updatedBy = "",
    required this.photoUrl,
    required this.employeeNo,
  });

  Map<String, dynamic> toJson() {
    return {
      "firstName": firstName,
      "middleName": middleName,
      "lastName": lastName,
      "suffix": suffix,
      "email": email,
      "createdBy": createdBy,
      "updatedBy": updatedBy,
      "photoUrl": photoUrl,
      "employeeNo": employeeNo,
    };
  }

  factory Admin.fromJson(Map<String, dynamic> json, String id) {
    return Admin(
      id: id,
      employeeNo: json['employeeNo'],
      firstName: json["firstName"],
      middleName: json["middleName"],
      lastName: json["lastName"],
      suffix: json["suffix"],
      email: json['email'],
      createdBy: json['createdBy'],
      updatedBy: json['updatedBy'],
      photoUrl: json['photoUrl'],
    );
  }

  @override
  String toString() {
    return "Admin(id: $id, firstName: $firstName, middleName: $middleName, lastName: $lastName, suffix: $suffix, email: $email, : $createdBy, updatedBy: $updatedBy,  photoUrl: $photoUrl,  employeeNo: $employeeNo";
  }
}
