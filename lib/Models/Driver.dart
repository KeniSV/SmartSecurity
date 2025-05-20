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
}
