class Passenger {
  int? passengerID; // Opcional, lo genera el backend
  String passengerfirstName;
  String passengerlastname;
  String passengeremail;
  int passengerdocumentID;
  String passengerdocumentType;
  int passengercellPhone;
  int passengercodecellPhone;
  String passengerpassword;
  bool isActive;
  DateTime? lastLogin;

  bool drives;
  String licenseCategory;
  String licenseNumber;
  bool hasCar;
  String licensePlate;

  Passenger({
    this.passengerID,
    required this.passengerfirstName,
    required this.passengerlastname,
    required this.passengeremail,
    required this.passengerdocumentID,
    required this.passengerdocumentType,
    required this.passengercellPhone,
    required this.passengercodecellPhone,
    required this.passengerpassword,
    this.isActive = true,
    this.lastLogin,
    this.drives = false,
    this.licenseCategory = '',
    this.licenseNumber = '',
    this.hasCar = false,
    this.licensePlate = '',
  });

  Map<String, dynamic> toJson() {
    final data = {
      "passengerfirstName": passengerfirstName,
      "passengerlastname": passengerlastname,
      "passengeremail": passengeremail,
      "passengerdocumentID": passengerdocumentID,
      "passengerdocumentType": passengerdocumentType,
      "passengercellPhone": passengercellPhone,
      "passengercodecellPhone": passengercodecellPhone,
      "passengerpassword": passengerpassword,
      "isActive": isActive,
      "drives": drives,
      "licenseCategory": licenseCategory,
      "licenseNumber": licenseNumber,
      "hasCar": hasCar,
      "licensePlate": licensePlate,
    };

    final id = passengerID;
    if (id != null) {
      data["passengerID"] = id;
    }

    return data;
  }

  factory Passenger.fromJson(Map<String, dynamic> json) {
    return Passenger(
      passengerID: json["passengerID"],
      passengerfirstName: json["passengerfirstName"],
      passengerlastname: json["passengerlastname"],
      passengeremail: json["passengeremail"],
      passengerdocumentID: json["passengerdocumentID"],
      passengerdocumentType: json["passengerdocumentType"],
      passengercellPhone: json["passengercellPhone"],
      passengercodecellPhone: json["passengercodecellPhone"],
      passengerpassword: json["passengerpassword"],
      isActive: json["isActive"] ?? true,
      lastLogin:
          json["lastLogin"] != null ? DateTime.parse(json["lastLogin"]) : null,
      drives: json["drives"] ?? false,
      licenseCategory: json["licenseCategory"] ?? '',
      licenseNumber: json["licenseNumber"] ?? '',
      hasCar: json["hasCar"] ?? false,
      licensePlate: json["licensePlate"] ?? '',
    );
  }
}
