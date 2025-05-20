import 'package:flutter/material.dart';
import 'package:flutter_smartsecurity/Models/Passenger.dart';
import 'package:flutter_smartsecurity/PantalladePalabraClave.dart';
import 'package:flutter_smartsecurity/PantalladeUsuario.dart';
import 'package:flutter_smartsecurity/Models/Driver.dart';
import 'package:flutter_smartsecurity/Models/TrustedContact.dart';
import 'package:flutter_smartsecurity/Models/Place.dart';
import 'package:flutter_smartsecurity/Models/Email.dart';

class PantalladeConfiguraciones extends StatefulWidget {
  final Driver driver;
  final TrustedContact trustedcontact;
  final Place place;
  final Passenger passenger;
  final Email email;

  const PantalladeConfiguraciones(
      {required this.driver,
      required this.trustedcontact,
      required this.place,
      required this.passenger,
      required this.email,
      super.key});

  @override
  _PantalladeConfiguracionesState createState() =>
      _PantalladeConfiguracionesState();
}

class _PantalladeConfiguracionesState extends State<PantalladeConfiguraciones> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => PantalladeUsuario(
                        driver: widget.driver,
                        trustedContact: widget.trustedcontact,
                        place: widget.place,
                        passenger: widget.passenger,
                        email: widget.email,
                      )),
            );
          },
        ),
        title: const Text(
          "Settings",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              leading: const CircleAvatar(
                radius: 24,
                backgroundColor: Color(0xFFEDE7FE),
                child: Icon(Icons.graphic_eq, color: Colors.black),
              ),
              title: const Text('Keyword',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: const Text('Set your keyword'),
              trailing:
                  const Icon(Icons.arrow_forward_ios, color: Colors.black),
              onTap: () {
                // Navegar a la pantalla de configuración de "Keyword"
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PantalladePalabraClave(),
                  ),
                );
              },
            ),
            Divider(color: Colors.grey.shade300),
          ],
        ),
      ),
    );
  }
}
