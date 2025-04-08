import 'package:flutter/material.dart';
import 'package:flutter_smartsecurity/PantalladeAgregarMiContacto.dart';
import 'package:flutter_smartsecurity/PantalladeMiCuentadeUsuario.dart';
import 'package:flutter_smartsecurity/Models/Driver.dart';
import 'package:flutter_smartsecurity/Models/TrustedContact.dart';
import 'package:flutter_smartsecurity/Models/Place.dart';
import 'package:flutter_smartsecurity/Services/TrustedContactService.dart';

class PantalladeMiContacto extends StatefulWidget {
  final Driver driver;
  final TrustedContact trustedContact;
  final Place place;

  PantalladeMiContacto({
    required this.driver,
    required this.trustedContact,
    required this.place,
    Key? key,
  }) : super(key: key);

  @override
  _PantalladeMiContactoState createState() => _PantalladeMiContactoState();
}

class _PantalladeMiContactoState extends State<PantalladeMiContacto> {
  final TrustedContactService trustedContactService = TrustedContactService();
  List<TrustedContact> contactos = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    listarContactos();
  }

  void listarContactos() {
    setState(() {
      contactos = trustedContactService.listarTrustedContact();
    });
  }

  void buscarContactos(String query) {
    setState(() {
      searchQuery = query;
      contactos = trustedContactService.buscarTrustedContact(query);
    });
  }

  void eliminarContacto(int contactID) {
    trustedContactService.eliminarContacto(contactID);
    listarContactos();
  }

  void confirmarEliminarContacto(TrustedContact contact) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Contact'),
        content: Text(
            'Are you sure you want to delete ${contact.trustedContactFullName}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              eliminarContacto(contact.trustedContactID);
              Navigator.pop(context);
            },
            child: Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => PantalladeMiCuentadeUsuario(
                        driver: widget.driver,
                        trustedContact: widget.trustedContact,
                        place: widget.place)));
          },
        ),
        title: Text(
          'Trusted Person',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Keep your friends or family in the loop',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            SizedBox(height: 20),
            TextField(
              onChanged:
                  buscarContactos, //Llamar a buscar cuando cambia el texto
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Find your contact',
                filled: true,
                fillColor: Colors.purple[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: contactos.isEmpty
                  ? Center(
                      child: Text(
                        'No contacts found',
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: contactos.length,
                      itemBuilder: (context, index) {
                        final contact = contactos[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.indigo,
                            child: Icon(Icons.person, color: Colors.white),
                          ),
                          title: Text(contact.trustedContactFullName),
                          onTap: () => confirmarEliminarContacto(contact),
                        );
                      },
                    ),
            ),
            SizedBox(height: 20),
            Icon(
              Icons.group,
              size: 100,
              color: Colors.indigo,
            ),
            SizedBox(height: 10),
            Text(
              'Choose a friend or family member with whom you would like to share your travel information. We will send them the emergency message so they are informed of your trip.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navegar a PantalladeAgregarMiContacto
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PantallaDeAgregarMiContacto(
                            driver: widget.driver,
                            trustedcontact: widget.trustedContact,
                            place: widget.place,
                          )),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: Text('Add contact'),
            ),
            SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {
                // Acción para eliminar contacto
                if (contactos.isNotEmpty) {
                  eliminarContacto(contactos[0]
                      .trustedContactID); // Ejemplo: eliminar el primer contacto
                }
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red,
                side: BorderSide(color: Colors.red),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: Text('Delete contact'),
            ),
          ],
        ),
      ),
    );
  }
}
