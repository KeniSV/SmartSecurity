import 'package:flutter/material.dart';
import 'package:flutter_smartsecurity/PantalladeMenuPrincipal.dart';
import 'package:flutter_smartsecurity/PantalladeMiCuentadeUsuario.dart';
import 'package:flutter_smartsecurity/PantalladeConfiguraciones.dart';
import 'package:flutter_smartsecurity/Models/Driver.dart';
import 'package:flutter_smartsecurity/Models/TrustedContact.dart';
import 'package:flutter_smartsecurity/Models/Place.dart';

class PantalladeUsuario extends StatefulWidget {
  final Driver driver;
  final TrustedContact trustedContact;
  final Place place;

  PantalladeUsuario({
    required this.driver,
    required this.trustedContact,
    required this.place,
    Key? key,
  }) : super(key: key);

  @override
  _PantalladeUsuarioState createState() => _PantalladeUsuarioState();
}

class _PantalladeUsuarioState extends State<PantalladeUsuario> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => PantalladeMenuPrincipal(
                        driver: widget.driver,
                        trustedContact: widget.trustedContact,
                        place: widget.place)));
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 40,
              backgroundColor: Color(0xFFEDE7FE),
              child: Icon(Icons.person, size: 40, color: Colors.grey),
            ),
            SizedBox(height: 16),
            Text(
              'Username',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'example@email.com',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(0xFFEDE7FE)),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading:
                        Icon(Icons.account_circle, color: Color(0xFF0C1D60)),
                    title: Text('My account'),
                    trailing:
                        Icon(Icons.arrow_forward_ios, color: Colors.black),
                    onTap: () {
                      // Navegar a la pantalla de "My account"
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PantalladeMiCuentadeUsuario(
                            driver: widget.driver,
                            trustedContact: widget.trustedContact,
                            place: widget.place,
                          ),
                        ),
                      );
                    },
                  ),
                  Divider(height: 1, color: Color(0xFFEDE7FE)),
                  ListTile(
                    leading: Icon(Icons.campaign, color: Color(0xFF0C1D60)),
                    title: Text('News'),
                    trailing:
                        Icon(Icons.arrow_forward_ios, color: Colors.black),
                    onTap: () {
                      // Navegar a la pantalla de "News"
                    },
                  ),
                  Divider(height: 1, color: Color(0xFFEDE7FE)),
                  ListTile(
                    leading: Icon(Icons.settings, color: Color(0xFF0C1D60)),
                    title: Text('Settings'),
                    trailing:
                        Icon(Icons.arrow_forward_ios, color: Colors.black),
                    onTap: () {
                      // Navegar a la pantalla de "Settings"
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PantalladeConfiguraciones(
                            driver: widget.driver,
                            trustedcontact: widget.trustedContact,
                            place: widget.place,
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
