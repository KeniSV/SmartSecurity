import 'package:flutter_smartsecurity/Models/Passenger.dart';

class Driver extends Passenger {
  bool drives;
  String licenseCategory;
  String licenseNumber;
  bool hasCar;
  String licensePlate;

  Driver({
    required super.passengerID,
    required super.passengerfirstName,
    required super.passengerlastname,
    required super.passengeremail,
    required super.passengerdocumentID,
    required super.passengerdocumentType,
    required super.passengercellPhone,
    required super.passengercodecellPhone,
    required super.passengerpassword,
    bool super.isActive = true,
    super.lastLogin,
    required this.drives,
    required this.licenseCategory,
    required this.licenseNumber,
    required this.hasCar,
    required this.licensePlate,
  });

  /// Método para convertir desde JSON (útil para responses)
  factory Driver.fromJson(Map<String, dynamic> json) {
    final passenger = json['passenger'] ?? {}; // soporte para API anidada
    return Driver(
      passengerID: passenger['passengerID'] ?? json['passengerID'],
      passengerfirstName:
          passenger['passengerfirstName'] ?? json['passengerfirstName'],
      passengerlastname:
          passenger['passengerlastname'] ?? json['passengerlastname'],
      passengeremail: passenger['passengeremail'] ?? json['passengeremail'],
      passengerdocumentID:
          passenger['passengerdocumentID'] ?? json['passengerdocumentID'],
      passengerdocumentType:
          (passenger['passengerdocumentType'] ?? json['passengerdocumentType'])
              .toString(),
      passengercellPhone:
          passenger['passengercellPhone'] ?? json['passengercellPhone'],
      passengercodecellPhone:
          passenger['passengercodecellPhone'] ?? json['passengercodecellPhone'],
      passengerpassword:
          passenger['passengerpassword'] ?? json['passengerpassword'],
      drives: json['drives'],
      licenseCategory: json['licenseCategory'],
      licenseNumber: json['licenseNumber'],
      hasCar: json['hasCar'],
      licensePlate: json['licensePlate'],
    );
  }

  /// Método para convertir a JSON (útil para POST/PUT)
  Map<String, dynamic> toJson() {
    return {
      "passenger": {
        "passengerID": passengerID,
        "passengerfirstName": passengerfirstName,
        "passengerlastname": passengerlastname,
        "passengeremail": passengeremail,
        "passengerdocumentID": passengerdocumentID,
        "passengerdocumentType": passengerdocumentType,
        "passengercellPhone": passengercellPhone,
        "passengercodecellPhone": passengercodecellPhone,
        "passengerpassword": passengerpassword,
      },
      "drives": drives,
      "licenseCategory": licenseCategory,
      "licenseNumber": licenseNumber,
      "hasCar": hasCar,
      "licensePlate": licensePlate,
    };
  }
}
