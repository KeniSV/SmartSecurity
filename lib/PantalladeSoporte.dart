import 'package:flutter/material.dart';
import 'package:flutter_smartsecurity/Models/Driver.dart';
import 'package:flutter_smartsecurity/Models/Passenger.dart';
import 'package:flutter_smartsecurity/Models/TrustedContact.dart';
import 'package:flutter_smartsecurity/Models/Email.dart';
import 'package:flutter_smartsecurity/Models/Place.dart';
import 'package:flutter_smartsecurity/PantalladePreguntasFrecuentes.dart';
import 'package:flutter_smartsecurity/PantalladeTerminosyCondiciones.dart';
import 'package:flutter_smartsecurity/PantalladePoliticasdePrivacidad.dart';
import 'package:flutter_smartsecurity/PantalladeFormulariodeIncidentes.dart';

class PantalladeSoporte extends StatelessWidget {
  final Driver driver;
  final TrustedContact trustedContact;
  final Place place;
  final Passenger passenger;
  final Email email;

  const PantalladeSoporte({
    required this.driver,
    required this.trustedContact,
    required this.place,
    required this.passenger,
    required this.email,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Help Center',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'Resolve your doubt about  "SmartSecurity"',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            _buildSupportTile(
              icon: Icons.help_outline,
              title: 'Frequently asked questions',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PantalladePreguntasFrecuentes(
                      driver: driver,
                      trustedContact: trustedContact,
                      place: place,
                      passenger: passenger,
                      email: email,
                    ),
                  ),
                );
              },
            ),
            _buildSupportTile(
              icon: Icons.account_balance_outlined,
              title: 'Terms and Conditions',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PantalladeTerminosyCondiciones(
                      driver: driver,
                      trustedContact: trustedContact,
                      place: place,
                      passenger: passenger,
                      email: email,
                    ),
                  ),
                );
              },
            ),
            _buildSupportTile(
              icon: Icons.lock_outline,
              title: 'Privacy policy',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PantalladePoliticasdePrivacidad(
                      driver: driver,
                      trustedContact: trustedContact,
                      place: place,
                      passenger: passenger,
                      email: email,
                    ),
                  ),
                );
              },
            ),
            _buildSupportTile(
              icon: Icons.assignment_outlined,
              title: 'Complaints Form',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PantalladeFormulariodeIncidentes(
                      driver: driver,
                      trustedContact: trustedContact,
                      place: place,
                      passenger: passenger,
                      email: email,
                    ), // Acción para Complaints Form (puedes añadir aquí tu navegación)
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1, // Estás en Support
        onTap: (index) {
          if (index == 0) {
            Navigator.pop(context); // Regresa al MenuPrincipal
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Service',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.support_agent),
            label: 'Support',
          ),
        ],
        selectedItemColor: Color(0xFF0C1D60),
        unselectedItemColor: Colors.grey,
      ),
    );
  }

  Widget _buildSupportTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFEDE7FE),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(10),
        child: Icon(icon, color: Color(0xFF0C1D60)),
      ),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
