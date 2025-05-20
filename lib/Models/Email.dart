import 'package:flutter_smartsecurity/Models/passenger.dart';

class Email extends Passenger {
  int emailID;
  String subjectEmail;
  String descriptionEmail;

  Email({
    required this.emailID,
    required this.subjectEmail,
    required this.descriptionEmail,
    // Heredados obligatorios de Passenger
    required super.passengerID,
    required super.passengerfirstName,
    required super.passengerlastname,
    required super.passengeremail,
    required super.passengerdocumentID,
    required super.passengerdocumentType,
    required super.passengercellPhone,
    required super.passengercodecellPhone,
    required super.passengerpassword,
    super.isActive = true,
    DateTime? lastLogin,
  }) : super(lastLogin: lastLogin);
}
