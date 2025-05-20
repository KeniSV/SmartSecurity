import 'package:flutter/material.dart';
import 'package:flutter_smartsecurity/Models/Passenger.dart';
import 'package:flutter_smartsecurity/Models/Driver.dart';
import 'package:flutter_smartsecurity/Models/TrustedContact.dart';
import 'package:flutter_smartsecurity/Models/Place.dart';
import 'package:flutter_smartsecurity/Models/Email.dart';
import 'package:flutter_smartsecurity/PantalladeMenuPrincipal.dart';
import 'package:flutter_smartsecurity/PantalladeMiCuentadeUsuario.dart';
import 'package:flutter_smartsecurity/PantalladeConfiguraciones.dart';

class PantalladeUsuario extends StatefulWidget {
  final Driver driver;
  final TrustedContact trustedContact;
  final Place place;
  final Passenger passenger;
  final Email email;

  const PantalladeUsuario({
    required this.driver,
    required this.trustedContact,
    required this.place,
    required this.passenger,
    required this.email,
    super.key,
  });

  @override
  PantalladeUsuarioState createState() => PantalladeUsuarioState();
}

class PantalladeUsuarioState extends State<PantalladeUsuario> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => PantalladeMenuPrincipal(
                  driver: widget.driver,
                  trustedContact: widget.trustedContact,
                  place: widget.place,
                  passenger: widget.passenger,
                  email: widget.email,
                ),
              ),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const CircleAvatar(
              radius: 40,
              backgroundColor: Color(0xFFEDE7FE),
              child: Icon(Icons.person, size: 40, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Text(
              widget.passenger.passengerfirstName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.passenger.passengeremail,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFEDE7FE)),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.account_circle,
                        color: Color(0xFF0C1D60)),
                    title: const Text('My account'),
                    trailing: const Icon(Icons.arrow_forward_ios,
                        color: Colors.black),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PantalladeMiCuentadeUsuario(
                            driver: widget.driver,
                            trustedContact: widget.trustedContact,
                            place: widget.place,
                            passenger: widget.passenger,
                            email: widget.email,
                          ),
                        ),
                      );
                    },
                  ),
                  const Divider(height: 1, color: Color(0xFFEDE7FE)),
                  ListTile(
                    leading:
                        const Icon(Icons.campaign, color: Color(0xFF0C1D60)),
                    title: const Text('News'),
                    trailing: const Icon(Icons.arrow_forward_ios,
                        color: Colors.black),
                    onTap: () {
                      // Navegar a la pantalla de "News"
                      // (Pendiente implementar si deseas)
                    },
                  ),
                  const Divider(height: 1, color: Color(0xFFEDE7FE)),
                  ListTile(
                    leading:
                        const Icon(Icons.settings, color: Color(0xFF0C1D60)),
                    title: const Text('Settings'),
                    trailing: const Icon(Icons.arrow_forward_ios,
                        color: Colors.black),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PantalladeConfiguraciones(
                            driver: widget.driver,
                            trustedcontact: widget.trustedContact,
                            place: widget.place,
                            passenger: widget.passenger,
                            email: widget.email,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
