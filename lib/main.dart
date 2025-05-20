import 'package:flutter/material.dart';
import 'package:flutter_smartsecurity/PantalladeInicio.dart';
import 'package:flutter_smartsecurity/Models/Driver.dart';
import 'package:flutter_smartsecurity/Models/TrustedContact.dart';
import 'package:flutter_smartsecurity/Models/Place.dart';
import 'package:flutter_smartsecurity/Models/Email.dart';
import 'package:flutter_smartsecurity/Models/Passenger.dart'; // Faltaba importar Passenger

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Instancia de Passenger
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

    // Instancia de Driver
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

    // Instancia de TrustedContact
    final trustedContact = TrustedContact(
      trustedContactID: 1,
      trustedContactFullName: 'Ingrid Villogas',
      trustedContactCodeCellPhone: 51,
      trustedContactCellPhone: 994702577,
      trustedContactEmail: 'ingridr@hotmail.com',
    );

    // Instancia de Place
    final place = Place(
      placeID: 1,
      placeName: 'Universidad Peruana de Ciencias Aplicadas',
      address: 'Av. Universitaria 1801, San Isidro, Lima',
    );

    // Instancia de Email
    final email = Email(
      emailID: 1,
      subjectEmail: 'Error en el boton',
      descriptionEmail: 'Cuando presiono el boton no envia la solicitud',
      passengerID: 1,
      passengerfirstName: 'Keni',
      passengerlastname: 'Sanchez',
      passengeremail: 'skeni8892@gmail.com',
      passengerdocumentID: 75528813,
      passengerdocumentType: 'DNI',
      passengercellPhone: 961465100,
      passengercodecellPhone: 51,
      passengerpassword: 'miContrasenaPasajeroSegura123',
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
        email: email, // <-- Solucionamos el error
      ),
    );
  }
}
