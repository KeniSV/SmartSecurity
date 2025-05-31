import 'package:flutter/material.dart';
import 'package:flutter_smartsecurity/PantalladeInicio.dart';
import 'package:flutter_smartsecurity/Models/Driver.dart';
import 'package:flutter_smartsecurity/Models/TrustedContact.dart';
import 'package:flutter_smartsecurity/Models/Place.dart';
import 'package:flutter_smartsecurity/Models/Email.dart';
import 'package:flutter_smartsecurity/Models/Passenger.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Usuario común (passenger)
    final passenger = Passenger(
      passengerID: 1,
      passengerfirstName: 'Keni',
      passengerlastname: 'Sanchez Villogas',
      passengeremail: 'u202018789@upc.edu.pe',
      passengerdocumentID: 75528813,
      passengerdocumentType: 'DNI',
      passengercellPhone: 961465100,
      passengercodecellPhone: 51,
      passengerpassword: 'miContrasenaPasajeroSegura123',
    );

    // Usuario conductor (driver)
    final driver = Driver(
      passengerID: 1,
      passengerfirstName: 'Keni',
      passengerlastname: 'Sanchez Villogas',
      passengeremail: 'u202018789@upc.edu.pe',
      passengerdocumentID: 75528813,
      passengerdocumentType: 'DNI',
      passengercellPhone: 961465100,
      passengercodecellPhone: 51,
      passengerpassword: 'miContrasenaConductorSegura123',
      drives: true,
      licenseCategory: 'A1',
      licenseNumber: 'A75528813',
      hasCar: true,
      licensePlate: 'ABC-123',
    );

    // Contacto de confianza
    final trustedContact = TrustedContact(
      trustedContactID: 1,
      trustedContactFullName: 'Ingrid Villogas',
      trustedContactCodeCellPhone: 51,
      trustedContactCellPhone: 994702577,
      trustedContactEmail: 'ingridr@hotmail.com',
    );

    // Lugar
    final place = Place(
      placeID: 1,
      placeName: 'Universidad Peruana de Ciencias Aplicadas',
      address: 'Av. Universitaria 1801, San Isidro, Lima',
    );

    // Email de incidente
    final email = Email(
      emailID: 1,
      subjectEmail: 'Error en el botón',
      descriptionEmail: 'Cuando presiono el botón no envía la solicitud',
      passengerID: passenger.passengerID ?? 0, // manejo seguro
      passengerfirstName: passenger.passengerfirstName,
      passengerlastname: passenger.passengerlastname,
      passengeremail: passenger.passengeremail,
      passengerdocumentID: passenger.passengerdocumentID,
      passengerdocumentType: passenger.passengerdocumentType,
      passengercellPhone: passenger.passengercellPhone,
      passengercodecellPhone: passenger.passengercodecellPhone,
      passengerpassword: passenger.passengerpassword,
    );

    return MaterialApp(
      title: 'SmartSecurity',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: PantalladeInicio(
        driver: driver,
        trustedContact: trustedContact,
        place: place,
        passenger: passenger,
        email: email,
      ),
    );
  }
}
