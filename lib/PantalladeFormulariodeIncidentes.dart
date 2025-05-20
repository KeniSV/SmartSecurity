import 'package:flutter/material.dart';
import 'package:flutter_smartsecurity/Models/Driver.dart';
import 'package:flutter_smartsecurity/Models/Passenger.dart';
import 'package:flutter_smartsecurity/Models/TrustedContact.dart';
import 'package:flutter_smartsecurity/Models/Place.dart';
import 'package:flutter_smartsecurity/Models/Email.dart';
import 'package:flutter_smartsecurity/Services/EmailService.dart';
import 'package:flutter_smartsecurity/PantalladeSoporte.dart';

class PantalladeFormulariodeIncidentes extends StatelessWidget {
  final Driver driver;
  final TrustedContact trustedContact;
  final Place place;
  final Passenger passenger;
  final Email email;

  PantalladeFormulariodeIncidentes({
    required this.driver,
    required this.trustedContact,
    required this.place,
    required this.passenger,
    required this.email,
    super.key,
  });

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final EmailService emailService = EmailService(); // Instancia de EmailService

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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'Complaints Form',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            _buildInputField(
                label: 'Name',
                hint: 'Write your full name',
                controller: nameController),
            _buildInputField(
                label: 'Email address',
                hint: 'Write your email address',
                controller: emailController),
            _buildInputField(
                label: 'Subject',
                hint: 'Write the subject of your incident',
                controller: subjectController),
            _buildInputField(
                label: 'Description',
                hint: 'Write the description of your incident',
                controller: descriptionController),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (subjectController.text.isEmpty ||
                      descriptionController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Please fill in all fields')),
                    );
                    return;
                  }

                  // Crear el Email con la información
                  final incidente = Email(
                    emailID: DateTime.now()
                        .millisecondsSinceEpoch, // ID único por timestamp
                    subjectEmail: subjectController.text,
                    descriptionEmail: descriptionController.text,
                    //Heredados de Passenger
                    passengerID: passenger.passengerID,
                    passengerfirstName: nameController.text,
                    passengerlastname: nameController.text,
                    passengeremail: emailController.text,
                    passengerdocumentID: passenger.passengerdocumentID,
                    passengerdocumentType: passenger.passengerdocumentType,
                    passengercellPhone: passenger.passengercellPhone,
                    passengercodecellPhone: passenger.passengercodecellPhone,
                    passengerpassword: passenger.passengerpassword,
                    isActive: passenger.isActive,
                    lastLogin: passenger.lastLogin,
                  );

                  // Agregar el incidente al servicio
                  emailService.agregarIncidente(incidente);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Incident sent successfully')),
                  );

                  // Limpiar campos
                  nameController.clear();
                  emailController.clear();
                  subjectController.clear();
                  descriptionController.clear();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0C1D60),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Send',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required String hint,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: const Color(0xFFEDE7FE),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
