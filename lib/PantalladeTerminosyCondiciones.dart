import 'package:flutter/material.dart';
import 'package:flutter_smartsecurity/Models/Driver.dart';
import 'package:flutter_smartsecurity/Models/Email.dart';
import 'package:flutter_smartsecurity/Models/Passenger.dart';
import 'package:flutter_smartsecurity/Models/TrustedContact.dart';
import 'package:flutter_smartsecurity/Models/Place.dart';
import 'package:flutter_smartsecurity/PantalladeSoporte.dart';

class PantalladeTerminosyCondiciones extends StatelessWidget {
  final Driver driver;
  final TrustedContact trustedContact;
  final Place place;
  final Passenger passenger;
  final Email email;

  const PantalladeTerminosyCondiciones({
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => PantalladeSoporte(
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
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Terms and Conditions',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: const Color(0xFFEDE7FE),
            borderRadius: BorderRadius.circular(16),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  '1. Acceptance of Terms\n'
                  'By downloading, installing, and using the SmartSecurity application, the user expressly accepts the terms and conditions set forth in this document. Use of the application implies full acceptance of these provisions.\n',
                ),
                Text(
                  '2. Responsible Use of the Service\n'
                  '• The user agrees to use SmartSecurity exclusively for assistance in personal emergency situations involving taxi services.\n'
                  '• Misuse of the application, such as generating false alarms, simulating emergencies, and using it for illicit purposes, will be the sole responsibility of the user.\n'
                  '• It is the users obligation to keep their personal data, emergency contacts, and registered locations up to date.\n',
                ),
                Text(
                  '3. Application Functionality\n'
                  '• Voice Recognition: The system passively listens to the configured keyword, without storing or recording full conversations. Processing is done in real time using Deep Learning algorithms.\n'
                  '• Geolocation: Only activated when the user enters the emergency keyword.\n'
                  '• Emergency Alerts: Automatic messages and calls are sent to trusted contacts. user-defined, including real-time location.\n',
                ),
                Text(
                  '4. Limitations of Liability\n'
                  'SmartSecurity does not guarantee immediate effectiveness in responding to emergencies due to external factors such as:\n'
                  '• Connectivity failures (internet, mobile networks).\n'
                  '• Location errors (blocked GPS, interference).\n'
                  '• Technical problems with third-party services (WhatsApp, Google Cloud).\n'
                  '• The application does not replace the intervention of law enforcement or emergency authorities.\n',
                ),
                Text(
                  '5. Updates and Modifications\n'
                  'SmartSecurity developers may periodically make updates to improve security, optimize performance, and comply with new regulations.\n'
                  'Updates will be communicated through the application or official means.\n',
                ),
                Text(
                  '6. Intellectual Property\n'
                  'All content, design, source code, AI models (Whisper, NLP), SmartSecurity databases and graphic elements are the exclusive property of their developers.\n'
                  'Unauthorized reproduction, distribution, or exploitation is prohibited.\n',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
