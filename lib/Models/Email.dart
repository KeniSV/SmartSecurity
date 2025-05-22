import 'package:flutter_smartsecurity/Models/passenger.dart';

class Email extends Passenger {
  int emailID;
  String subjectEmail;
  String descriptionEmail;

  Email({
    required this.emailID,
    required this.subjectEmail,
    required this.descriptionEmail,
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

  /// Crear una instancia desde JSON
  factory Email.fromJson(Map<String, dynamic> json) {
    final passenger = json['passenger'] ?? {};

    return Email(
      emailID: json['emailID'],
      subjectEmail: json['subjectEmail'],
      descriptionEmail: json['descriptionEmail'],
      passengerID: passenger['passengerID'] ?? json['passengerID'],
      passengerfirstName: passenger['passengerFirstName'] ?? '',
      passengerlastname: passenger['passengerLastName'] ?? '',
      passengeremail: passenger['passengerEmail'] ?? '',
      passengerdocumentID: passenger['passengerDocumentID'] ?? 0,
      passengerdocumentType:
          (passenger['passengerDocumentType'] ?? '').toString(),
      passengercellPhone: passenger['passengerCellPhone'] ?? 0,
      passengercodecellPhone: passenger['passengerCodeCellPhone'] ?? 0,
      passengerpassword: passenger['passengerPassword'] ?? '',
    );
  }

  /// Convertir a JSON para envío al backend
  Map<String, dynamic> toJson() {
    return {
      "emailID": emailID,
      "subjectEmail": subjectEmail,
      "descriptionEmail": descriptionEmail,
      "passengerID": passengerID,
    };
  }
}
