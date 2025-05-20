import 'package:flutter/material.dart';
import 'package:flutter_smartsecurity/Models/Passenger.dart';
import 'package:flutter_smartsecurity/Models/TrustedContact.dart';
import 'package:flutter_smartsecurity/Models/Driver.dart';
import 'package:flutter_smartsecurity/Models/Place.dart';
import 'package:flutter_smartsecurity/Models/Email.dart';
import 'package:flutter_smartsecurity/PantalladeMiContacto.dart';
import 'package:flutter_smartsecurity/Services/TrustedContactService.dart';

class PantallaDeAgregarMiContacto extends StatefulWidget {
  final Driver driver;
  final TrustedContact trustedcontact;
  final Place place;
  final Passenger passenger;
  final Email email;

  const PantallaDeAgregarMiContacto({
    required this.driver,
    required this.trustedcontact,
    required this.place,
    required this.passenger,
    required this.email,
    super.key,
  });

  @override
  _PantallaDeAgregarMiContactoState createState() =>
      _PantallaDeAgregarMiContactoState();
}

class _PantallaDeAgregarMiContactoState
    extends State<PantallaDeAgregarMiContacto> {
  final TrustedContactService trustedContactService = TrustedContactService();

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController cellPhoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  String selectedCode = '+51'; // Valor inicial para evitar problemas

  @override
  void initState() {
    super.initState();
    fullNameController.text = widget.trustedcontact.trustedContactFullName;
    cellPhoneController.text =
        widget.trustedcontact.trustedContactCellPhone.toString();
    emailController.text = widget.trustedcontact.trustedContactEmail;

    // Verificar que el código seleccionado esté en la lista de opciones
    selectedCode = [
      '+1',
      '+51',
      '+44',
      '+91'
    ].contains(widget.trustedcontact.trustedContactCodeCellPhone.toString())
        ? widget.trustedcontact.trustedContactCodeCellPhone.toString()
        : '+51';
  }

  void agregarContacto() {
    final nuevoContacto = TrustedContact(
      trustedContactID: DateTime.now().millisecondsSinceEpoch,
      trustedContactFullName: fullNameController.text,
      trustedContactCodeCellPhone: int.tryParse(selectedCode) ?? 51,
      trustedContactCellPhone: int.tryParse(cellPhoneController.text) ?? 0,
      trustedContactEmail: emailController.text,
    );

    trustedContactService.agregarContacto(nuevoContacto);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => PantalladeMiContacto(
          driver: widget.driver,
          trustedContact: nuevoContacto,
          place: widget.place,
          passenger: widget.passenger,
          email: widget.email,
        ),
      ),
    );
  }

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
                builder: (context) => PantalladeMiContacto(
                  driver: widget.driver,
                  trustedContact: widget.trustedcontact,
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
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'My contact',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'My contact information',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: fullNameController,
              decoration: InputDecoration(
                hintText: 'Trusted person',
                filled: true,
                fillColor: const Color(0xFFEDE7FE),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEDE7FE),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      underline: const SizedBox(),
                      value: selectedCode,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedCode = newValue!;
                        });
                      },
                      items: <String>['+1', '+51', '+44', '+91']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: cellPhoneController,
                    decoration: InputDecoration(
                      hintText: 'Cell phone',
                      filled: true,
                      fillColor: const Color(0xFFEDE7FE),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Email',
                filled: true,
                fillColor: const Color(0xFFEDE7FE),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0C1D60),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: agregarContacto,
                child: const Text(
                  'Save',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
