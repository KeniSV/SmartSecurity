import 'package:flutter/material.dart';
import 'package:flutter_smartsecurity/Models/Passenger.dart';
import 'package:flutter_smartsecurity/PantalladeMiCuentadeUsuario.dart';
import 'package:flutter_smartsecurity/Models/Driver.dart';
import 'package:flutter_smartsecurity/Models/TrustedContact.dart';
import 'package:flutter_smartsecurity/Models/Place.dart';
import 'package:flutter_smartsecurity/Models/Email.dart';

class PantallaDeMiLenguaje extends StatefulWidget {
  final Driver driver;
  final TrustedContact trustedcontact;
  final Place place;
  final Passenger passenger;
  final Email email;

  const PantallaDeMiLenguaje(
      {required this.driver,
      required this.trustedcontact,
      required this.place,
      required this.passenger,
      required this.email,
      super.key});

  @override
  _PantallaDeMiLenguaje createState() => _PantallaDeMiLenguaje();
}

class _PantallaDeMiLenguaje extends State<PantallaDeMiLenguaje> {
  String? _selectedLanguage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => PantalladeMiCuentadeUsuario(
                          driver: widget.driver,
                          trustedContact: widget.trustedcontact,
                          place: widget.place,
                          passenger: widget.passenger,
                          email: widget.email,
                        ))); // Acción para retroceder
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0, // Quitar sombra del AppBar
        iconTheme: const IconThemeData(
          color: Colors.black, // Color de la flecha de retroceso
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'My language',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFEDE7FE),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: DropdownButton<String>(
                isExpanded: true,
                hint: const Text('Select your language'),
                underline: const SizedBox(), // Ocultar la línea de subrayado
                value: _selectedLanguage,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedLanguage = newValue;
                  });
                },
                items: <String>['English', 'Spanish']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0C1D60), // Color del botón
                  padding: const EdgeInsets.symmetric(
                      vertical: 16), // Espaciado interno
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  // Acción al presionar el botón "Save"
                },
                child: const Text(
                  'Save',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
