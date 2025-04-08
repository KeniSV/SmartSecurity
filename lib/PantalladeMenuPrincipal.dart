import 'package:flutter/material.dart';
import 'package:flutter_smartsecurity/PantalladeUsuario.dart';
import 'package:flutter_smartsecurity/Models/Driver.dart';
import 'package:flutter_smartsecurity/Models/TrustedContact.dart';
import 'package:flutter_smartsecurity/Models/Place.dart'; // Importa url_launcher
import 'package:url_launcher/url_launcher_string.dart'; // Importa url_launcher_string para launchUrlString

class PantalladeMenuPrincipal extends StatefulWidget {
  final Driver driver;
  final TrustedContact trustedContact;
  final Place place;

  PantalladeMenuPrincipal({
    required this.driver,
    required this.trustedContact,
    required this.place,
    Key? key,
  }) : super(key: key);

  @override
  _PantalladeMenuPrincipalState createState() =>
      _PantalladeMenuPrincipalState();
}

class _PantalladeMenuPrincipalState extends State<PantalladeMenuPrincipal> {
  bool isVoiceRecognitionActive = false;

  void enviarMensajeDeAyudaWhatsApp() async {
    final String numeroTelefono = '51994702577';
    final String mensaje = Uri.encodeComponent(
        '¡Necesito ayuda! Por favor, contáctame lo antes posible.');
    final String url = 'https://wa.me/$numeroTelefono?text=$mensaje';

    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'No se pudo enviar el mensaje a $numeroTelefono';
    }
  }

  void enviarMensajeDeAyudaSMS() async {
    final String numeroTelefono = '51994702577';
    final String mensaje = Uri.encodeComponent(
        '¡Necesito ayuda! Por favor, contáctame lo antes posible.');
    final String url = 'sms:$numeroTelefono?body=$mensaje';

    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'No se pudo enviar el mensaje a $numeroTelefono';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Sección del mapa
          Container(
            height: 250,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/map_placeholder.png'), // Imagen de mapa (Placeholder)
                fit: BoxFit.cover,
              ),
            ),
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: GestureDetector(
                  onTap: () {
                    // Acción al presionar el botón de perfil
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PantalladeUsuario(
                          driver: widget.driver,
                          trustedContact: widget.trustedContact,
                          place: widget.place,
                        ),
                      ),
                    );
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, color: Colors.black),
                  ),
                ),
              ),
            ),
          ),
          // Sección de contenido principal
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '¡Hi, User!',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Are you safe?',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        enviarMensajeDeAyudaWhatsApp();
                        enviarMensajeDeAyudaSMS();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(50),
                        backgroundColor: Colors.blueAccent, // Color del fondo
                        foregroundColor: Colors.indigo, // Color de sombra
                        elevation: 10,
                      ),
                      child: Text(
                        'HELP',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Switch(
                        value: isVoiceRecognitionActive,
                        onChanged: (value) {
                          setState(() {
                            isVoiceRecognitionActive = value;
                          });
                        },
                        activeColor: Colors.indigo,
                      ),
                      Text('Activate voice recognition'),
                    ],
                  ),
                  SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Enter your route',
                      filled: true,
                      fillColor: Colors.purple[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Service',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.support_agent),
            label: 'Support',
          ),
        ],
      ),
    );
  }
}
