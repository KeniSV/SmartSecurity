import 'package:flutter/material.dart';
import 'package:flutter_smartsecurity/Models/Driver.dart';
import 'package:flutter_smartsecurity/Models/Passenger.dart';
import 'package:flutter_smartsecurity/Models/TrustedContact.dart';
import 'package:flutter_smartsecurity/Models/Place.dart';
import 'package:flutter_smartsecurity/Models/Email.dart';
import 'package:flutter_smartsecurity/PantalladeSoporte.dart';

class PantalladePoliticasdePrivacidad extends StatelessWidget {
  final Driver driver;
  final TrustedContact trustedContact;
  final Place place;
  final Passenger passenger;
  final Email email;

  const PantalladePoliticasdePrivacidad({
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
          'Privacy policy',
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
                  '1. Data Controller\n'
                  'SmartSecurity is responsible for the processing of personal data collected through the application, in compliance with Law No. 29733 - Personal Data Protection Law of Peru.\n',
                ),
                Text(
                  '2. Personal Data Collected\n'
                  '• Full name.\n'
                  '• Email Address.\n'
                  '• Phone number.\n'
                  '• ID.\n'
                  '• Geographic location (only dyring emergencies).\n'
                  '• Configured keywords (detected only, no stored).\n',
                ),
                Text(
                  '3. Purpose of Processing\n'
                  '• Provide assistance in cases of criminal acts in taxi services.\n'
                  '• Activate emergency protocols through voice recognition.\n'
                  '• Share real-time location with trusted contacts.\n'
                  '• Manage users, contacts, and frequented locations.\n'
                  '• Improve user experience through anonymous usage analysis (without compromising privacy).\n',
                ),
                Text(
                  '4. Legal Basis for Processing\n'
                  '• Explicit consent of the user upon registration in the application.\n'
                  '• Compliance with legal obligations regarding data protection.\n',
                ),
                Text(
                  '5. Storage and Security\n'
                  '• Data is stored on Google Cloud Platform, under security measures aligned with:\n'
                  '  - ISO 27001 (Information Security).\n'
                  '  - ISO/IEC 27701 (Privacy Management).\n'
                  '  - NIST Privacy Framework.\n'
                  '• Encryption techniques, secure authentication, and restricted access policies are applied.\n',
                ),
                Text(
                  '6. Data Sharing\n'
                  '• Personal data is not shared with third parties for commercial or advertising purposes.\n'
                  '• Only strictly necessary third-party services (WhatsApp API, Google Maps API) are integrated for the applications functionality\n',
                ),
                Text(
                  '7. User Rights\n'
                  '• The user may exercise at any time:\n'
                  '  - Accesss their personal data.\n'
                  '  - Rectify inaccurate information.\n'
                  '  - Deletionof their account and associated data.\n'
                  '  - Object to data processing if deemed necessary.\n'
                  '• All through the support section, secure authentication, and forms within the application.\n',
                ),
                Text(
                  '8. Data Retention\n'
                  '• Personal data will be retained as long as the user maintains an active account.\n'
                  '• Once the account is deleted, the data will be securely deleted within a maximum of 30 days.\n',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
