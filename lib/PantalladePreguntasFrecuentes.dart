import 'package:flutter/material.dart';
import 'package:flutter_smartsecurity/Models/Driver.dart';
import 'package:flutter_smartsecurity/Models/Passenger.dart';
import 'package:flutter_smartsecurity/Models/TrustedContact.dart';
import 'package:flutter_smartsecurity/Models/Place.dart';
import 'package:flutter_smartsecurity/Models/Email.dart';
import 'package:flutter_smartsecurity/PantalladeSoporte.dart';

class PantalladePreguntasFrecuentes extends StatelessWidget {
  final Driver driver;
  final TrustedContact trustedContact;
  final Place place;
  final Passenger passenger;
  final Email email;

  const PantalladePreguntasFrecuentes({
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
          'Frequently asked questions',
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
                  '1. What is SmartSecurity?\n'
                  'SmartSecurity is a mobile application designed to provide rapid assistance in dangerous situations when using taxi services. Allows you to activate emergency alerts using a custom keyword, sending your location to trusted contacts and authorities.\n',
                ),
                Text(
                  '2. How do I set my security keyword?\n'
                  'In the “Settings” section, you can define a keyword that the app will detect using voice recognition. When you say it, the emergency protocol will be automatically and discreetly activated.\n',
                ),
                Text(
                  '3. 3. What happens when the keyword is detected?\n'
                  'The app activates the following actions:\n'
                  '• Turns on GPS to obtain your real-time location.\n'
                  '• Sends a distress message to your emergency contacts.\n'
                  '• Makes an automatic call if necessary.\n',
                ),
                Text(
                  '4. How can I add emergency contacts?\n'
                  'In the “Trusted Contacts” section, you can register people who will be notified in case of emergency. You just need to enter their name, phone number, and email address.\n',
                ),
                Text(
                  '5. Do I need internet access for the app to work?\n'
                  'Yes, an internet connection (mobile data or Wi-Fi) is required to send messages, share your location, and make calls through the app.\n',
                ),
                Text(
                  '6. Can I record my frequent locations?\n'
                  'Yes, you can record favorite places like your home, work, or points of interest. This will make it easier to manage safe routes and quickly trigger alerts.\n',
                ),
                Text(
                  '7. Is my personal data protected?\n'
                  'Yes, SmartSecurity complies with the Personal Data Protection Law (Law No. 29733) and the ISO 27001 and ISO/IEC 27701 standards, ensuring the privacy and protection of your information.\n',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
