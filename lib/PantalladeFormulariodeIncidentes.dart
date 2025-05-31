import 'package:flutter/material.dart';
import 'package:flutter_smartsecurity/Models/Driver.dart';
import 'package:flutter_smartsecurity/Models/Passenger.dart';
import 'package:flutter_smartsecurity/Models/TrustedContact.dart';
import 'package:flutter_smartsecurity/Models/Place.dart';
import 'package:flutter_smartsecurity/Models/Email.dart';
import 'package:flutter_smartsecurity/Services/EmailService.dart';
import 'package:flutter_smartsecurity/PantalladeSoporte.dart';

class PantalladeFormulariodeIncidentes extends StatefulWidget {
  final Driver driver;
  final TrustedContact trustedContact;
  final Place place;
  final Passenger passenger;
  final Email email;

  const PantalladeFormulariodeIncidentes({
    required this.driver,
    required this.trustedContact,
    required this.place,
    required this.passenger,
    required this.email,
    super.key,
  });

  @override
  State<PantalladeFormulariodeIncidentes> createState() =>
      _PantalladeFormulariodeIncidentesState();
}

class _PantalladeFormulariodeIncidentesState
    extends State<PantalladeFormulariodeIncidentes> {
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final EmailService emailService = EmailService();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(
        text:
            "${widget.passenger.passengerfirstName} ${widget.passenger.passengerlastname}");
    emailController =
        TextEditingController(text: widget.passenger.passengeremail);
  }

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
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'Complaints Form',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildInputField(
              label: 'Name',
              hint: 'Write your full name',
              controller: nameController,
              enabled: false,
            ),
            _buildInputField(
              label: 'Email address',
              hint: 'Write your email address',
              controller: emailController,
              enabled: false,
            ),
            _buildInputField(
              label: 'Subject',
              hint: 'Write the subject of your incident',
              controller: subjectController,
            ),
            _buildInputField(
              label: 'Description',
              hint: 'Write the description of your incident',
              controller: descriptionController,
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _confirmarEnvio,
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

  Future<void> _confirmarEnvio() async {
    if (subjectController.text.isEmpty || descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    final confirm = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Submit Incident',
              style: TextStyle(color: Colors.red)),
          content: const Text('Are you sure you want to send the incident?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel', style: TextStyle(color: Colors.blue)),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Yes', style: TextStyle(color: Colors.blue)),
            ),
          ],
        );
      },
    );

    if (confirm != true) return;

    final incidente = Email(
      emailID: DateTime.now().millisecondsSinceEpoch,
      subjectEmail: subjectController.text,
      descriptionEmail: descriptionController.text,
      passengerID: widget.passenger.passengerID ?? 0,
      passengerfirstName: widget.passenger.passengerfirstName,
      passengerlastname: widget.passenger.passengerlastname,
      passengeremail: widget.passenger.passengeremail,
      passengerdocumentID: widget.passenger.passengerdocumentID,
      passengerdocumentType: widget.passenger.passengerdocumentType,
      passengercellPhone: widget.passenger.passengercellPhone,
      passengercodecellPhone: widget.passenger.passengercodecellPhone,
      passengerpassword: widget.passenger.passengerpassword,
      isActive: widget.passenger.isActive,
      lastLogin: DateTime.now(), // reemplazo válido
    );

    await emailService.crearEmail(incidente);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Incident sent successfully')),
    );

    subjectController.clear();
    descriptionController.clear();
  }

  Widget _buildInputField({
    required String label,
    required String hint,
    required TextEditingController controller,
    bool enabled = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          enabled: enabled,
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
