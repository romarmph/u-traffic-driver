class Driver {
   String? id;
   String firstName;
   String middleName;
   String lastName;
   String? suffix;
   String birthDate;
   String email;
   String phone;
  //  bool accountCompleted;
  String password;

   Driver({
    this.id,
    this.suffix,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.birthDate,
    required this.email,
    required this.phone,
    // required this.accountCompleted,
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
    };
  }

  // Create fromJson method
  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      id: json["id"],
      suffix: json["suffix"],
      firstName: json["firstName"],
      middleName: json["middleName"],
      lastName: json["lastName"],
      birthDate: json["birthDate"],
      email: json["email"],
      phone: json["phone"],
      password: json["password"],
    );
  }

  // Create toString method
  @override
  String toString() {
    return "Driver(id: $id, suffix: $suffix, firstName: $firstName, middleName: $middleName, lastName: $lastName, birthDate: $birthDate, email: $email, phone: $phone, password: $password)";
  }
}