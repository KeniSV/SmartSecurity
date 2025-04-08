import 'package:flutter/material.dart';
import 'package:flutter_smartsecurity/PantalladeMenuPrincipal.dart';
import 'package:flutter_smartsecurity/Models/Driver.dart';
import 'package:flutter_smartsecurity/Models/TrustedContact.dart';
import 'package:flutter_smartsecurity/Models/Place.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //Instancia de Driver
    final driver = Driver(
      passengerID: 1,
      passengerfirstName: 'Keni',
      passengerlastname: 'Sanchez Villogas',
      passengeremail: 'u202018789@upc.edu.pe',
      passengerdocumentID: 75528813,
      passengerdocumentType: 'DNI',
      passengercellPhone: 961465100,
      passengercodecellPhone: 51,
      drives: true,
      licenseCategory: 'A1',
      licenseNumber: 'A75528813',
      hasCar: true,
      licensePlate: 'ABC-123',
    );
    //Instancia de TrustedContact
    final trustedContact = TrustedContact(
      trustedContactID: 1,
      trustedContactFullName: 'Ingrid Villogas',
      trustedContactCodeCellPhone: 51,
      trustedContactCellPhone: 994702577,
      trustedContactEmail: 'ingridr@hotmail.com',
    );
    //Instancia de MyPlac
    final place = Place(
      placeID: 1,
      placeName: 'Universidad Peruana de Ciencias Aplicadas',
      address: 'Av. Universitaria 1801, San Isidro, Lima',
    );

    return MaterialApp(
      title: 'SmartSecurity',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: PantalladeMenuPrincipal(
          driver: driver,
          trustedContact: trustedContact,
          place: place), // Pasando el driver correctamente
    );
  }
}
