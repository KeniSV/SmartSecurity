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
          passenger['passengerFirstName'] ?? json['passengerFirstName'],
      passengerlastname:
          passenger['passengerLastName'] ?? json['passengerLastName'],
      passengeremail: passenger['passengerEmail'] ?? json['passengerEmail'],
      passengerdocumentID:
          passenger['passengerDocumentID'] ?? json['passengerDocumentID'],
      passengerdocumentType:
          (passenger['passengerDocumentType'] ?? json['passengerDocumentType'])
              .toString(),
      passengercellPhone:
          passenger['passengerCellPhone'] ?? json['passengerCellPhone'],
      passengercodecellPhone:
          passenger['passengerCodeCellPhone'] ?? json['passengerCodeCellPhone'],
      passengerpassword:
          passenger['passengerPassword'] ?? json['passengerPassword'],
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
        "passengerFirstName": passengerfirstName,
        "passengerLastName": passengerlastname,
        "passengerEmail": passengeremail,
        "passengerDocumentID": passengerdocumentID,
        "passengerDocumentType": int.tryParse(passengerdocumentType),
        "passengerCellPhone": passengercellPhone,
        "passengerCodeCellPhone": passengercodecellPhone,
        "passengerPassword": passengerpassword,
      },
      "drives": drives,
      "licenseCategory": licenseCategory,
      "licenseNumber": licenseNumber,
      "hasCar": hasCar,
      "licensePlate": licensePlate,
    };
  }
}
