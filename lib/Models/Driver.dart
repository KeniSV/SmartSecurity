import 'package:flutter_smartsecurity/Models/Passenger.dart';

class Driver extends Passenger {
  bool drives;
  String licenseCategory;
  String licenseNumber;
  bool hasCar;
  String licensePlate;

  Driver({
    required int passengerID,
    required String passengerfirstName,
    required String passengerlastname,
    required String passengeremail,
    required int passengerdocumentID,
    required String passengerdocumentType,
    required int passengercellPhone,
    required int passengercodecellPhone,
    required this.drives,
    required this.licenseCategory,
    required this.licenseNumber,
    required this.hasCar,
    required this.licensePlate,
  }) : super(
          passengerID: passengerID,
          passengerfirstName: passengerfirstName,
          passengerlastname: passengerlastname,
          passengeremail: passengeremail,
          passengerdocumentID: passengerdocumentID,
          passengerdocumentType: passengerdocumentType,
          passengercellPhone: passengercellPhone,
          passengercodecellPhone: passengercodecellPhone,
        );
}
