import 'package:flutter/material.dart';
import 'package:flutter_smartsecurity/Models/Passenger.dart';
import 'package:flutter_smartsecurity/PantalladeAgregarMiContacto.dart';
import 'package:flutter_smartsecurity/PantalladeMiCuentadeUsuario.dart';
import 'package:flutter_smartsecurity/Models/Driver.dart';
import 'package:flutter_smartsecurity/Models/Email.dart';
import 'package:flutter_smartsecurity/Models/TrustedContact.dart';
import 'package:flutter_smartsecurity/Models/Place.dart';
import 'package:flutter_smartsecurity/Services/TrustedContactService.dart';

class PantalladeMiContacto extends StatefulWidget {
  final Driver driver;
  final TrustedContact trustedContact;
  final Place place;
  final Passenger passenger;
  final Email email;

  const PantalladeMiContacto({
    required this.driver,
    required this.trustedContact,
    required this.place,
    required this.passenger,
    required this.email,
    super.key,
  });

  @override
  _PantalladeMiContactoState createState() => _PantalladeMiContactoState();
}

class _PantalladeMiContactoState extends State<PantalladeMiContacto> {
  final TrustedContactService trustedContactService = TrustedContactService();
  List<TrustedContact> contactos = [];
  TrustedContact? selectedContact;

  @override
  void initState() {
    super.initState();
    listarContactos();
  }

  void listarContactos() async {
    final lista = await trustedContactService.listarTrustedContacts();
    setState(() {
      contactos = lista;
    });
  }

  void buscarContactos(String query) async {
    if (query.isEmpty) {
      listarContactos();
    } else {
      final filtrados = await trustedContactService.buscarTrustedContact(query);
      setState(() {
        contactos = filtrados;
      });
    }
  }

  void confirmarEliminarContacto(TrustedContact contact) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title:
            const Text('Delete Contact', style: TextStyle(color: Colors.red)),
        content: const Text('Are you sure you want to delete this contact?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              if (contact.trustedContactID != null) {
                await trustedContactService
                    .eliminarTrustedContact(contact.trustedContactID!);
                Navigator.pop(context);
                listarContactos();
                setState(() => selectedContact = null);
              }
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  void seleccionarContacto(TrustedContact contact) {
    setState(() {
      selectedContact = contact;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => PantalladeMiCuentadeUsuario(
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
        title:
            const Text('Trusted Person', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Keep your friends or family in the loop',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            TextField(
              onChanged: buscarContactos,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Find your contact',
                filled: true,
                fillColor: Colors.purple[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: contactos.isEmpty
                  ? const Center(child: Text('No contacts found'))
                  : ListView.builder(
                      itemCount: contactos.length,
                      itemBuilder: (context, index) {
                        final contact = contactos[index];
                        final phoneDisplay =
                            '+${contact.trustedContactCodeCellPhone} ${contact.trustedContactCellPhone}';

                        return ListTile(
                          leading: const CircleAvatar(
                            backgroundColor: Colors.indigo,
                            child: Icon(Icons.person, color: Colors.white),
                          ),
                          title: Text(contact.trustedContactFullName),
                          subtitle: Text(phoneDisplay),
                          selected: selectedContact?.trustedContactID ==
                              contact.trustedContactID,
                          onTap: () => seleccionarContacto(contact),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PantallaDeAgregarMiContacto(
                      driver: widget.driver,
                      trustedcontact: TrustedContact(
                        trustedContactID: null,
                        trustedContactFullName: '',
                        trustedContactCodeCellPhone: 51,
                        trustedContactCellPhone: 0,
                        trustedContactEmail: '',
                      ),
                      place: widget.place,
                      passenger: widget.passenger,
                      email: widget.email,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: const Text('Add contact'),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: selectedContact != null
                  ? () => confirmarEliminarContacto(selectedContact!)
                  : null,
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red,
                side: const BorderSide(color: Colors.red),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: const Text('Delete contact'),
            ),
          ],
        ),
      ),
    );
  }
}
