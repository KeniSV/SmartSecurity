import 'package:flutter/material.dart';
import 'package:flutter_smartsecurity/PantalladeMiInformaciondeCuentadeUsuario.dart';
import 'package:flutter_smartsecurity/PantalladeMiContacto.dart';
import 'package:flutter_smartsecurity/PantalladeMiLugar.dart';
import 'package:flutter_smartsecurity/PantalladeMiLenguaje.dart';
import 'package:flutter_smartsecurity/PantalladeUsuario.dart';
import 'package:flutter_smartsecurity/Models/Driver.dart';
import 'package:flutter_smartsecurity/Models/TrustedContact.dart';
import 'package:flutter_smartsecurity/Models/Place.dart';
import 'package:flutter_smartsecurity/Models/Passenger.dart';
import 'package:flutter_smartsecurity/Models/Email.dart';

class PantalladeMiCuentadeUsuario extends StatefulWidget {
  final Driver driver;
  final TrustedContact trustedContact;
  final Place place;
  final Passenger passenger;
  final Email email;

  const PantalladeMiCuentadeUsuario({
    required this.driver,
    required this.trustedContact,
    required this.place,
    required this.passenger,
    required this.email,
    super.key,
  });

  @override
  _PantalladeMiCuentadeUsuarioState createState() =>
      _PantalladeMiCuentadeUsuarioState();
}

class _PantalladeMiCuentadeUsuarioState
    extends State<PantalladeMiCuentadeUsuario> {
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
                  builder: (context) => PantalladeUsuario(
                        driver: widget.driver,
                        trustedContact: widget.trustedContact,
                        place: widget.place,
                        passenger: widget.passenger,
                        email: widget.email,
                      )),
            ); // Acción para retroceder
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
            // Encabezado
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '¡Hi, User!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Ready to be safe?',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Color(0xFFEDE7FE),
                  child: Icon(Icons.person, color: Colors.black),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Opciones de menú
            ListTile(
              leading: const Icon(Icons.person, color: Color(0xFF0C1D60)),
              title: const Text('My data'),
              subtitle: const Text('Edit email, password ...'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navegar a la pantalla de "My data"
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PantalladeMiInformaciondeCuentadeUsuario(
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
            const Divider(),
            ListTile(
              leading: const Icon(Icons.people, color: Color(0xFF0C1D60)),
              title: const Text('Trusted person'),
              subtitle: const Text('Share all your trips'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navegar a la pantalla de "Trusted person"
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PantalladeMiContacto(
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
            const Divider(),
            ListTile(
              leading: const Icon(Icons.favorite, color: Color(0xFF0C1D60)),
              title: const Text('My places'),
              subtitle: const Text('Save your favorite places'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navegar a la pantalla de "My places"
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PantalladeMiLugar(
                        driver: widget.driver,
                        trustedcontact: widget.trustedContact,
                        place: widget.place),
                  ),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.language, color: Color(0xFF0C1D60)),
              title: const Text('My language'),
              subtitle: const Text('Select your language'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navegar a la pantalla de "My language"
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PantallaDeMiLenguaje(
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
            const Divider(),
          ],
        ),
      ),
    );
  }
}
