import 'package:flutter/material.dart';
import 'package:flutter_smartsecurity/PantalladeRegistrodeUsuario.dart';
import 'package:flutter_smartsecurity/PantalladeRegistrodeUsuarioNuevo.dart';
import 'package:flutter_smartsecurity/Models/Passenger.dart';
import 'package:flutter_smartsecurity/Models/Driver.dart';
import 'package:flutter_smartsecurity/Models/TrustedContact.dart';
import 'package:flutter_smartsecurity/Models/Place.dart';
import 'package:flutter_smartsecurity/Models/Email.dart';

class PantalladeInicio extends StatelessWidget {
  final Passenger passenger;
  final Driver driver;
  final TrustedContact trustedContact;
  final Place place;
  final Email email;

  const PantalladeInicio({
    Key? key,
    required this.passenger,
    required this.driver,
    required this.trustedContact,
    required this.place,
    required this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Parte superior (Ciudad) - Sólido
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.indigo[700],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.shield_outlined,
                      size: 100,
                      color: Colors.cyanAccent,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'SMART SECURITY',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.cyanAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Parte inferior (Mapa) - Sólido
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.indigo[900],
              child: const Center(
                child: Icon(
                  Icons.map_outlined,
                  size: 80,
                  color: Colors.white24,
                ),
              ),
            ),
          ),
          // Botón Log in y link Sign up
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PantalladeRegistrodeUsuario(
                          passenger: passenger,
                          driver: driver,
                          trustedContact: trustedContact,
                          place: place,
                          email: email,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.indigo,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Log in',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don’t have an account? ",
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PantalladeRegistrodeUsuarioNuevo(
                              passenger: passenger,
                              driver: driver,
                              trustedContact: trustedContact,
                              place: place,
                              email: email,
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.indigo[900],
    );
  }
}
